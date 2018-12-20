
//=================================================================================

class mediaContentObj
{
  String label;
  int idNum; //ID# of the content tile object

  //IDs under 10 are graphic types, 10 and over are data types
  //IDs:0=NULL, 1=Video File(AVI, MOV, etc), 2=Animated GIF, 3=Static Image, 4=Syphon/Spout, 5=generated(graphic or data?), 10=glediator data stream
  int typeID; //as above numbering
  int generatedType;
  int instanceID; //stores the ID# for the generated & spout/syphon, object instance

  String filePath; //if applicable
  PImage mediaImage; //stores the graphic buffer, this is used for mixing, but never overwritten - not saved

  //variables for positioning and sizing large sized content
  int offsetX, offsetY;
  int cropWidth, cropHeight;
  int scaleOption; //0 = Native/Defined, 1 = scale to fit, 2 = scale to X, 3 = scale to Y

  float contentFPS; //native FPS value for content

  //not saved
  int holdMillis;  //used for timing content updates

  int playMode; //0 = play, 1 = pause, ??

  int nativeWidth = 0; //store at init, could just use mediaImage.width/height, but lets do this
  int nativeHeight = 0;

  //--------------------------------------------------------------------------

  mediaContentObj(String iLabel, int iidNum)
  {
    label = iLabel;   
    idNum = iidNum;

    mediaImage = createImage(1, 1, ARGB); //ARGB since it is an image, PGraphics are always ARGB
    filePath = ""; 

    instanceID = 0;

    offsetX = offsetY = 0; //init with no offiset
    cropWidth = 0; //0 = null usage
    cropHeight = 0; //0 = null usage
    scaleOption = 1; //set to default for now

    contentFPS = cDefaultContentFPS;//default frame rate for generated content
    holdMillis = 0;
    playMode = 0; //play
  }

  //--------------------------------------------------------------------------

  String saveContent()
  {
    //returns a string with all the object variables taht need to be saved, comma separated

    String holdStr = ""; //declare and initialize empty

    //build the mediaContent variables into a string
    holdStr = label+cFileSep+idNum+cFileSep+typeID+cFileSep+generatedType+cFileSep+instanceID+cFileSep;   
    //if (matrix.footageFilePathMethod == false) 

    holdStr += filePath.replace(sketchPath(""), "")+cFileSep;
    holdStr+=offsetX+cFileSep+offsetY+cFileSep+cropWidth+cFileSep+cropHeight+cFileSep+scaleOption+cFileSep+contentFPS;

    //if content is a generated save the parameters to the string
    if (typeID == cTypeIDGenerated) holdStr = holdStr+cFileSep+localSaveParameters();

    return holdStr;
  }  //end func

  //--------------------------------------------------------------------------

  private String localSaveParameters()
  {
    switch(generatedType)  //add additional generated types/objects here
    {
    case 0: //null
      //will leave switch and send default error string
      break;
    case 1: //Text
      return genContentText[mediaContentTile[idNum].instanceID].saveParameters();
    case 2: //Star Field
      return genContentStarField[mediaContentTile[idNum].instanceID].saveParameters(); 
    case 3: //Falling Blocks
      return genContentFallingBlocks[mediaContentTile[idNum].instanceID].saveParameters();
    case 4: //"Meta Balls"
      return genContentMetaBalls[mediaContentTile[idNum].instanceID].saveParameters();    
    case 5: //"Ripples"
      return genContentRipples[mediaContentTile[idNum].instanceID].saveParameters();
    case 6: //"Spiral"
      return genContentSpiral[mediaContentTile[idNum].instanceID].saveParameters();
    case 7: //"Solid Color"
      return genContentSolidColor[mediaContentTile[idNum].instanceID].saveParameters();      
    case 8: //"Plasma"
      return genContentPlasma[mediaContentTile[idNum].instanceID].saveParameters();
    case 9: //"2D Shape"
      return genContent2DShape[mediaContentTile[idNum].instanceID].saveParameters();
    case 10:  //"3D Shape"
      return genContent3DShape[mediaContentTile[idNum].instanceID].saveParameters();      
    case 11:  //"Sine Wave"
      return genContentSineWave[mediaContentTile[idNum].instanceID].saveParameters();       
    case 12:  //"Dancing Bars"
      return genContentBars[mediaContentTile[idNum].instanceID].saveParameters();        
    case 13:  //"Template"
      return genContentTemplate[mediaContentTile[idNum].instanceID].saveParameters();
    } //end typeID switch
    return "ERROR";
  }

  //--------------------------------------------------------------------------

