//==========================================================================================

void loadMovieFile(int passedID, String passedFilePath)
{
  movieFile[passedID] = new Movie(this, passedFilePath);
}

//==========================================================================================

void OutputTransmissionThread() //threaded transmission
{
  println("SendPixelBuffer() thread started");

  color tempColor;
  byte myRed, myGreen, myBlue;
  int x = 0;

  delay(1000); //wait to start transmitting after thread is started

  if (matrix.auroraCMD == true)
  {
    println("Attempting NLED Aurora live control connection");
    try {
      serialPort.write("N"); 
      serialPort.write("L");  
      serialPort.write("E");   
      serialPort.write("D");  
      serialPort.write("1");   
      serialPort.write("1");      
      delay(5);
      serialPort.write("n"); 
      serialPort.write("l");  
      serialPort.write("e");   
      serialPort.write("d");  
      serialPort.write("9");   
      serialPort.write("9");
      delay(5);  
      serialPort.write(60);  //Live Mode Command
      serialPort.write(1);   //Enable Live Mode
      serialPort.write(0); 
      serialPort.write((PatchedChannels >> 8) & 0xFF); //MSB
      serialPort.write(PatchedChannels & 0xFF);     //LSB
      println("NLED Aurora connection successful");
    }
    catch(Exception e) { 
      println("No COM Port open to send NLED Aurora Live Control CMD to");
    }
  }


  //intial wait til first frame is ready
  while (PacketReadyForTransmit == false)
  {
    delay(1);
  } //end wait while()

  println("SendPixelBuffer() First Packet is Ready");
  //println("TotalPixels: "+TotalPixels+"    Length: "+TransmissionArray.length);

  while (true)
  {
    x = 0; //clear everytime a packet is built

    //transmitPixelBuffer = MixedContentGBuf.get(); //convert from PGraphics to PImage for transmission by reading pixels[]  

    //for (int i = 0; i <= TransmissionArray.length; i++)
    for (int i = 0; i < TotalPixels; i++)
    {
      tempColor = transmitPixelBuffer.get(PatchCoordX[i], PatchCoordY[i]);
      //convert colors to 8-bit
      //get the pixel color out of the graphics buffer
      myRed = byte((tempColor >> 16 & 0xFF) * MasterIntensity);
      myGreen = byte((tempColor >> 8 & 0xFF) * MasterIntensity);
      myBlue = byte((tempColor & 0xFF) * MasterIntensity);    


      //if Geldiator protocol, 1 is reserved for packet framing, so any 1's set to 0
      if (matrix.transmissionType == 2)
      {
        if (myRed == 1) myGreen = 0; 
        if (myGreen == 1) myGreen = 0; 
        if (myBlue == 1) myGreen = 0;
      }

      //need to add the rest
      switch(matrix.colorOrderID)
      {
      case 0://RGB
        TransmissionArray[x++] = myRed;
        TransmissionArray[x++] = myGreen;  
        TransmissionArray[x++] = myBlue;    
        break;
      case 1: //BRG
        TransmissionArray[x++] = myBlue;
        TransmissionArray[x++] = myRed;  
        TransmissionArray[x++] = myGreen;          
        break;
      case 2: //GBR
        break;
      case 3: //RBG
        break;
      case 4: //BGR
        break;
      case 5:      //WS2812B - GRB
        TransmissionArray[x++] = myGreen;
        TransmissionArray[x++] = myRed;  
        TransmissionArray[x++] = myBlue;     
        break;
      } //end switch
    } //end for()

    //now do dithering/gamma correction by editing  TransmissionArray, note they are signed bytes, so careful typecasting

    //transmissionType; //0: none, 1: NLED serial, 2: glediator serial, 3: TCP, 4: UDP, ??
    if (matrix.transmissionType == 2)  serialPort.write(1); //if glediator output add leading 1
    if (matrix.transmissionType == 1 || matrix.transmissionType == 2) serialPort.write(TransmissionArray); //end it out

    if(recordToFileButton.selected == true) thread("FileRecoderAddFrame"); //record to file if enabled

    //packet sent or is transmitting
    PacketReadyForTransmit = false; //clear the flag

    //wait here until next frame is ready for transmission
    while (PacketReadyForTransmit == false)
    {
      delay(1);
    } //end wait while()

    //Will also wait for correct timing, want a packet to be updated and within the required time

    //println("Transmission thread sent packet "+millis());
  } //end forever while()
} //end func

//=======================================================================================================

void FileRecoderAddFrame()  //called threaded from the output transmission thread
{
  //Takes the received packet, and writes all the values as single comma delimeted line
  //Doubt this is the most efficent way to do it. But works well enough
 // println("FileRecoderAddFrame()");
 
  try 
  {
    fw = new FileWriter(sketchPath(File.separator+"recorded"+File.separator+RecorderFileName+".txt"), true); // true means: "append"
    bw = new BufferedWriter(fw);
    for (int i = 0; i != PatchedChannels; i++)
    {
      bw.write(str(TransmissionArray[i] & 0xFF)+","); //the & 0xFF converts the signed byte to unsigned so it can be converted to a string
    }
    bw.newLine(); //add a new line for the next packet / frame.
  } 
  catch (IOException e) 
  {
    // Report problem or handle it

  }
  finally
  {
    if (bw != null)
    {
      try { 
        bw.close();
      } 
      catch (IOException e) {
      }
    }
  }
}

//=============================================================================================================
