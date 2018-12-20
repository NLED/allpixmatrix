//==========================================================================================

void loadMovieFile(int passedID, String passedFilePath)
{
  movieFile[passedID] = new Movie(this, passedFilePath);
}

//==========================================================================================

void EstablishOutputConnection()
{
	printArray(Serial.list());

  //loads external serial data input - such as glediator
  matrix.externalDataRunning = false; //initialize false

  if (matrix.externalDataEnable == true) //trys to connect to the external datastream, from a serial port, virtual or physical
  {
    //incase of a reconnection, make sure to close the port first
    try {
      externalSerialPort.stop();
    }
    catch(Exception e) { 
      println("No External Data Port To Close");
    }

    //Resize this now or will error and disable the port when data starts being received
    ExternalDataArray = new short[(matrix.width * matrix.height) * 3];  //comes in full size, no patch yet. 3 is for RGB - needs update for single or RGBW

    try {
      ExternalDataCounter = 0; //reset variable incase of reconnection
      ExternalDataFramed = false;  //reset variable incase of reconnection

      externalSerialPort = new Serial(this, Serial.list()[matrix.externalDataPort], matrix.externalDataBaud);
      println("externalDataSerialPort opened "+Serial.list()[matrix.externalDataPort]+" at "+matrix.externalDataBaud+" baud.");
      matrix.externalDataRunning = true;
    }
    catch(Exception e) { 
      println("External Data Port Could Not Be Opened, Function will not work."); 
      matrix.externalDataRunning = false;
    }
  } //end externalDataEnable if
  //end external data

  //only serial mode enabled as of now
  switch(matrix.transmissionType)
  {
  case 0: //none

    break;
  case 1: //NLED Serial
  case 2: //Glediator Serial
    try {
      serialPort.stop();
    }
    catch(Exception e) { 
      println("No Serial Port To Close");
    }

    try {
        serialPort = new Serial(this, Serial.list()[matrix.serialPortNum], matrix.serialBaud);
        println("Opened serial port: "+Serial.list()[matrix.serialPortNum]+" at "+matrix.serialBaud+" baud.");
    }
    catch(Exception e)
    {
          matrix.transmissionType = 0; //new BETA 0.2
          println("Could not open output serial data port");
    }

    break;
  case 3:

    break;
  } //end switch

   //Rerun this if using the "Reload Configs" button, transmission thread will send it when the thread starts
  if (matrix.auroraCMD == true) RequestAuroraProtocolLiveMode();
}

//=============================================================================================================

void RequestAuroraProtocolLiveMode()
{
    println("Attempting NLED Aurora live control connection");
    //Sends the command for bulk live control using the NLED protocol
    try {
      serialPort.write("N"); 
      serialPort.write("L");  
      serialPort.write("E");   
      serialPort.write("D");  
      serialPort.write("1");   
      serialPort.write("1");      
      delay(5); //controller will send acknowledge, ignore it and assume it was received
      serialPort.write("n"); 
      serialPort.write("l");  
      serialPort.write("e");   
      serialPort.write("d");  
      serialPort.write("9");   
      serialPort.write("9");
      delay(5);  //controller will send acknowledge, ignore it and assume it was received
      serialPort.write(60);  //Live Mode Command
      serialPort.write(1);   //Enable Live Mode
      serialPort.write(0); 
      serialPort.write((matrix.patchedChannels >> 8) & 0xFF); //MSB
      serialPort.write(matrix.patchedChannels & 0xFF);     //LSB
      println("NLED Aurora connection successful");
    }
    catch(Exception e) { 
      println("No COM Port open to send NLED Aurora Live Control CMD to");
    }
}

//=============================================================================================================