  void loadContent(String passedStr)
  {
    //takes in the passed string, divides it, and places it into the proper variables
    String[] WorkString = new String[24];  
    WorkString = split(passedStr, ',');
    //printArray(WorkString);

    label = WorkString[0];
    //idNum = int(WorkString[1]); //keep assigned value when loaded
    typeID = int(WorkString[2]);
    generatedType = int(WorkString[3]);
    instanceID = int(WorkString[4]);
    filePath = WorkString[5];
    offsetX = int(WorkString[6]);
    offsetY = int(WorkString[7]);
    cropWidth = int(WorkString[8]);
    cropHeight = int(WorkString[9]);
    scaleOption = int(WorkString[10]);
    contentFPS = float(WorkString[11]);

    SelectedFilePath = filePath; //required for loadMediaSource()
    loadMediaSource(typeID);
  } //end func
  
  //--------------------------------------------------------------------------

  void localLoadParameters(String passedStr)
  {
    String scratchStr = "";
    String[] WorkString = new String[100];  
    WorkString = split(passedStr, ',');   

    int startVal = 12;

    for ( int i = 0; i < WorkString.length; i++)
    {
      try {
        scratchStr = scratchStr+WorkString[startVal+i]+cFileSep;
      }
      catch(Exception e)
      {
        //println("Done at ["+i+"]");
        break;
      }
    }

    println(label+": "+scratchStr);

    switch(generatedType)  //add additional generated types/objects here
    {
    case 0: //null
      //will leave switch and send default error string
      break;
    case 1: //Text
      genContentText[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 2: //Star Field
      genContentStarField[mediaContentTile[idNum].instanceID].loadParameters(scratchStr); 
      return;
    case 3: //Falling Blocks
      genContentFallingBlocks[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 4: //"Meta Balls"
      genContentMetaBalls[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);  
      return;
    case 5: //"Ripples"
      genContentRipples[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 6: //"Spiral"
      genContentSpiral[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 7: //"Solid Color"
      genContentSolidColor[mediaContentTile[idNum].instanceID].loadParameters(scratchStr); 
      return;
    case 8: //"Plasma"
      genContentPlasma[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 9: //"2D Shape"
      genContent2DShape[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 10:  //"3D Shape"
      genContent3DShape[mediaContentTile[idNum].instanceID].loadParameters(scratchStr); 
      return;
    case 11:  //"Sine Wave"
      genContentSineWave[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);  
      return;
    case 12:  //"Dancing Bars"
      genContentBars[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);   
      return;
    case 13:  //"Template"
      genContentTemplate[mediaContentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    } //end typeID switch
    println("ERROR - loadParameters not ran");
  }

  //--------------------------------------------------------------------------

  void display(int xpos, int ypos)
  {
    strokeWeight(1);
    stroke(gui.textColor);
    fill(0);

    rect(xpos, ypos, tileWidth, tileHeight);  
    if (mediaImage != null)
    {
      try {
        image(mediaImage, xpos, ypos, tileWidth, tileHeight); //stretches it to fit
      }
      catch(Exception e) { 
        println("An error happened with content tile: "+idNum);
      }
    }

    //adjust stroke to on highlight and invert text color
    fill(gui.textColor);
    textSize(12);
    textAlign(CENTER);
    text(label, xpos+(tileWidth/2), ypos+20);
    textAlign(LEFT);
  } //end displaySq

  //--------------------------------------------------------------------------

  void loadMediaSource(int passedTypeID) //need to store the current typeID until the end, so passing is just as good way to do it
  {
    //don't update typeID yet, want to check if same as current
    int temp;

    //reads the SelectedFilePath, if there is a colon in it, it must be an absolute file path - WINDOWS ONLY - write a different method for Mac
    //reading the colon is not a great method, but works
    if (SelectedFilePath.contains(":") == false )  SelectedFilePath = sketchPath("")+SelectedFilePath; //relative
    //else it is absolute, no need to change the string

    contentFPS = cDefaultContentFPS; //when loaded into the content list, set to default. May be overwritten

    try {
      switch(passedTypeID)
      {
      case 0: //IDs:0=NULL,

        break;
      case cTypeIDVideo: //1=Video File(AVI, MOV, etc)
        filePath = SelectedFilePath;

        loadMovieFile(idNum, filePath); //have to do in external function, movie constructor uses "this" which thinks its the mediaContentTile
        movieFile[idNum].loop();
        //movieFile[idNum].jump(0.0001); //should force a frame to be immidiatly available for a read()
		//delay required here or while waiting for available()
		
        while (!movieFile[idNum].available()) delay(1);	//println("WAITING For first Frame of Movie - not a good way to do this"); //fine to delay() since in a thread
        movieFile[idNum].read(); //now read it so width and height update

        contentFPS = movieFile[idNum].frameRate; //fill in frame rate
        nativeWidth =  movieFile[idNum].width;
        nativeHeight = movieFile[idNum].height;

        break;
      case cTypeIDAniGIF: //2=Animated GIF

        break;
      case cTypeIDImage: //3=Static Image
        filePath = SelectedFilePath;
        mediaImage = loadImage(filePath); //stored here, not changed or updated

        contentFPS = 1; //no need to update once loaded

        nativeWidth =  mediaImage.width;
        nativeHeight = mediaImage.height;

        break;
      case cTypeIDSpout: //4=Syphon/Spout
        //have to create a spout object in order to select the source, what happens if it is canceled? still defines it...

        if (typeID == passedTypeID) 
        {
          spoutReciever[instanceID].closeReceiver();
          spoutReciever[instanceID] = null;
          temp = instanceID;
        } else temp = scanSpoutReceivers();

        createSpout(temp);  //had to send run it in another function as the spout constructor uses 'this' which doesn't work from within methods
        spoutReciever[temp].selectSender();
        instanceID = temp;  


        nativeWidth =  spoutReciever[temp].receivePixels(mediaImage).width; //for whatever reason it doesn't get the value the first try, so run it twice I guess
        nativeWidth =  spoutReciever[temp].receivePixels(mediaImage).width;
        nativeHeight = spoutReciever[temp].receivePixels(mediaImage).height;

        break;    
      case cTypeIDGenerated: //Generated Content

        nativeWidth =  matrix.width;
        nativeHeight = matrix.height;

        switch(generatedType) //add additional generated types/objects here
        {
        case 0: //null

          break;
        case 1: //Text
          instanceID = createGeneratedText();
          break;
        case 2: //Star Field
          instanceID = createGeneratedStarField();
          break;
        case 3: //Falling Blocks
          instanceID = createGeneratedFallingBlocks();
          break;
        case 4: //"Meta Balls"
          instanceID = createGeneratedMetaBalls();
          break;
        case 5: //"Ripples"
          instanceID = createGeneratedRipples();
          break;       
        case 6: //"Spiral"
          instanceID = createGeneratedSpiral();
          break;    
        case 7: //"Solid Color"
          instanceID = createGeneratedSolidColor();
          break;        
        case 8: //"Plasma"
          instanceID = createGeneratedPlasma();
          break;
        case 9: //"2D Shape"
          instanceID = createGenerated2DShape();
          break;
        case 10:  //"3D Shape"
          instanceID = createGenerated3DShape();
          break;
        case 11:  //"Sine Wave"
          instanceID = createGeneratedSineWave();
          break;       
        case 12:  //"Dancing Bars"
          instanceID = createGeneratedBars();
          break;      
        case 13:  //"Template"
          instanceID = createGeneratedTemplate();
          break;
        } //end switch
        break;
      case cTypeIDDataFile: //recorded data file input 
        filePath = SelectedFilePath;
        //only one buffer, so only 1 Data File types at a time for now
        FilePlayDataBuffer = new int[(matrix.width * matrix.height) * 3];  //comes in full size, no patch yet. 3 is for RGB - needs update for single or RGBW
        mediaImage.resize(matrix.width, matrix.height);

        FilePlayStrLines = loadStrings(filePath); //divides the lines
        ReadDataFile();
        break;
      case cTypeIDExtData: //External data stream - Glediator
        ExternalDataArray = new short[(matrix.width * matrix.height) * 3];  //comes in full size, no patch yet. 3 is for RGB - needs update for single or RGBW
        mediaImage.resize(matrix.width, matrix.height);
        break;
      } //end switch
    }
    catch(Exception e)
    {
      println("Error trying to loadMediaSource with "+idNum);
      //if(passedTypeID == cTypeIDVideo) movieFile[idNum].dispose();
      passedTypeID = 0; //will be applied to typeID below
    }
			
	if(instanceID >= cMaxGeneratedObjects) 
	{
	println("Maximum amount of instances for that generated type is reached, setting to null to prevent out of bounds");	
	instanceID = 0;	
	generatedType = 0; //set to null
	}
    //Common
    cropWidth = nativeWidth;
    cropHeight = nativeHeight;

    typeID = passedTypeID;
    updateMedia(); //run this here
  } //end loadMediaSource()

  //--------------------------------------------------------------------------

  void updateMedia()
  {
    if (playMode == 1) return; //layer is paused, return without update

    switch(typeID)
    {
    case 0: //IDs:0=NULL,

      break;
    case cTypeIDVideo: //1=Video File(AVI, MOV, etc)
	  if(movieFile[idNum].available())
	  {
	  movieFile[idNum].read(); //rather than run movie event, update rate unaffected
      mediaImage = movieFile[idNum].get(); //it is updated in event, must be acting as a pointer beccause it continues to update GUI even when not called
      //add a .get() to surpress the pointer issue
	  }
      break;
    case cTypeIDAniGIF: //2=Animated GIF
      //not sure how this is done yet
      break;
    case cTypeIDImage: //3=Static Image
      //never updated after it is loaded
      break;
    case cTypeIDSpout: //4=Syphon/Spout
      //use updateSender(int Width, int Height)  to resize
      mediaImage = spoutReciever[instanceID].receivePixels(mediaImage); //everytime this is called, it resizees the PImage to fit it, no matter what?
      break;    
    case cTypeIDGenerated: //Generated Content

      switch(generatedType)  //add additional generated types/objects here
      {
      case 0: //null

        break;
      case 1: //Text
        genContentText[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentText[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 2: //Star Field
        genContentStarField[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentStarField[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 3: //Falling Blocks
        genContentFallingBlocks[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentFallingBlocks[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 4: //"Meta Balls"
        genContentMetaBalls[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentMetaBalls[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 5: //"Ripples"
        genContentRipples[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentRipples[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;       
      case 6: //"Spiral"
        genContentSpiral[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentSpiral[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;    
      case 7: //"Solid Color"
        genContentSolidColor[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentSolidColor[mediaContentTile[idNum].instanceID].localPGBuf.get();   
        break;        
      case 8: //"Plasma"
        genContentPlasma[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentPlasma[mediaContentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 9: //"2D Shape"
        genContent2DShape[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContent2DShape[mediaContentTile[idNum].instanceID].localPGBuf.get();   
        break;
      case 10:  //"3D Shape"
        genContent3DShape[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContent3DShape[mediaContentTile[idNum].instanceID].localPGBuf.get();   
        break;        
      case 11:  //"Sine Wave"
        genContentSineWave[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentSineWave[mediaContentTile[idNum].instanceID].localPGBuf.get();  
        break;       
      case 12:  //"Dancing Bars"
        genContentBars[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentBars[mediaContentTile[idNum].instanceID].localPGBuf.get();  
        break;      
      case 13:  //"Template"
        genContentTemplate[mediaContentTile[idNum].instanceID].buildFrame();
        mediaImage = genContentTemplate[mediaContentTile[idNum].instanceID].localPGBuf.get();   
        break;
      } //end typeID switch
      break;    
    case cTypeIDDataFile: //recorded data file input 

      int z = 0;

      ReadDataFile(); //update FilePlayDataBuffer[]

      for (int y = 0; y != mediaImage.pixels.length; y++)
      {  
		//correct for the test 28x28 patch, check others
	  mediaImage.pixels[((PatchCoordY[y]*mediaImage.width)+(PatchCoordX[y]))] = color(FilePlayDataBuffer[z], FilePlayDataBuffer[z+1], FilePlayDataBuffer[z+2], 255);
	  //mediaImage.pixels[((PatchCoordX[y]*mediaImage.width)+(PatchCoordY[y]))] = color(FilePlayDataBuffer[z], FilePlayDataBuffer[z+1], FilePlayDataBuffer[z+2], 255); 
	  //mediaImage.pixels[y] = color(FilePlayDataBuffer[z], FilePlayDataBuffer[z+1], FilePlayDataBuffer[z+2], 255); //orig	  
      z+=3;
      }   
      mediaImage.updatePixels(); //works fine without this, but does not update the media thumbnail image, it would stay black 

      break;      
    case cTypeIDExtData: //external data - glediator data stream

      int x = 0;

      //data needs to be rotated clockwise 90 degrees - how is that done?
      for (int i = 0; i != mediaImage.pixels.length; i++)
      {
        mediaImage.pixels[i] = color(ExternalDataArray[x], ExternalDataArray[x+1], ExternalDataArray[x+2], 255);
        x+=3;
      }   
      mediaImage.updatePixels(); //works fine without this, but does not update the media thumbnail image, it would stay black 
	  
      break;
    } //end switch
  } //end func

  
  //--------------------------------------------------------------------------

  void setPlayMode(int passedMode)
  {
    playMode = passedMode; //this variable is checked before updateMedia(), which pauses most media

	//except movies need a pause() function or when unpaused will be on a different frame since it kept playing.
    if (typeID == cTypeIDVideo)
    {
      //its a movie, pause differently
      if (playMode == 0) movieFile[idNum].play();
      else movieFile[idNum].pause(); //playMode of 1 = pause
    }
  }

  //--------------------------------------------------------------------------
} //end class

//=================================================================================

public class guiContentLayer
{
  final int width = 330;
  final int height = 130;

  int idNum;
  int xpos, ypos;
  int mediaIDNum; //0 is null, 1 or more is [-1]
  int passedFeedID; //0 == A, 1 == B, add more as needed

  int layerOpacity;
  float layerFPS;

  int blendMode;

  //for filter() based
  int effectFilterIDNum;
  float effectFilterVariable;

  int effectContrast; //minimum allowed value, sets any color value that is less than contrast to 0

  color tintColor;
  color minColor; //going to use color() but just for convience vs 3 separate values
  color maxColor; //going to use color() but just for convience vs 3 separate values

  //--------------------------------------------------------------------------

  guiContentLayer(int pidNum, int ppassedFeedID)
  {
    idNum = pidNum;
    passedFeedID = ppassedFeedID;

    ypos = 260+(idNum*height); //STATIC VALUE - FIX

    if (passedFeedID == 0)
    {
      xpos = 0; //STATIC VALUE - FIX
      feedLayersTileButtonsA[idNum] = new guiButton("", xpos+10, ypos+40, 80, 80, color(0), gui.buttonHighlightColor, color(255, 0, 0, 255), false, false, false); //never displayed but used as a button
      feedLayersEffectsButtonsA[idNum] = new guiButton("Effects", xpos+100, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      feedLayersOptionsButtonsA[idNum] = new guiButton("Options", xpos+210, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      feedLayersPlayPauseA[idNum] = new guiButton("► ‖", xpos+100, ypos+70, 35, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true);
      feedLayersOpacitySliderA[idNum] = new guiSliderBar(xpos+110, ypos+100, 200, 20, 100, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, false, false, true, "layerOpacitySliderFunc"); 
      feedLayersSpeedNIFA[idNum] = new guiNumberInputField(xpos+210, ypos+40, 25, 50, -1000, 1000, 1, "layerSpeedAdjFunc");
      feedLayersSpeedNIFA[idNum].setValue(0);

      //not a great solution, but works, bottom layer element would have the dropdown go off screen. This selects between drop down and drop up accordingly
      //  could also automatically figure it out based on ypos, height and list length
      if (idNum==2)
        feedLayersBlendModeDDA[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, "layerBlendingModeFunc"); //drop up
      else
        feedLayersBlendModeDDA[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "layerBlendingModeFunc"); //drop down
    } 
	else
    {
      xpos = 1036;  //STATIC VALUE - FIX
      feedLayersTileButtonsB[idNum] = new guiButton("", xpos+10, ypos+40, 80, 80, color(0), gui.buttonHighlightColor, color(255, 0, 0, 255), false, false, false); //never displayed but used as a button
      feedLayersEffectsButtonsB[idNum] = new guiButton("Effects", xpos+100, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      feedLayersOptionsButtonsB[idNum] = new guiButton("Options", xpos+210, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      feedLayersPlayPauseB[idNum] = new guiButton("► ‖", xpos+100, ypos+70, 35, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true);   
      feedLayersOpacitySliderB[idNum] = new guiSliderBar(xpos+110, ypos+100, 200, 20, 100, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, false, false, true, "layerOpacitySliderFunc"); 
      feedLayersSpeedNIFB[idNum] = new guiNumberInputField(xpos+210, ypos+40, 25, 50, -1000, 1000, 1, "layerSpeedAdjFunc");
      feedLayersSpeedNIFB[idNum].setValue(0);

      //not a great solution, but works, bottom layer element would have the dropdown go off screen. This selects between drop down and drop up accordingly
      //  could also automatically figure it out based on ypos, height and list length
      if (idNum==2)
        feedLayersBlendModeDDB[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, "layerBlendingModeFunc"); //drop up
      else
        feedLayersBlendModeDDB[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "layerBlendingModeFunc"); //drop down
    }

    blendMode = 0; //set to 'blend'

    layerOpacity = 255; //set to 100% opacity
    layerFPS = cDefaultContentFPS; //default for now

    //effects variables
    effectFilterIDNum = 0; //NONE
    effectFilterVariable = 0;
    effectContrast = 0;
    minColor = color(0, 0, 0);
    maxColor = color(255, 255, 255);
    tintColor = color(0, 0, 0, 0);
  } //end constructor

  //--------------------------------------------------------------------------

  void updateLayerFrame()
  {
	    //without the .get() the filter effects the media content source
	  if (mediaContentTile[mediaIDNum].typeID == cTypeIDGenerated || mediaContentTile[mediaIDNum].typeID == cTypeIDExtData || mediaContentTile[mediaIDNum].typeID == cTypeIDDataFile)
	  {  
	//no cropping/resize
	  scratchImg = mediaContentTile[mediaIDNum].mediaImage.get();
	  }
      else 
	  {  
		//fills scratchImg with the cropped and resized media
	  scratchImg = mediaContentTile[mediaIDNum].mediaImage.get(mediaContentTile[mediaIDNum].offsetX, mediaContentTile[mediaIDNum].offsetY, mediaContentTile[mediaIDNum].cropWidth, mediaContentTile[mediaIDNum].cropHeight); 
	  }
  }
  
  //--------------------------------------------------------------------------
  
  void display()
  {
    fill(gui.layerBackground);
    stroke(gui.textColor);
    strokeWeight(2);
    rect(xpos, ypos, width, height);
    noStroke();
    fill(gui.textColor);
    textAlign(LEFT);
    textSize(16);
    text("Layer "+(idNum+1)+":", xpos+10, ypos+20);
    text("(Speed)", xpos+235, ypos+85);

    if (passedFeedID == 0)
    {
      feedLayersEffectsButtonsA[idNum].display();
      feedLayersOpacitySliderA[idNum].display();
      feedLayersBlendModeDDA[idNum].display();
      feedLayersOptionsButtonsA[idNum].display();
      feedLayersPlayPauseA[idNum].display();
      feedLayersSpeedNIFA[idNum].display();
    } 
	else
    {
      feedLayersEffectsButtonsB[idNum].display();
      feedLayersOpacitySliderB[idNum].display();
      feedLayersBlendModeDDB[idNum].display();
      feedLayersOptionsButtonsB[idNum].display();
      feedLayersPlayPauseB[idNum].display();
      feedLayersSpeedNIFB[idNum].display();
    }

    //draw a rect with stroke first
    strokeWeight(2);
    stroke(gui.textColor);
    fill(gui.windowBackground); 
    rect(xpos+10, ypos+40, 80, 80);  
    noStroke();


    //then if content is defined, place its thumbnail
    if (mediaIDNum > 0)
    {
      if (mediaContentTile[mediaIDNum].typeID > 0)
      {
        mediaContentTile[mediaIDNum].display(xpos+10, ypos+40); //display thumbnail
      }
    }
    //layerTileButton[idNum].display(); //these buttons are never shown, enable to see where they are placed
  } //end display

  //--------------------------------------------------------------------------

  void selectContentLayer(String passedStr, int passedVal)
  {
    println("selectContentLayer()");

    contentLayerPtr = this; //set pointer/reference

    //detects if layer is already selected, it will then open the media content menu where it can be altered
    if (SelectLayerID == passedVal)
    {
      if (passedStr.equals("A") && SelectFeedID == 1)
      {
        //It is feed A 
        OpenOverlayMenu(cOverlayMediaTileMenu, (contentLayerA[SelectLayerID].mediaIDNum));
        return; //just leave, no changes would be made
      } else if (passedStr.equals("B") && SelectFeedID == 2)
      {
        //It is feed B
        OpenOverlayMenu(cOverlayMediaTileMenu, (contentLayerB[SelectLayerID].mediaIDNum));
        return; //just leave, no changes would be made
      }
    } //end SelectLayerID if()

    //the selection was not already selected
    SelectLayerID = passedVal;

    //set this to make referencing easier
    if (passedStr.equals("A"))
    {
      //It is feed A 
      SelectFeedID = 1;
    } else if (passedStr.equals("B"))
    {
      //It is feed B 
      SelectFeedID = 2;
    }
  }

  //--------------------------------------------------------------------------

  void focusContentLayer()
  {
    contentLayerPtr = this; //set pointer/reference
  }

  //--------------------------------------------------------------------------

  void loadMediaToLayer(int passedValue)
  {
    mediaIDNum = passedValue;

    layerFPS = mediaContentTile[mediaIDNum].contentFPS; //set layer to content FPS
    blendMode = 0; //set to default 'blend'
    layerOpacity = 255; //set opacity to 100%

    //reset effects variables
    effectFilterIDNum = 0;
    effectFilterVariable = 0;
    effectContrast = 0;
    tintColor = color(0, 0, 0, 0);
    minColor = color(0, 0, 0);
    maxColor = color(255, 255, 255);

    updateLayerGUIElements();
  }

  //--------------------------------------------------------------------------

  void updateLayerGUIElements()
  {
    if (passedFeedID == 0) 
    {
      feedLayersSpeedNIFA[idNum].setValue(layerFPS);
      feedLayersOpacitySliderA[idNum].setValue(layerOpacity);
      feedLayersBlendModeDDA[idNum].setValue(blendMode);
	  if(mediaContentTile[mediaIDNum].playMode == 0) feedLayersPlayPauseA[idNum].selected = false;
      else feedLayersPlayPauseA[idNum].selected = true;
    } 
    else 
    {
      feedLayersSpeedNIFB[idNum].setValue(layerFPS);
      feedLayersOpacitySliderB[idNum].setValue(layerOpacity);
      feedLayersBlendModeDDB[idNum].setValue(blendMode);
	  if(mediaContentTile[mediaIDNum].playMode == 0) feedLayersPlayPauseB[idNum].selected = false;
      else feedLayersPlayPauseB[idNum].selected = true;
    }
  }

  //--------------------------------------------------------------------------

  void setLayerFPS(int passedVal)
  {
    layerFPS = passedVal;

    if (mediaContentTile[mediaIDNum].typeID == cTypeIDVideo)
    {
      //its a movie, have to set speed. Can be positive or negative
      movieFile[mediaContentTile[mediaIDNum].idNum].speed((layerFPS / mediaContentTile[mediaIDNum].contentFPS));
      //println((float)(layerFPS / mediaContentTile[mediaIDNum].contentFPS));
    }
  }

  //--------------------------------------------------------------------------

  short getMsUpdateVal()
  {
    int temp;

    temp = int(1000/layerFPS);

    //if negative make positive
    if (temp < 0) temp = temp * -1;

    return (short)temp;
  }

  //--------------------------------------------------------------------------

  String saveLayer()
  {
    return mediaIDNum+cFileSep+layerOpacity+cFileSep+layerFPS+cFileSep+blendMode+cFileSep+effectFilterIDNum+cFileSep+effectFilterVariable+cFileSep+effectContrast+cFileSep+
      red(tintColor)+cFileSep+green(tintColor)+cFileSep+blue(tintColor)+cFileSep+alpha(tintColor)+cFileSep+red(minColor)+cFileSep+green(minColor)+cFileSep+blue(minColor)+cFileSep+
      red(maxColor)+cFileSep+green(maxColor)+cFileSep+blue(maxColor);
  }

  //--------------------------------------------------------------------------

  
  void loadLayer(String passedStr) //from save file
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    mediaIDNum = int(WorkString[0]);
	if(mediaIDNum > DefinedMediaTiles) mediaIDNum = 0; //out of bounds error occured, ID# not available. Set to null
	
    layerOpacity = int(WorkString[1]);
    layerFPS = float(WorkString[2]);
    blendMode = int(WorkString[3]);

    effectFilterIDNum = int(WorkString[4]);
    effectFilterVariable = float(WorkString[5]);
    effectContrast = int(WorkString[6]);
	
    tintColor = color(int(WorkString[7]), int(WorkString[8]), int(WorkString[9]),int(WorkString[10]));
    minColor = color(int(WorkString[11]), int(WorkString[12]), int(WorkString[13]));
    maxColor = color(int(WorkString[14]), int(WorkString[15]), int(WorkString[16]));

    updateLayerGUIElements(); //update all the parameters to their gui element
  }
  //--------------------------------------------------------------------------
} //end guiContentLayer

//=================================================================================

public class GUIObj
{
  color windowBackground;
  color layerBackground;
  color textColor;
  color textMenuColor;

  color buttonColor;
  color buttonHighlightColor;
  color menuBackground;

  color textFieldHighlight;
  color textFieldBG;

  //--------------------------------------------------------------------------

  GUIObj()
  {
    windowBackground = color(65, 65, 65);
    layerBackground = color(100, 100, 100);
    textColor = color(255);
    buttonColor = color(0, 0, 100);
    buttonHighlightColor = color(100, 0, 100);

    menuBackground  = color(200);
    textMenuColor = color(0);

    textFieldBG = color(255); //white
    textFieldHighlight = color(200, 40, 40);
  }
} //end gui class

//=================================================================================

class MatrixObj
{
  String name;
  String patchFileName;
  String contentFileName;
  String footagePath;
  String automaticFileName;

  int patchedChannels;
  int totalPixels;
  
  boolean auroraCMD;
 
  int transmissionType; //0: none, 1: NLED serial, 2: glediator serial, 3: ArtNet, 4: ??
	
  int serialPortNum; //ID number is assigned by operating system, and may change if other serial devices are connected
  int serialBaud;
  //add more serial ports
  
  //Network Ports
  String outputNetworkIPAdr;
  int outputNetworkPort;
  
  int width;
  int height;
  int colorOrderID; //0: RGB, 1: BRG, 2: GBR, 3: RBG, 4: BGR, 5: GRB



  int outputFPS; //in milliseconds

  boolean externalDataEnable;
  boolean externalDataRunning;
  int externalDataPort;
  int externalDataBaud;

  //--------------------------------------------------------------------------

  MatrixObj()
  {
    outputFPS = 1000/cDefaultOutputFPS; //convert FPS to milliseconds
  }

  //--------------------------------------------------------------------------

  void loadPatchFile()
  {
    //loads a coordinate patch file, find min and mix point in both directions and scales the overall size to fit within the preview areas
    // creates the Pixel objects to display during draw and fills the Coordinate Arrays for Pixel Patching
    println("loadPatchFile()");

    int tempTransArraySize = 0;
    int Xdifference = 0;
    int Ydifference = 0;

    String[] lines = loadStrings("/configs/"+software.configFilePath+"/"+matrix.patchFileName); //divides the lines
    String[] WorkString = new String[3]; //used to divide the lines into tab

    WorkString = split(lines[0], '\t');
    matrix.totalPixels = int(WorkString[0]);

    //---------------------------------------------------------------------------------------------------------

    switch(matrix.colorOrderID)
    {
    case 0: //RGB
    case 1: //BRG
    case 2: //GBR
    case 3: //RBG
    case 4: //BGR
    case 5: //GRB
      matrix.patchedChannels = matrix.totalPixels *3; //not the same as TotalChannels, incase of non-square matrixes
      tempTransArraySize = matrix.patchedChannels;
      break;

    case 6: //RGBW - no way
    case 7: //GRBW  - no way
      //would be *4
      break;

    case 8: //Single Color - probably not

      break;
    }

    println("matrix.patchedChannels: "+matrix.patchedChannels);
    println("matrix.totalPixels: "+matrix.totalPixels); 

    //resizes arrays to match the amount 
    TransmissionArray = new byte[1]; //must resize the Array so it is exactly the same size as channels
    TransmissionArray = expand(TransmissionArray, tempTransArraySize);//matrix.patchedChannels);

    int MinX=10000; //set to a large value
    int MinY=10000;
    int MaxX=0;
    int MaxY=0;

    for (int i=1; i != lines.length; i++)
    {
      WorkString = split(lines[i], '\t');
      if (int(WorkString[0]) > MaxX) MaxX = int(WorkString[0]);
      if (int(WorkString[0]) < MinX) MinX = int(WorkString[0]);

      if (int(WorkString[1]) > MaxY) MaxY = int(WorkString[1]);
      if (int(WorkString[1]) < MinY) MinY = int(WorkString[1]);
    }
    // println("X: "+MinX+" : "+MaxX);
    // println("Y: "+MinY+" : "+MaxY);

    Xdifference = MaxX - MinX;
    Ydifference = MaxY - MinY;
    //  println(Xdifference+" : "+Ydifference);

    PatchCoordX = new short[matrix.patchedChannels]; //resize the patch arrays based on matrix.patchedChannels
    PatchCoordY = new short[matrix.patchedChannels];

    //file created was incremented method channel numbers
    for (int i=0; i != matrix.totalPixels; i++)
    {
      WorkString = split(lines[i+1], '\t');      
      PatchCoordX[i] = (short)(int(WorkString[0]) - MinX);
      PatchCoordY[i] = (short)(int(WorkString[1]) - MinY);
    }

    //set final matrix size
    matrix.width = Xdifference+1;//not base 0
    matrix.height = Ydifference+1;// not base 0

   //println("maxX: "+MaxX+"   maxY: "+MaxY);

    //set pixSize that draw() uses to draw the matrix preview
    if (MaxX > MaxY)
    {
      displayPixSize = ((cPreviewContentWidth-20) / MaxX);
	  
    } 
    else
    {
      displayPixSize = ((cPreviewContentHeight-20)  / MaxY);

    }
	//calculate offsets to center pixel preview grids
	displayOffsetX = (((cPreviewContentWidth-20) - (displayPixSize*MaxX)) / 2);
	displayOffsetY = (((cPreviewContentHeight-20)  - (displayPixSize*MaxY)) / 2);	
	
	
	
	println("Done loading patch");
  }//end method
} //end object

//============================================================================

class SoftwareObj
{
  //int frameRateMs;

  int GUIWidth;
  int GUIHeight;

  boolean MIDIenable;
  int MIDIport;

  boolean mouseOverEnabled;

  String configFilePath;

  //--------------------------------------------------------------------------

  SoftwareObj()
  {
    mouseOverEnabled = true;
   // frameRateMs = (1000/cGUIRefreshFPS);
  }
  //--------------------------------------------------------------------------
} //end object

//============================================================================
