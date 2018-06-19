
//=================================================================================

class SourceContentTile
{
  String label;
  int idNum; //ID# of the content tile object

  //IDs under 10 are graphic types, 10 and over are data types
  //IDs:0=NULL, 1=Video File(AVI, MOV, etc), 2=Animated GIF, 3=Static Image, 4=Syphon/Spout, 5=generated(graphic or data?), 10=glediator data stream
  int typeID; //as above numbering
  int generatedType;
  int instanceID; //stores the ID# for the generated & spout/syphon, object instance

  String filePath; //if applicable
  PImage thumbnailImg; //stores the graphic buffer, this is used for mixing, but never overwritten - not saved

  //variables for positioning and sizing large sized content
  int offsetX, offsetY;
  int cropWidth, cropHeight;
  int scaleOption; //0 = Native/Defined, 1 = scale to fit, 2 = scale to X, 3 = scale to Y

  float contentFPS; //base FPS value for content

  //not saved
  int holdMillis;  //used for timing content updates

  int playMode; //0 = play, 1 = pause, ??

  int nativeWidth = 0; //store at init, could just use thumbnailImg.width/height, but lets do this
  int nativeHeight = 0;

  //--------------------------------------------------------------------------

  SourceContentTile(String iLabel, int iidNum)
  {
    label = iLabel;   
    idNum = iidNum;

    thumbnailImg = createImage(1, 1, ARGB); //ARGB since it is an image, PGraphics are always ARGB
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

    //build the sourceContent variables into a string
    holdStr = label+cFileSep+idNum+cFileSep+typeID+cFileSep+generatedType+cFileSep+instanceID+cFileSep;   
    //if (matrix.footageFilePathMethod == false) 

    holdStr += filePath.replace(sketchPath(""), "")+cFileSep;

    //else holdStr+=filePath+cFileSep;
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
      return genContentText[sourceConentTile[idNum].instanceID].saveParameters();
    case 2: //Star Field
      return genContentStarField[sourceConentTile[idNum].instanceID].saveParameters(); 
    case 3: //Falling Blocks
      return genContentFallingBlocks[sourceConentTile[idNum].instanceID].saveParameters();
    case 4: //"Meta Balls"
      return genContentMetaBalls[sourceConentTile[idNum].instanceID].saveParameters();    
    case 5: //"Ripples"
      return genContentRipples[sourceConentTile[idNum].instanceID].saveParameters();
    case 6: //"Spiral"
      return genContentSpiral[sourceConentTile[idNum].instanceID].saveParameters();
    case 7: //"Solid Color"
      return genContentSolidColor[sourceConentTile[idNum].instanceID].saveParameters();      
    case 8: //"Plasma"
      return genContentPlasma[sourceConentTile[idNum].instanceID].saveParameters();
    case 9: //"2D Shape"
      return genContent2DShape[sourceConentTile[idNum].instanceID].saveParameters();
    case 10:  //"3D Shape"
      return genContent3DShape[sourceConentTile[idNum].instanceID].saveParameters();      
    case 11:  //"Sine Wave"
      return genContentSineWave[sourceConentTile[idNum].instanceID].saveParameters();       
    case 12:  //"Dancing Bars"
      return genContentBars[sourceConentTile[idNum].instanceID].saveParameters();        
    case 13:  //"Template"
      return genContentTemplate[sourceConentTile[idNum].instanceID].saveParameters();
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

    SelectedFilePath = filePath; //required for loadSourceContent()

    loadSourceContent(typeID);
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
      genContentText[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 2: //Star Field
      genContentStarField[sourceConentTile[idNum].instanceID].loadParameters(scratchStr); 
      return;
    case 3: //Falling Blocks
      genContentFallingBlocks[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 4: //"Meta Balls"
      genContentMetaBalls[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);  
      return;
    case 5: //"Ripples"
      genContentRipples[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 6: //"Spiral"
      genContentSpiral[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 7: //"Solid Color"
      genContentSolidColor[sourceConentTile[idNum].instanceID].loadParameters(scratchStr); 
      return;
    case 8: //"Plasma"
      genContentPlasma[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 9: //"2D Shape"
      genContent2DShape[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
      return;
    case 10:  //"3D Shape"
      genContent3DShape[sourceConentTile[idNum].instanceID].loadParameters(scratchStr); 
      return;
    case 11:  //"Sine Wave"
      genContentSineWave[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);  
      return;
    case 12:  //"Dancing Bars"
      genContentBars[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);   
      return;
    case 13:  //"Template"
      genContentTemplate[sourceConentTile[idNum].instanceID].loadParameters(scratchStr);
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
    if (thumbnailImg != null)
    {
      //if(typeID == 4) thumbnailImg = getUpdatedContent(); //forces an update, but it is redundant if syphon feed is assigned to a layer which makes it update...
      try {
        image(thumbnailImg, xpos, ypos, tileWidth, tileHeight); //stretches it to fit
      }
      catch(Exception e) { 
        println("An error happened with content tile: "+idNum);
        image(imgColorSelector, xpos, ypos, tileWidth, tileHeight); //DEBUG - Chose random image - Testing filling the image, it errors after this sometimes
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

  void loadSourceContent(int passedTypeID) //need to store the current typeID until the end, so passing is just as good way to do it
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

        loadMovieFile(idNum, filePath); //have to do in external function, movie constructor uses "this" which thinks its the sourceContentTile
        movieFile[idNum].loop();
        movieFile[idNum].jump(0.0001); //should force a frame to be immidiatly available for a read()
        while (!movieFile[idNum].available()) println("WAITING For first Frame of Movie - not a good way to do this");
        movieFile[idNum].read(); //now read it so width and height update

        contentFPS = movieFile[idNum].frameRate; //fill in frame rate
        nativeWidth =  movieFile[idNum].width;
        nativeHeight = movieFile[idNum].height;

        break;
      case cTypeIDAniGIF: //2=Animated GIF

        break;
      case cTypeIDImage: //3=Static Image
        filePath = SelectedFilePath;
        thumbnailImg = loadImage(filePath); //stored here, not changed or updated

        contentFPS = 1; //no need to update once loaded

        nativeWidth =  thumbnailImg.width;
        nativeHeight = thumbnailImg.height;

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


        nativeWidth =  spoutReciever[temp].receivePixels(thumbnailImg).width; //for whatever reason it doesn't get the value the first try, so run it twice I guess
        nativeWidth =  spoutReciever[temp].receivePixels(thumbnailImg).width;
        nativeHeight = spoutReciever[temp].receivePixels(thumbnailImg).height;

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
        thumbnailImg.resize(matrix.width, matrix.height);

        FilePlayStrLines = loadStrings(filePath); //divides the lines
        ReadDataFile();
        break;
      case cTypeIDExtData: //External data stream - Glediator
        ExternalDataArray = new short[(matrix.width * matrix.height) * 3];  //comes in full size, no patch yet. 3 is for RGB - needs update for single or RGBW
        thumbnailImg.resize(matrix.width, matrix.height);
        break;
      } //end switch
    }
    catch(Exception e)
    {
      println("Error trying to loadSourceContent with "+idNum);
      //if(passedTypeID == cTypeIDVideo) movieFile[idNum].dispose();
      passedTypeID = 0; //will be applied to typeID below
    }

    //common
    cropWidth = nativeWidth;
    cropHeight = nativeHeight;

    typeID = passedTypeID;
    updateContent(); //run this here
  } //end loadSourceContent()

  //--------------------------------------------------------------------------

  void updateContent()
  {
    if (playMode == 1) return; //layer is paused, return without update

    switch(typeID)
    {
    case 0: //IDs:0=NULL,

      break;
    case cTypeIDVideo: //1=Video File(AVI, MOV, etc)
      thumbnailImg = movieFile[idNum]; //it is updated in event, must be acting as a pointer beccause it continues to update GUI even when not called
      //add a .get() to surpress the pointer thing
      break;
    case cTypeIDAniGIF: //2=Animated GIF
      //not sure how this is done yet
      break;
    case cTypeIDImage: //3=Static Image
      //never updated after it is loaded
      break;
    case cTypeIDSpout: //4=Syphon/Spout
      //use updateSender(int Width, int Height)  to resize
      thumbnailImg = spoutReciever[instanceID].receivePixels(thumbnailImg); //everytime this is called, it resizees the PImage to fit it, no matter what?
      break;    
    case cTypeIDGenerated: //Generated Content

      switch(generatedType)  //add additional generated types/objects here
      {
      case 0: //null

        break;
      case 1: //Text
        genContentText[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentText[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 2: //Star Field
        genContentStarField[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentStarField[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 3: //Falling Blocks
        genContentFallingBlocks[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentFallingBlocks[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 4: //"Meta Balls"
        genContentMetaBalls[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentMetaBalls[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 5: //"Ripples"
        genContentRipples[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentRipples[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;       
      case 6: //"Spiral"
        genContentSpiral[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentSpiral[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;    
      case 7: //"Solid Color"
        genContentSolidColor[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentSolidColor[sourceConentTile[idNum].instanceID].localPGBuf.get();   
        break;        
      case 8: //"Plasma"
        genContentPlasma[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentPlasma[sourceConentTile[idNum].instanceID].localPGBuf.get();
        break;
      case 9: //"2D Shape"
        genContent2DShape[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContent2DShape[sourceConentTile[idNum].instanceID].localPGBuf.get();   
        break;
      case 10:  //"3D Shape"
        genContent3DShape[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContent3DShape[sourceConentTile[idNum].instanceID].localPGBuf.get();   
        break;        
      case 11:  //"Sine Wave"
        genContentSineWave[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentSineWave[sourceConentTile[idNum].instanceID].localPGBuf.get();  
        break;       
      case 12:  //"Dancing Bars"
        genContentBars[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentBars[sourceConentTile[idNum].instanceID].localPGBuf.get();  
        break;      
      case 13:  //"Template"
        genContentTemplate[sourceConentTile[idNum].instanceID].buildFrame();
        thumbnailImg = genContentTemplate[sourceConentTile[idNum].instanceID].localPGBuf.get();   
        break;
      } //end typeID switch
      break;    
    case cTypeIDDataFile: //recorded data file input 

      int z = 0;

      ReadDataFile(); //update FilePlayDataBuffer[]

      for (int y = 0; y != thumbnailImg.pixels.length; y++)
      {
        thumbnailImg.pixels[y] = color(FilePlayDataBuffer[z], FilePlayDataBuffer[z+1], FilePlayDataBuffer[z+2], 255);
        z+=3;
      }   
      thumbnailImg.updatePixels(); //works fine without this, but does not update the content thumbnail image, it would stay black 

      break;      
    case cTypeIDExtData: //external data - glediator data stream

      int x = 0;

      //data needs to be rotated clockwise 90 degrees - how is that done?
      for (int i = 0; i != thumbnailImg.pixels.length; i++)
      {
        // if(x == 0)  thumbnailImg.pixels[i] = color(255, 255, 255, 255); //places a white square to indicate first pixel for Debugging
        //else 
        thumbnailImg.pixels[i] = color(ExternalDataArray[x], ExternalDataArray[x+1], ExternalDataArray[x+2], 255);
        x+=3;
      }   
      thumbnailImg.updatePixels(); //works fine without this, but does not update the content thumbnail image, it would stay black 
      break;
    } //end switch
  } //end func

  //--------------------------------------------------------------------------

  void setPlayMode(int passedMode)
  {
    playMode = passedMode;

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
  int contentIDNum; //0 is null, 1 or more is [-1]
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
      layerAtileButtons[idNum] = new guiButton("", xpos+10, ypos+40, 80, 80, color(0), gui.buttonHighlightColor, color(255, 0, 0, 255), false, false, false); //never displayed but used as a button
      layerAeffectButtons[idNum] = new guiButton("Effects", xpos+100, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      layerAsourceOptionButtons[idNum] = new guiButton("Options", xpos+210, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      feedLayersPlayPauseA[idNum] = new guiButton("► ‖", xpos+100, ypos+70, 35, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true);
      layerOpacitySlidersA[idNum] = new guiSliderBar(xpos+110, ypos+100, 200, 20, 100, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, false, false, true, "layerOpacitySliderFunc"); 
      layerASpeedNIF[idNum] = new guiNumberInputField(xpos+210, ypos+40, 25, 50, -1000, 1000, 1, "layerSpeedAdjFunc");
      layerASpeedNIF[idNum].setValue(0);

      //not a great solution, but works, bottom layer element would have the dropdown go off screen. This selects between drop down and drop up accordingly
      //  could also automatically figure it out based on ypos, height and list length
      if (idNum==2)
        layerAblendModeDD[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, "layerBlendingModeFunc"); //drop up
      else
        layerAblendModeDD[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "layerBlendingModeFunc"); //drop down
    } else
    {
      xpos = 1036;  //STATIC VALUE - FIX
      layerBtileButtons[idNum] = new guiButton("", xpos+10, ypos+40, 80, 80, color(0), gui.buttonHighlightColor, color(255, 0, 0, 255), false, false, false); //never displayed but used as a button
      layerBeffectButtons[idNum] = new guiButton("Effects", xpos+100, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      layerBsourceOptionButtons[idNum] = new guiButton("Options", xpos+210, ypos+5, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
      feedLayersPlayPauseB[idNum] = new guiButton("► ‖", xpos+100, ypos+70, 35, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true);   
      layerOpacitySlidersB[idNum] = new guiSliderBar(xpos+110, ypos+100, 200, 20, 100, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, false, false, true, "layerOpacitySliderFunc"); 
      layerBSpeedNIF[idNum] = new guiNumberInputField(xpos+210, ypos+40, 25, 50, -1000, 1000, 1, "layerSpeedAdjFunc");
      layerBSpeedNIF[idNum].setValue(0);

      //not a great solution, but works, bottom layer element would have the dropdown go off screen. This selects between drop down and drop up accordingly
      //  could also automatically figure it out based on ypos, height and list length
      if (idNum==2)
        layerBblendModeDD[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, "layerBlendingModeFunc"); //drop up
      else
        layerBblendModeDD[idNum] = new guiDropDown(cDDStrListBlendModes, 0, xpos+100, ypos+40, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "layerBlendingModeFunc"); //drop down
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
      layerAeffectButtons[idNum].display();
      layerOpacitySlidersA[idNum].display();
      layerAblendModeDD[idNum].display();
      layerAsourceOptionButtons[idNum].display();
      feedLayersPlayPauseA[idNum].display();
      layerASpeedNIF[idNum].display();
    } else
    {
      layerBeffectButtons[idNum].display();
      layerOpacitySlidersB[idNum].display();
      layerBblendModeDD[idNum].display();
      layerBsourceOptionButtons[idNum].display();
      feedLayersPlayPauseB[idNum].display();
      layerBSpeedNIF[idNum].display();
    }

    //draw a rect with stroke first
    strokeWeight(2);
    stroke(gui.textColor);
    fill(gui.windowBackground); 
    rect(xpos+10, ypos+40, 80, 80);  
    noStroke();


    //then if content is defined, place its thumbnail
    if (contentIDNum > 0)
    {
      if (sourceConentTile[contentIDNum].typeID > 0)
      {
        sourceConentTile[contentIDNum].display(xpos+10, ypos+40); //display thumbnail
      }
    }
    //layerTileButton[idNum].display(); //these buttons are never shown, enable to see where they are placed
  } //end display

  //--------------------------------------------------------------------------

  void selectContentLayer(String passedStr, int passedVal)
  {
    println("selectContentLayer()");

    contentLayerPtr = this; //set pointer/reference

    //detects if layer is already selected, it will then open the SourceContent menu where it can be altered
    if (SelectLayerID == passedVal)
    {
      if (passedStr.equals("A") && SelectFeedID == 1)
      {
        //It is feed A 
        OpenOverlayMenu(cOverlaySourceContent, (contentLayerA[SelectLayerID].contentIDNum));
        return; //just leave, no changes would be made
      } else if (passedStr.equals("B") && SelectFeedID == 2)
      {
        //It is feed B
        OpenOverlayMenu(cOverlaySourceContent, (contentLayerB[SelectLayerID].contentIDNum));
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

  void loadContentToLayer(int passedValue)
  {
    contentIDNum = passedValue;

    layerFPS = sourceConentTile[contentIDNum].contentFPS; //set layer to content FPS
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
    //fill GUI elements with value
    if (passedFeedID == 0) 
    {
      layerASpeedNIF[idNum].setValue(layerFPS);
      layerOpacitySlidersA[idNum].setValue(layerOpacity);
      layerAblendModeDD[idNum].setValue(blendMode);
      //feedLayersPlayPauseA[contentIDNum].setPlayMode(0); //play
    } 
    else 
    {
      layerBSpeedNIF[idNum].setValue(layerFPS);
      layerOpacitySlidersB[idNum].setValue(layerOpacity);
      layerBblendModeDD[idNum].setValue(blendMode);
      // feedLayersPlayPauseB[contentIDNum].setPlayMode(0); //play
    }
  }

  //--------------------------------------------------------------------------

  void setLayerFPS(int passedVal)
  {
    layerFPS = passedVal;
    //float tempFloat
    if (sourceConentTile[contentIDNum].typeID == cTypeIDVideo)
    {
      //its a movie, have to set speed. Can be positive or negative
      movieFile[sourceConentTile[contentIDNum].idNum].speed((layerFPS / sourceConentTile[contentIDNum].contentFPS));
      //println((float)(layerFPS / sourceConentTile[contentIDNum].contentFPS));
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
    return contentIDNum+cFileSep+layerOpacity+cFileSep+layerFPS+cFileSep+blendMode+cFileSep+effectFilterIDNum+cFileSep+effectFilterVariable+cFileSep+effectContrast+cFileSep+
      red(tintColor)+cFileSep+green(tintColor)+cFileSep+blue(tintColor)+cFileSep+alpha(tintColor)+cFileSep+red(minColor)+cFileSep+green(minColor)+cFileSep+blue(minColor)+cFileSep+
      red(maxColor)+cFileSep+green(maxColor)+cFileSep+blue(maxColor);
  }

  //--------------------------------------------------------------------------

  void loadLayer(String passedStr)
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    contentIDNum = int(WorkString[0]);

    layerOpacity = int(WorkString[1]);
    layerFPS = float(WorkString[2]);
    blendMode = int(WorkString[3]);

    effectFilterIDNum = int(WorkString[4]);
    effectFilterVariable = float(WorkString[5]);
    
    tintColor = color(int(WorkString[6]), int(WorkString[7]), int(WorkString[8]),int(WorkString[9]));
    minColor = color(int(WorkString[10]), int(WorkString[11]), int(WorkString[12]));
    maxColor = color(int(WorkString[13]), int(WorkString[14]), int(WorkString[15]));

    updateLayerGUIElements();
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

  boolean auroraCMD;

  int serialPort;
  int serialBaud;
  //add more serial ports

  int width;
  int height;
  int colorOrderID; //0: RGB, 1: BRG, 2: GBR, 3: RBG, 4: BGR, 5: GRB

  int transmissionType; //0: none, 1: NLED serial, 2: glediator serial, 3: TCP, 4: UDP, ??

  String serverIP;
  int serverPort;

  int outputFPS; //in milliseconds

  boolean externalDataEnable;
  int externalDataPort;
  int externalDataBaud;

  //--------------------------------------------------------------------------

  MatrixObj()
  {
    outputFPS = 1000/cDefaultOutputFPS; //convert FPS to milliseconds
  }

  //--------------------------------------------------------------------------

  void LoadPatchFile()
  {
    //loads a coordinate patch file, find min and mix point in both directions and scales the overall size to fit within the preview areas
    // creates the Pixel objects to display during draw and fills the Coordinate Arrays for Pixel Patching
    println("BuildCustom()");

    int tempTransArraySize = 0;
    int Xdifference = 0;
    int Ydifference = 0;

    String[] lines = loadStrings("/configs/"+software.configFilePath+"/"+matrix.patchFileName); //divides the lines
    String[] WorkString = new String[3]; //used to divide the lines into tab

    WorkString = split(lines[0], '\t');
    TotalPixels = int(WorkString[0]);

    //---------------------------------------------------------------------------------------------------------

    switch(matrix.colorOrderID)
    {
    case 0: //RGB
    case 1: //BRG
    case 2: //GBR
    case 3: //RBG
    case 4: //BGR
    case 5: //GRB
      PatchedChannels = TotalPixels *3; //not the same as TotalChannels, incase of non-square matrixes
      tempTransArraySize = PatchedChannels;
      break;

    case 6: //RGBW - no way
    case 7: //GRBW  - no way
      //would be *4
      break;

    case 8: //Single Color - probably not

      break;
    }

    println("PatchedChannels: "+PatchedChannels);
    println("TotalPixels: "+TotalPixels); 

    //resizes arrays to match the amount 
    TransmissionArray = new byte[1]; //must resize the Array so it is exactly the same size as channels
    TransmissionArray = expand(TransmissionArray, tempTransArraySize);//PatchedChannels);

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

    PatchCoordX = new short[PatchedChannels]; //resize the patch arrays based on PatchedChannels
    PatchCoordY = new short[PatchedChannels];

    //file created was incremented method channel numbers
    for (int i=0; i != TotalPixels; i++)
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
  }//end method
} //end object

//============================================================================

class SoftwareObj
{
  int frameRateMs;

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
    frameRateMs = (1000/cGUIRefreshFPS);
  }
  //--------------------------------------------------------------------------
} //end object

//============================================================================