void OutputTransmissionThread() //threaded transmission
{
  println("SendPixelBuffer() thread started");

  color tempColor;
  byte myRed, myGreen, myBlue;
  int x = 0;
  int holdMillisOutput = millis();
  byte[] dmxData = new byte[512]; //used to copy blocks of data, would rather use a pointer
	
  delay(1000); //wait to start transmitting after thread is started

  if (matrix.auroraCMD == true) RequestAuroraProtocolLiveMode();

  
  if(matrix.transmissionType == 3)
  {
	// create artnet client without buffer (no receving needed)
	artnetServer = new ArtNetClient(null);
	artnetServer.start();
  }
  
  //intial wait til first frame is ready
  while (PacketReadyForTransmit == false)
  {
    delay(1);
  } //end wait while()

  println("SendPixelBuffer() First Packet is Ready");
  //println("matrix.totalPixels: "+matrix.totalPixels+"    Length: "+TransmissionArray.length);

  while (true)
  {
    x = 0; //clear everytime a packet is built

	//println("tick "+millis());
    //transmitPixelBuffer = MixedContentGBuf.get(); //convert from PGraphics to PImage for transmission by reading pixels[]  

    //for (int i = 0; i <= TransmissionArray.length; i++)
    for (int i = 0; i < matrix.totalPixels; i++)
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

      //apply the color order, if the controller is doing the color order, use RGB here
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
        TransmissionArray[x++] = myGreen;
        TransmissionArray[x++] = myBlue;  
        TransmissionArray[x++] = myRed;         
        break;
      case 3: //RBG
         TransmissionArray[x++] = myRed;
        TransmissionArray[x++] = myBlue;  
        TransmissionArray[x++] = myGreen;       
        break;
      case 4: //BGR
        TransmissionArray[x++] = myBlue;
        TransmissionArray[x++] = myGreen;  
        TransmissionArray[x++] = myRed;        
        break;
      case 5: //WS2812B - GRB
        TransmissionArray[x++] = myGreen;
        TransmissionArray[x++] = myRed;  
        TransmissionArray[x++] = myBlue;     
        break;
      } //end switch
    } //end for()

    //now do dithering/gamma correction by editing TransmissionArray, note they are signed bytes, so careful typecasting

    //transmissionType; //0: none, 1: NLED serial, 2: glediator serial, 3: ArtNet, 4: ??
	//matrix.transmissionType = 3; // debug
	//for(int i = 0; i < TransmissionArray.length; i++) TransmissionArray[i] = byte(i);  //debug

	try {	
		switch(matrix.transmissionType)
		{
		case 0: //none
			//TransmissionArray not sent
			break;
		case 1: //NLED serial
			serialPort.write(TransmissionArray); //send out the packet
			break;
		case 2: //glediator serial
			serialPort.write(1); //if glediator output add leading 1 for framing
			serialPort.write(TransmissionArray); //send out the packet
			break;		
		case 3: //artnet via artnetp4j
			x = 0; //reuse local for universe count

			for(int i = 0; i < TransmissionArray.length; i += 512)
			{
			//println("Start at: "+i+" of "+TransmissionArray.length+"     Universe: "+x);
			if((i+512) < TransmissionArray.length)	arrayCopy(TransmissionArray, i, dmxData, 0, 512);
			else 
			{
			for(int v = 0; v < dmxData.length; v++) dmxData[v] = byte(0);  //debug - clears the rest of dmxData 	
			arrayCopy(TransmissionArray, i, dmxData, 0, (TransmissionArray.length-i));
			}
			
			//Send the DMX universe to artnet	
			artnetServer.unicastDmx(matrix.outputNetworkIPAdr, 0, x, dmxData); //IP, subnet, universe#, data array	
			x++;
			}

			//arrayCopy(TransmissionArray, 0, dmxData, 0, 512);
			//artnetServer.unicastDmx("127.0.0.1", 0, 0, dmxData); //IP, subnet, universe#, data array	
			break;
		} //end switch
    }
    catch(Exception e)
    {
     println("Error sending transmission array"); 
    }		
		
    if(recordToFileButton.selected == true) thread("FileRecoderAddFrame"); //record packet to file if enabled - recorded file has color order applied

    //packet sent or is currently transmitting
    PacketReadyForTransmit = false; //clear the flag

    //wait here until next frame is ready for transmission
    while (PacketReadyForTransmit == false)
    {
      delay(1);
    } //end wait while()
		
	OutputFrameRateMs = millis() - holdMillisOutput;
	holdMillisOutput = millis();
    //Will also wait for correct timing, want a packet to be updated and within the required time

    //println("Transmission thread sent packet "+millis());
  } //end forever while()
} //end func

//=======================================================================================================

void FileRecoderAddFrame()  //called threaded from the output transmission thread
{
  //Takes the received packet, and writes all the values as single comma delimeted line
  //Doubt this is the most efficent way to do it. But works well enough
 // This saves the data values to the text file in the order they are transmitted, so the patch file directs data value ordering
 
  try 
  {
    fw = new FileWriter(sketchPath(File.separator+"recorded"+File.separator+RecorderFileName+".txt"), true); // true means: "append"
    bw = new BufferedWriter(fw);
    for (int i = 0; i != matrix.patchedChannels; i++)
    {
	if(FileRecorderFormat == 0) bw.write(str(TransmissionArray[i] & 0xFF)+","); //the & 0xFF converts the signed byte to unsigned so it can be converted to a string
    else if(FileRecorderFormat == 1) bw.write(TransmissionArray[i] & 0xFF); //writes binary/byte/raw files, can only be viewed with a Hex viewer
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




