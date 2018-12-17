
//=======================================================================================================================  

class OverlayMenu
{
  int ObjID;
  int xpos;
  int ypos;
  int Height;
  int Width;

  int autoPosition; //0 = use xpos & ypos, 1 = center X & Y, 2 = center Y alight right, 3 = center Y align left
  int forceOverride; //0 = only menu elements can be clicked, 1 = any exposed elements can be clicked

  int xOffset, yOffset;

  //constructor
  OverlayMenu(int iObjID, int ixpos, int iypos, int ibWidth, int ibHeight)
  {
    ObjID = iObjID;
    xpos = ixpos;
    ypos = iypos;  
    Width = ibWidth;
    Height = ibHeight;

    autoPosition = 1; //set as default
    forceOverride = 0;
  } //end constructor

  //-----------------------------------------------------------------------------------------------

  void display()
  {
    fill(gui.windowBackground, 128); //draw a transparent rect over the entire GUI
    rect(0, 0, cDefaultGUIWidth, cDefaultGUIHeight);  


    fill(gui.menuBackground);
    stroke(0);
    strokeWeight(4);


    //draws background of menu
    switch(autoPosition) 
    {
    case 0:
    default:
      rect(xpos, ypos, Width, Height, 20);
      break;
    case 1:
      rect((cDefaultGUIWidth-Width)/2, (cDefaultGUIHeight-Height)/2, Width, Height, 20);
      break;
    }//end switch

    //========================================

    switch(ObjID)
    {
    case cOverlayMediaTileMenu:  //Media Content Tiles------------------------------------------------------------------------------------

      int tempW, tempH;

      for (int i = 0; i != menuMediaTileMenuButtons.length; i++) menuMediaTileMenuButtons[i].display();

      //workingTileID is not yet created, so would error if this runs, because it otherwise runs the NULL ID
      textSize(22);
      fill(gui.textMenuColor);
      if (workingTileID <= DefinedMediaTiles)
        text("Choose Media Content, Slot: "+(mediaContentTile[workingTileID].idNum), xOffset+20, yOffset+40);
      else    
      text("Choose Media Content", xOffset+20, yOffset+40);

      textSize(16);    
      text("(Click button to\nopen file dialog)", xOffset+20, yOffset+335);

      switch(getmediaContentObjTypeID())
      {
      case cTypeIDNULL: //IDs:0=NULL,
        text("Please Select a Media Source", xOffset+200, yOffset+80);
        break;

      case cTypeIDVideo: //1=Video File(AVI, MOV, etc)
      case cTypeIDAniGIF: //2=Animated GIF
      case cTypeIDImage: //3=Static Image
      case cTypeIDSpout: //4=Syphon/Spout     

        if (getmediaContentObjTypeID() == cTypeIDSpout) text("Spout/Syphon: Reference name?   Spout/Sypon Object ID: "+mediaContentTile[workingTileID].instanceID, xOffset+180, yOffset+65);
        else  text("File Path: "+mediaContentTile[workingTileID].filePath, xOffset+180, yOffset+65);

        text("Native Width: "+mediaContentTile[workingTileID].nativeWidth+"px", xOffset+180, yOffset+85);
        text("Native Height: "+mediaContentTile[workingTileID].nativeHeight+"px", xOffset+180, yOffset+105);
        text("FPS: "+mediaContentTile[workingTileID].contentFPS, xOffset+180, yOffset+125);

        text("CropX:", contentOffsetX.xpos-65, contentOffsetX.ypos+20);
        text("CropY:", contentOffsetY.xpos-65, contentOffsetY.ypos+20);     

        text("CropW:", mediaMenuGUICropW.xpos-65, mediaMenuGUICropW.ypos+20);
        text("CropH:", mediaMenuGUICropH.xpos-65, mediaMenuGUICropH.ypos+20); 

        //max width 600px, max height is 400px, figure out how to scale image proportionally   
        tempW = scaleImageW(mediaContentTile[workingTileID].nativeWidth, mediaContentTile[workingTileID].nativeHeight, 600, 400);
        tempH = scaleImageH(mediaContentTile[workingTileID].nativeWidth, mediaContentTile[workingTileID].nativeHeight, 600, 400);
        //println(tempW+"  "+tempH);
		
        image(mediaContentTile[workingTileID].mediaImage, xOffset+180, yOffset+180, tempW, tempH);   

        //now draw the stuff for cropping and shifting - will need to make it common to other
        //offsetX = offsetY = 0; //init with no offiset cropWidth = 0; //0 = null usage  cropHeight = 0; //0 = null usage  scaleOption = 0;      

        float ratio = scaleImageRatio(mediaContentTile[workingTileID].nativeWidth, mediaContentTile[workingTileID].nativeHeight, 600, 400);

        tempW = int((float)(mediaContentTile[workingTileID].cropWidth)  / ratio);
        tempH = int((float)(mediaContentTile[workingTileID].cropHeight) / ratio);  

        stroke(255, 0, 0);
        strokeWeight(2);
        fill(0, 0, 0, 0);
        rect(xOffset+180+(mediaContentTile[workingTileID].offsetX/ratio), yOffset+180+(mediaContentTile[workingTileID].offsetY/ratio), tempW, tempH);

        //Draw Handles    
        noStroke();
        fill(255, 0, 0);
        rect(xOffset+180-10+((float)mediaContentTile[workingTileID].offsetX/ratio), yOffset+180-10+((float)mediaContentTile[workingTileID].offsetY/ratio), 20, 20); //top left      
        rect(xOffset+180-10+((float)mediaContentTile[workingTileID].offsetX/ratio), yOffset+180-10+tempH+((float)mediaContentTile[workingTileID].offsetY/ratio), 20, 20);    //bottom left            
        rect(xOffset+180-10+((float)mediaContentTile[workingTileID].offsetX/ratio)+tempW, yOffset+180-10+((float)mediaContentTile[workingTileID].offsetY/ratio), 20, 20); //top right          
        rect(xOffset+180-10+((float)mediaContentTile[workingTileID].offsetX/ratio)+tempW, yOffset+180-10+tempH+((float)mediaContentTile[workingTileID].offsetY/ratio), 20, 20); //bottom right          

        imgScalingOptionsDD.display();
        contentOffsetX.display();
        contentOffsetY.display();
        mediaMenuGUICropW.display();
        mediaMenuGUICropH.display();

        break;
      case cTypeIDGenerated: //Generated Content
        text("Select Generated Content Type: ", xOffset+180, yOffset+80);
        generatedMediaDD.display();
        generatedMediaFPS.display();
        strokeWeight(2);
        stroke(255);
        line(xOffset+180, yOffset+95, xOffset+Width-20, yOffset+95);

        fill(gui.textMenuColor);
        textSize(16);  
        textAlign(RIGHT);

        switch(mediaContentTile[workingTileID].generatedType)  //add additional generated types/objects here
        {
        case 0: //null

          break;
        case 1: //"Text"
          fill(gui.textMenuColor);
          textSize(16);  
          textAlign(RIGHT);
          text("Enter Text:", genTextLabel.xpos-10, genTextLabel.ypos+genTextLabel.bHeight);
          text("Size:", genNIFTextSize.xpos-10, genNIFTextSize.ypos+genNIFTextSize.size);         
          text("Y Offset:", genNIFTextYOffset.xpos-10, genNIFTextYOffset.ypos+genNIFTextYOffset.size);
          text("X Offset:", genNIFTextXOffset.xpos-10, genNIFTextXOffset.ypos+genNIFTextXOffset.size);
          text("Scrolling:", genTextScrollTypeDD.xpos-10, genTextScrollTypeDD.ypos+genTextScrollTypeDD.bHeight-5);
          text("Font Type:", genTextFontTypeDD.xpos-10, genTextFontTypeDD.ypos+genTextScrollTypeDD.bHeight-5);
          text("Text Color:", genTextColor.xpos-10, genTextColor.ypos+genTextColor.size-5);
          text("Background Color:", genTextBackgroundColor.xpos-10, genTextBackgroundColor.ypos+genTextBackgroundColor.size-5);

          genTextLabel.display();
          genNIFTextSize.display();
          genNIFTextXOffset.display();
          genNIFTextYOffset.display();
          genTextScrollTypeDD.display();       
          genTextFontTypeDD.display();
          genTextColor.display();
          genTextBackgroundColor.display();
          break;
        case 2: //"Star Field"
          text("Star Shape:", genStarsShapeDD.xpos-10, genStarsShapeDD.ypos+genStarsShapeDD.bHeight);    
          text("Size:", genStarsSizeNIF.xpos-10, genStarsSizeNIF.ypos+genStarsSizeNIF.size);
          text("Quantity:", genStarsQuantityNIF.xpos-10, genStarsQuantityNIF.ypos+genStarsQuantityNIF.size);
          text("Stroke Size:", genStarsStrokeNIF.xpos-10, genStarsStrokeNIF.ypos+genStarsStrokeNIF.size);
          text("Decay:", genStarsDecayNIF.xpos-10, genStarsDecayNIF.ypos+genStarsDecayNIF.size);          
          text("Fill Color:", genStarsFillColor.xpos-10, genStarsFillColor.ypos+genStarsFillColor.size);
          text("Stroke Color:", genStarsStrokeColor.xpos-10, genStarsStrokeColor.ypos+genStarsStrokeColor.size);         
          text("Z Distance:", genStarsZDistEnable.xpos-10, genStarsZDistEnable.ypos+genStarsZDistEnable.size);

          genStarsShapeDD.display();
          genStarsSizeNIF.display();
          genStarsStrokeNIF.display();
          genStarsQuantityNIF.display();
          genStarsDecayNIF.display();
          genStarsZDistEnable.display();
          genStarsFillColor.display();
          genStarsStrokeColor.display();
          break;
        case 3: //"Falling Blocks"
          text("Direction:", genFallingBlocksDirection.xpos-10, genFallingBlocksDirection.ypos+genFallingBlocksDirection.bHeight);  
          text("Block Size:", genFallingBlocksSize.xpos-10, genFallingBlocksSize.ypos+genFallingBlocksSize.size);    
          text("Block Decay:", genFallingBlocksDecay.xpos-10, genFallingBlocksDecay.ypos+genFallingBlocksDecay.size);    
          text("Block Frequency:", genFallingBlocksFrequency.xpos-10, genFallingBlocksFrequency.ypos+genFallingBlocksFrequency.size);    
          text("Block Color:", genFallingBlocksColor.xpos-10, genFallingBlocksColor.ypos+genFallingBlocksColor.size);    

          genFallingBlocksDirection.display();
          genFallingBlocksSize.display();
          genFallingBlocksDecay.display();
          genFallingBlocksFrequency.display();
          genFallingBlocksColor.display();
          break;
        case 4: //"Meta Balls"
          text("Color Mode:", genMetaBallsColorMode.xpos-10, genMetaBallsColorMode.ypos+genMetaBallsColorMode.bHeight);  
          text("Ball Amount:", genMetaBallsAmount.xpos-10, genMetaBallsAmount.ypos+genMetaBallsAmount.size);  
          text("Ball Size:", genMetaBallsSize.xpos-10, genMetaBallsSize.ypos+genMetaBallsSize.size);  
          text("Ball Frequency:", genMetaBallsFequency.xpos-10, genMetaBallsFequency.ypos+genMetaBallsFequency.size); 
          text("Ball Color:", genMetaBallsColor.xpos-10, genMetaBallsColor.ypos+genMetaBallsColor.size);  

          genMetaBallsColorMode.display();
          genMetaBallsAmount.display();
          genMetaBallsSize.display();
          genMetaBallsFequency.display();
          genMetaBallsColor.display();
          break;
        case 5: //"Ripples"
          text("Shape:", genRipplesShape.xpos-10, genRipplesShape.ypos+genRipplesShape.bHeight);  
          text("Audio Mode:", genRipplesAudioMode.xpos-10, genRipplesAudioMode.ypos+genRipplesAudioMode.bHeight);  
          text("Amplitude:", genRipplesAmplitude.xpos-10, genRipplesAmplitude.ypos+genRipplesAmplitude.size);  
          text("Fill Method:", genRipplesfillMethod.xpos-10, genRipplesfillMethod.ypos+genRipplesfillMethod.bHeight);  
          text("Stroke Width:", genRipplesStrokeWidth.xpos-10, genRipplesStrokeWidth.ypos+genRipplesStrokeWidth.size);  
          text("Fill Color:", genRipplesFillColor.xpos-10, genRipplesFillColor.ypos+genRipplesFillColor.size);  
          text("Stroke Color:", genRipplesStrokeColor.xpos-10, genRipplesStrokeColor.ypos+genRipplesStrokeColor.size);  

          genRipplesShape.display();
          genRipplesAudioMode.display();
          genRipplesAmplitude.display();
          genRipplesfillMethod.display();
          genRipplesStrokeWidth.display();
          genRipplesFillColor.display();
          genRipplesStrokeColor.display();
          break;       
        case 6: //"Spiral"
          text("Color Mode:", genSpiralColorMode.xpos-10, genSpiralColorMode.ypos+genSpiralColorMode.bHeight);  
          text("Mode Var:", genSpiralModeVariable.xpos-10, genSpiralModeVariable.ypos+genSpiralModeVariable.size);  
          text("Coils:", genSpiralCoils.xpos-10, genSpiralCoils.ypos+genSpiralCoils.size);  
          text("Decay:", genSpiralDecay.xpos-10, genSpiralDecay.ypos+genSpiralDecay.size);  
          text("Color:", genSpiralColor.xpos-10, genSpiralColor.ypos+genSpiralColor.size); 

          genSpiralColorMode.display();
          genSpiralModeVariable.display();
          genSpiralCoils.display();
          genSpiralDecay.display();
          genSpiralColor.display();
          break;    
        case 7: //"Solid Color"
          text("Color:", genSolidColorFill.xpos-10, genSolidColorFill.ypos+genSolidColorFill.size);  
          genSolidColorFill.display();
          break;        
        case 8: //"Plasma"
          text("No Parameters:", xOffset+330, yOffset+140);  
          break;
        case 9: //"2D Shape"
          text("Fill Color:", gen2DShapeFillColor.xpos-10, gen2DShapeFillColor.ypos+gen2DShapeFillColor.size);  
          text("Stroke Color:", gen2DShapeStrokeColor.xpos-10, gen2DShapeStrokeColor.ypos+gen2DShapeStrokeColor.size);  
          text("Stroke Width:", gen2DShapeStrokeWeight.xpos-10, gen2DShapeStrokeWeight.ypos+gen2DShapeStrokeWeight.size);  
          text("Shape Size:", gen2DShapeSize.xpos-10, gen2DShapeSize.ypos+gen2DShapeSize.size); 
          text("Rotation Speed:", gen2DShapeRotationSpeed.xpos-10, gen2DShapeRotationSpeed.ypos+gen2DShapeRotationSpeed.size); 
          text("Zoom Speed:", gen2DShapeZoomSpeed.xpos-10, gen2DShapeZoomSpeed.ypos+gen2DShapeZoomSpeed.size); 
          text("Zoom Max:", gen2DShapeZoomMax.xpos-10, gen2DShapeZoomMax.ypos+gen2DShapeZoomMax.size); 
          text("Zoom Min:", gen2DShapeZoomMin.xpos-10, gen2DShapeZoomMin.ypos+gen2DShapeZoomMin.size); 
          text("Smoothing:", gen2DShapeEnableSmoothing.xpos-10, gen2DShapeEnableSmoothing.ypos+gen2DShapeEnableSmoothing.size);  

          gen2DShapeFillColor.display();
          gen2DShapeStrokeColor.display();
          gen2DShapeStrokeWeight.display();
          gen2DShapeSize.display();
          gen2DShapeRotationSpeed.display();
          gen2DShapeZoomSpeed.display();
          gen2DShapeZoomMax.display();
          gen2DShapeZoomMin.display();
          gen2DShapeEnableSmoothing.display();   
          break;
        case 10:  //"3D Shape"
          text("Shape Size:", gen3DShapeSize.xpos-10, gen3DShapeSize.ypos+gen3DShapeSize.size);  
          text("Stroke Weight:", gen3DShapeStrokeWeight.xpos-10, gen3DShapeStrokeWeight.ypos+gen3DShapeStrokeWeight.size);  
          text("Rotation X:", gen3DShapeRotationX.xpos-10, gen3DShapeRotationX.ypos+gen3DShapeRotationX.size);  
          text("Rotation Y:", gen3DShapeRotationY.xpos-10, gen3DShapeRotationY.ypos+gen3DShapeRotationY.size);  
          text("Smoothing:", gen3DShapeEnableSmoothing.xpos-10, gen3DShapeEnableSmoothing.ypos+gen3DShapeEnableSmoothing.size);  
          text("Stroke Color:", gen3DShapeStrokeColor.xpos-10, gen3DShapeStrokeColor.ypos+gen3DShapeStrokeColor.size);  

          gen3DShapeSize.display();
          gen3DShapeRotationX.display();
          gen3DShapeRotationY.display();
          gen3DShapeStrokeWeight.display();
          gen3DShapeEnableSmoothing.display();
          gen3DShapeStrokeColor.display();
          break;
        case 11:  //"Sine Wave"
          text("Wave Mode:", genSineWaveMode.xpos-10, genSineWaveMode.ypos+genSineWaveMode.bHeight);  
          text("Sample Mode:", genSineWaveAuidoMode.xpos-10, genSineWaveAuidoMode.ypos+genSineWaveAuidoMode.bHeight);  
          text("Y Offset:", genSineWaveYOffset.xpos-10, genSineWaveYOffset.ypos+genSineWaveYOffset.size);  
          text("Amplitude:", genSineWaveAmplitude.xpos-10, genSineWaveAmplitude.ypos+genSineWaveAmplitude.size);  
          text("Period:", genSineWavePeriod.xpos-10, genSineWavePeriod.ypos+genSineWavePeriod.size);  
          text("Decay:", genSineWaveDecay.xpos-10, genSineWaveDecay.ypos+genSineWaveDecay.size);  
          text("Fill Color:", genSineWaveFillColor.xpos-10, genSineWaveFillColor.ypos+genSineWaveFillColor.size);  

          genSineWaveMode.display();
          genSineWaveAuidoMode.display();
          genSineWaveYOffset.display();
          genSineWaveAmplitude.display();
          genSineWavePeriod.display();
          genSineWaveDecay.display();
          genSineWaveFillColor.display();
          break;       
        case 12:  //"Dancing Bars"
          text("Bars Mode:", genBarsMode.xpos-10, genBarsMode.ypos+genBarsMode.bHeight);  
          text("Sample Mode:", genBarsAuidoMode.xpos-10, genBarsAuidoMode.ypos+genBarsAuidoMode.bHeight);  
          text("Width:", genBarsWidth.xpos-10, genBarsWidth.ypos+genBarsWidth.size);  
          text("Spacing:", genBarsSpacing.xpos-10, genBarsSpacing.ypos+genBarsSpacing.size);           
          text("Amplitude:", genBarsAmplitude.xpos-10, genBarsAmplitude.ypos+genBarsAmplitude.size);  
          text("Decay:", genBarsDecay.xpos-10, genBarsDecay.ypos+genBarsDecay.size);  
          text("Fill Color:", genBarsFillColor.xpos-10, genBarsFillColor.ypos+genBarsFillColor.size);  

          genBarsMode.display();
          genBarsAuidoMode.display();
          genBarsWidth.display();
          genBarsSpacing.display();
          genBarsAmplitude.display();
          genBarsDecay.display();
          genBarsFillColor.display();
          break;    

        case 13:  //"Template"
          text("Template 1:", genTemplateColor.xpos-10, genTemplateColor.ypos+genTemplateColor.size);  
          text("Template 2:", genTemplateStrokeWeight.xpos-10, genTemplateStrokeWeight.ypos+genTemplateStrokeWeight.size);       
          text("Template 3:", genTemplateSize.xpos-10, genTemplateSize.ypos+genTemplateSize.size);    
          text("Template 4:", genTemplateEnableSmoothing.xpos-10, genTemplateEnableSmoothing.ypos+genTemplateEnableSmoothing.size);  

          genTemplateColor.display();
          genTemplateStrokeWeight.display();
          genTemplateSize.display();
          genTemplateEnableSmoothing.display();
          break;
        } //end generated dropdown switch
        break;  
      case cTypeIDDataFile: //recorded data file input 
         text("Play Data File:\nCompatible with recorded files from this software. Plays the file back, looping endlessly.\nOnly supports one data file media content at a time.\nWill be expanded in the future.", xOffset+180, yOffset+100); 
         text("File Path: "+mediaContentTile[workingTileID].filePath, xOffset+180, yOffset+200); 
        break;  
      case cTypeIDExtData: //external data stream ------------------------------------------------------------------------------------

        text("Currently only Glediator serial protocol is supported for external data input.\nExpect to add other protocols in the future.\nSoftware expects it to be setup for:\nWidth: "+matrix.width+"   Height: "+matrix.height, xOffset+180, yOffset+200); 
		try {
        if (matrix.externalDataEnable == true && Serial.list()[matrix.externalDataPort] != null)
          text("External Data:\nReceiving on serial port: "+Serial.list()[matrix.externalDataPort]+" at "+matrix.externalDataBaud+" baud", xOffset+180, yOffset+100); 
        else 
        {
          text("External Data is not running properly, check configurations.", xOffset+180, yOffset+100); 
        }
		}
		catch(Exception e)
		{

		}
		try {
		text("Tried to use "+Serial.list()[matrix.externalDataPort]+" but failed or was unavailable", xOffset+180, yOffset+140);
		}
		catch(Exception e)
		{
			
		}

        text("Packet Rate(mS): "+ExternalDataMillis, xOffset+180, yOffset+320); 
        break;
      } //end typeID switch
      break;
    case cOverlayEffectsMenu:
      textSize(22);
      fill(gui.textMenuColor);
      textAlign(LEFT);
      text("Layer Effects Menu: Feed "+char(64+SelectFeedID)+", Layer "+(SelectLayerID+1), xOffset+20, yOffset+40);

      text("Minimum Color:", xOffset+20, yOffset+130);
      text("Maximum Color:", xOffset+20, yOffset+280);   

      text("(Set Alpha to 0 to disable)", effectsTintColor.xpos-10, effectsTintColor.ypos+(effectsTintColor.size*2));  

      textAlign(RIGHT);
      text("Filter:", effectsOptionsDD.xpos-10, effectsOptionsDD.ypos+effectsOptionsDD.bHeight-5);
      text("Contrast:", effectContrastNIF.xpos-10, effectContrastNIF.ypos+effectContrastNIF.size);

      text("Red:", effectMinColorSliderRed.xpos-10, effectMinColorSliderRed.ypos+effectMinColorSliderRed.slHeight);
      text("Green:", effectMinColorSliderGreen.xpos-10, effectMinColorSliderGreen.ypos+effectMinColorSliderGreen.slHeight);     
      text("Blue:", effectMinColorSliderBlue.xpos-10, effectMinColorSliderBlue.ypos+effectMinColorSliderBlue.slHeight);      

      text("Red:", effectMaxColorSliderRed.xpos-10, effectMaxColorSliderRed.ypos+effectMaxColorSliderRed.slHeight);
      text("Green:", effectMaxColorSliderGreen.xpos-10, effectMaxColorSliderGreen.ypos+effectMaxColorSliderGreen.slHeight);     
      text("Blue:", effectMaxColorSliderBlue.xpos-10, effectMaxColorSliderBlue.ypos+effectMaxColorSliderBlue.slHeight); 
      
      text("Tint Color:", effectsTintColor.xpos-10, effectsTintColor.ypos+effectsTintColor.size);   
       
      effectsTintColor.display();

      effectsOptionsDD.display();
      effectsFilterInputField.display();
      effectContrastNIF.display();
      effectMinColorNIFRed.display();
      effectMinColorNIFGreen.display();
      effectMinColorNIFBlue.display();
      effectMaxColorNIFRed.display();
      effectMaxColorNIFGreen.display();
      effectMaxColorNIFBlue.display();      

      effectMinColorSliderRed.display();
      effectMinColorSliderGreen.display();
      effectMinColorSliderBlue.display();
      effectMaxColorSliderRed.display();
      effectMaxColorSliderGreen.display();
      effectMaxColorSliderBlue.display();  

      break;
    case cOverlayMainMenu:
      textSize(18);
      fill(gui.textMenuColor);
      text("Main Menu:", xOffset+20, yOffset+20);   
      textSize(14);
	  textLeading(14);
      text("(Edit INI files and reload config files to\napply changes)", xOffset+10, yOffset+40);  
      text("Media Content Files", xOffset+210, yOffset+65);  

	  
	if(matrix.transmissionType == 1|| matrix.transmissionType == 2)
		{
      text("Output Serial Port: "+Serial.list()[matrix.serialPort], xOffset+20, yOffset+110);
		} 
      text("Output Serial Baud: "+matrix.serialBaud, xOffset+20, yOffset+130);
      text("Output FPS: "+matrix.outputFPS+"mS", xOffset+20, yOffset+150);
      text("Output Color Order: "+cColorOrderStr[matrix.colorOrderID], xOffset+20, yOffset+170);
      text("Aurora Command: "+matrix.auroraCMD, xOffset+20, yOffset+190); 
      text("Name: "+matrix.name, xOffset+20, yOffset+240);   
      text("Patch File: "+matrix.patchFileName, xOffset+20, yOffset+260);       
      text("Content File: "+matrix.contentFileName, xOffset+20, yOffset+280);   
      text("Footage Path: "+matrix.footagePath, xOffset+20, yOffset+300);   
      text("Automatic File: "+matrix.automaticFileName, xOffset+20, yOffset+320); 

      if (matrix.externalDataEnable == true && matrix.externalDataRunning == true)
      {
        text("External Data Port: "+Serial.list()[matrix.externalDataPort], xOffset+20, yOffset+350);   
        text("External Port Baud: "+matrix.externalDataBaud, xOffset+20, yOffset+370);
      } 
      else text("No External Data Port", xOffset+20, yOffset+350);   

      reloadConfigFilesButton.display();
      loadContentFileButton.display();
      saveContentFileButton.display();
      break;
    } //end ObjID switch

    menuCloseButton.xpos = xOffset+(Width-100);
    menuCloseButton.ypos = yOffset+20;
    menuCloseButton.display();

    // popStyle();
  } //end display()

  //-----------------------------------------------------------------------------------------------

  void initMenu()
  {
    println("initMenu() overlay menu");

    //---------------------------------------------------------------------------

    switch(autoPosition) 
    {
    case 0:
    default:
      xOffset = xpos;
      yOffset = ypos;
      break;
    case 1: //= center X&Y
      xOffset = (cDefaultGUIWidth-Width)/2;
      yOffset = (cDefaultGUIHeight-Height)/2;
      break;
    }//end switch 

    //---------------------------------------------------------------------------

    switch(ObjID)
    {
    case cOverlayMediaTileMenu:  //Media Content Tiles
      //start common
      for (int i = 0; i != menuMediaTileMenuButtons.length; i++)
      {
        menuMediaTileMenuButtons[i].xpos = xOffset+20;
        menuMediaTileMenuButtons[i].ypos = yOffset+80+(i*35);
        menuMediaTileMenuButtons[i].selected = false;
      }

      if (mediaContentTile[workingTileID] != null && mediaContentTile[workingTileID].typeID > 0)
      {
        //rule because of gaps in the ID#s for typeID
        if (mediaContentTile[workingTileID].typeID == cTypeIDExtData) menuMediaTileMenuButtons[6].selected = true; 
        else menuMediaTileMenuButtons[mediaContentTile[workingTileID].typeID-1].selected = true;
      }
      //end common

      switch(getmediaContentObjTypeID())
      {
      case cTypeIDNULL:

        break;
      case cTypeIDVideo:    
      case cTypeIDAniGIF:
      case cTypeIDImage:
      case cTypeIDSpout:
        imgScalingOptionsDD.xpos = xOffset+180;
        imgScalingOptionsDD.ypos = yOffset+130;
        imgScalingOptionsDD.setValue(mediaContentTile[workingTileID].scaleOption);

        contentOffsetX.setValue(mediaContentTile[workingTileID].offsetX);  
        contentOffsetY.setValue(mediaContentTile[workingTileID].offsetY);
        mediaMenuGUICropW.setValue(mediaContentTile[workingTileID].cropWidth);
        mediaMenuGUICropH.setValue(mediaContentTile[workingTileID].cropHeight);    

        contentOffsetX.xpos = xOffset+450;
        contentOffsetX.ypos = yOffset+80; 
        contentOffsetY.xpos = xOffset+450;
        contentOffsetY.ypos = yOffset+115;

        mediaMenuGUICropW.xpos = xOffset+660; 
        mediaMenuGUICropW.ypos = yOffset+80;
        mediaMenuGUICropH.xpos = xOffset+660; 
        mediaMenuGUICropH.ypos = yOffset+115;

        break;
      case cTypeIDGenerated: //--------------------------------------------------------------------------------------------------

        //common to all Generated Types
        generatedMediaDD.setValue(mediaContentTile[workingTileID].generatedType); //ensure its updated, where else could it be set?
        generatedMediaFPS.setValue(mediaContentTile[workingTileID].contentFPS);


        generatedMediaDD.xpos = xOffset+410;
        generatedMediaDD.ypos = yOffset+60;

        generatedMediaFPS.xpos = xOffset+580;
        generatedMediaFPS.ypos = yOffset+60;
        //end common

        switch(mediaContentTile[workingTileID].generatedType)  //add additional generated types/objects here
        {
        case 0: //null

          break;

        case 1: //"Text"
          //intialize the GUI element positions
          genTextLabel.xpos = xOffset+280;  
          genTextLabel.ypos = yOffset+110;

          genNIFTextSize.xpos = xOffset+280;
          genNIFTextSize.ypos = yOffset+150;

          genNIFTextXOffset.xpos = xOffset+280;
          genNIFTextXOffset.ypos = yOffset+190;

          genNIFTextYOffset.xpos = xOffset+280;
          genNIFTextYOffset.ypos = yOffset+230;

          genTextScrollTypeDD.xpos = xOffset+280;
          genTextScrollTypeDD.ypos = yOffset+270;

          genTextFontTypeDD.xpos = xOffset+280;
          genTextFontTypeDD.ypos = yOffset+310;

          genTextColor.xpos = xOffset+280;
          genTextColor.ypos = yOffset+350;    

          genTextBackgroundColor.xpos = xOffset+280;
          genTextBackgroundColor.ypos = yOffset+390;

          //load initial values into GUI elements
          genTextLabel.label = genContentText[mediaContentTile[workingTileID].instanceID].textLabel;
          genNIFTextSize.setValue(genContentText[mediaContentTile[workingTileID].instanceID].textSize);
          genNIFTextXOffset.setValue(genContentText[mediaContentTile[workingTileID].instanceID].xOffset);
          genNIFTextYOffset.setValue(genContentText[mediaContentTile[workingTileID].instanceID].yOffset);
          genTextColor.selColor = genContentText[mediaContentTile[workingTileID].instanceID].fillColor;
          genTextBackgroundColor.selColor = genContentText[mediaContentTile[workingTileID].instanceID].bgColor;
          break;
        case 2: //"Star Field"
          //intialize the GUI element positions
          genStarsShapeDD.xpos = xOffset+300;
          genStarsShapeDD.ypos = yOffset+110;

          genStarsSizeNIF.xpos = xOffset+300;
          genStarsSizeNIF.ypos = yOffset+150;

          genStarsStrokeNIF.xpos = xOffset+300;
          genStarsStrokeNIF.ypos = yOffset+190;

          genStarsQuantityNIF.xpos = xOffset+300;
          genStarsQuantityNIF.ypos = yOffset+230;

          genStarsDecayNIF.xpos = xOffset+300;
          genStarsDecayNIF.ypos = yOffset+270;

          genStarsFillColor.xpos = xOffset+300;
          genStarsFillColor.ypos = yOffset+310;

          genStarsStrokeColor.xpos = xOffset+450;
          genStarsStrokeColor.ypos = yOffset+310;

          genStarsZDistEnable.xpos = xOffset+300;
          genStarsZDistEnable.ypos = yOffset+350;

          //load initial values into GUI elements
          genStarsShapeDD.setValue(genContentStarField[mediaContentTile[workingTileID].instanceID].starShape);
          genStarsSizeNIF.setValue(genContentStarField[mediaContentTile[workingTileID].instanceID].starSize);
          genStarsQuantityNIF.setValue(genContentStarField[mediaContentTile[workingTileID].instanceID].starQuantity);
          genStarsStrokeNIF.setValue(genContentStarField[mediaContentTile[workingTileID].instanceID].starStrokeWidth);
          genStarsDecayNIF.setValue(genContentStarField[mediaContentTile[workingTileID].instanceID].decay);
          genStarsFillColor.selColor = genContentStarField[mediaContentTile[workingTileID].instanceID].fillColor;
          genStarsStrokeColor.selColor = genContentStarField[mediaContentTile[workingTileID].instanceID].strokeColor;
          genStarsZDistEnable.selected = genContentStarField[mediaContentTile[workingTileID].instanceID].starZDist;
          break;
        case 3: //"Falling Blocks"
          genFallingBlocksDirection.xpos = xOffset+330;
          genFallingBlocksDirection.ypos = yOffset+110;
          genFallingBlocksSize.xpos = xOffset+330;
          genFallingBlocksSize.ypos = yOffset+150;
          genFallingBlocksDecay.xpos = xOffset+330;
          genFallingBlocksDecay.ypos = yOffset+190;
          genFallingBlocksFrequency.xpos = xOffset+330;
          genFallingBlocksFrequency.ypos = yOffset+230;
          genFallingBlocksColor.xpos = xOffset+330;
          genFallingBlocksColor.ypos = yOffset+270;

          //load initial values into GUI elements
          genFallingBlocksDirection.setValue(genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].direction);
          genFallingBlocksSize.setValue(genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].size);
          genFallingBlocksDecay.setValue(genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].decay);
          genFallingBlocksFrequency.setValue(genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].frequency);
          genFallingBlocksColor.selColor = genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].fillColor;
          break;         
        case 4: //"Meta Balls"
          genMetaBallsColorMode.xpos = xOffset+330;
          genMetaBallsColorMode.ypos = yOffset+110;
          genMetaBallsAmount.xpos = xOffset+330;
          genMetaBallsAmount.ypos = yOffset+150;
          genMetaBallsSize.xpos = xOffset+330;
          genMetaBallsSize.ypos = yOffset+190;
          genMetaBallsFequency.xpos = xOffset+330;
          genMetaBallsFequency.ypos = yOffset+230;
          genMetaBallsColor.xpos = xOffset+330;
          genMetaBallsColor.ypos = yOffset+270;

          //load initial values into GUI elements
          genMetaBallsColorMode.setValue(genContentMetaBalls[mediaContentTile[workingTileID].instanceID].colorMode);
          genMetaBallsAmount.setValue(genContentMetaBalls[mediaContentTile[workingTileID].instanceID].ballAmount);
          genMetaBallsSize.setValue(genContentMetaBalls[mediaContentTile[workingTileID].instanceID].ballSize);
          genMetaBallsFequency.setValue(genContentMetaBalls[mediaContentTile[workingTileID].instanceID].colorFrequency);
          genMetaBallsColor.selColor = genContentMetaBalls[mediaContentTile[workingTileID].instanceID].fillColor;
          break;
        case 5: //"Ripples"
          genRipplesShape.xpos = xOffset+330;
          genRipplesShape.ypos = yOffset+110; 

          genRipplesAudioMode.xpos = xOffset+330;
          genRipplesAudioMode.ypos = yOffset+140;
          genRipplesAmplitude.xpos = xOffset+330;            
          genRipplesAmplitude.ypos = yOffset+180;    
          genRipplesfillMethod.xpos = xOffset+330;
          genRipplesfillMethod.ypos = yOffset+220;
          genRipplesStrokeWidth.xpos = xOffset+330;
          genRipplesStrokeWidth.ypos = yOffset+260;
          genRipplesFillColor.xpos = xOffset+330;
          genRipplesFillColor.ypos = yOffset+300;
          genRipplesStrokeColor.xpos = xOffset+330;
          genRipplesStrokeColor.ypos = yOffset+340;


          //load initial values into GUI elements
          genRipplesShape.setValue(genContentRipples[mediaContentTile[workingTileID].instanceID].shape); 
          genRipplesAudioMode.setValue(genContentRipples[mediaContentTile[workingTileID].instanceID].audioMode); 
          genRipplesAmplitude.setValue(genContentRipples[mediaContentTile[workingTileID].instanceID].amplitude); 
          genRipplesStrokeWidth.setValue(genContentRipples[mediaContentTile[workingTileID].instanceID].strokeWeight);
          genRipplesfillMethod.setValue(genContentRipples[mediaContentTile[workingTileID].instanceID].fillMethod); 
          genRipplesFillColor.selColor = genContentRipples[mediaContentTile[workingTileID].instanceID].fillColor;
          genRipplesStrokeColor.selColor = genContentRipples[mediaContentTile[workingTileID].instanceID].strokeColor;
          break;       
        case 6: //"Spiral"
          genSpiralColorMode.xpos = xOffset+330;
          genSpiralColorMode.ypos = yOffset+110;
          genSpiralModeVariable.xpos = xOffset+330;
          genSpiralModeVariable.ypos = yOffset+150;
          genSpiralCoils.xpos = xOffset+330;
          genSpiralCoils.ypos = yOffset+190;
          genSpiralDecay.xpos = xOffset+330;
          genSpiralDecay.ypos = yOffset+230;
          genSpiralColor.xpos = xOffset+330;
          genSpiralColor.ypos = yOffset+270;

          //load initial values into GUI elements
          genSpiralColorMode.setValue(genContentSpiral[mediaContentTile[workingTileID].instanceID].colorMode); 
          genSpiralModeVariable.setValue(genContentSpiral[mediaContentTile[workingTileID].instanceID].modeVariable); 
          genSpiralCoils.setValue(genContentSpiral[mediaContentTile[workingTileID].instanceID].coils);
          genSpiralDecay.setValue(genContentSpiral[mediaContentTile[workingTileID].instanceID].decay);
          genSpiralColor.selColor = genContentSpiral[mediaContentTile[workingTileID].instanceID].strokeColor;
          break;    
        case 7: //"Solid Color"
          genSolidColorFill.xpos = xOffset+300;
          genSolidColorFill.ypos = yOffset+110;

          //load initial values into GUI elements
          genSolidColorFill.selColor = genContentSolidColor[mediaContentTile[workingTileID].instanceID].bgColor;
          break;        
        case 8: //"Plasma"
          //no parameters
          break;
        case 9: //"2D Shape"
          gen2DShapeFillColor.xpos = xOffset+330;
          gen2DShapeFillColor.ypos = yOffset+110;
          gen2DShapeStrokeColor.xpos = xOffset+330;
          gen2DShapeStrokeColor.ypos = yOffset+150;
          gen2DShapeStrokeWeight.xpos = xOffset+330;
          gen2DShapeStrokeWeight.ypos = yOffset+190;
          gen2DShapeSize.xpos = xOffset+330;
          gen2DShapeSize.ypos = yOffset+230;
          gen2DShapeRotationSpeed.xpos = xOffset+330;
          gen2DShapeRotationSpeed.ypos = yOffset+270;          
          gen2DShapeZoomSpeed.xpos = xOffset+330;
          gen2DShapeZoomSpeed.ypos = yOffset+310;
          gen2DShapeZoomMax.xpos = xOffset+330;
          gen2DShapeZoomMax.ypos = yOffset+350;         
          gen2DShapeZoomMin.xpos = xOffset+330;
          gen2DShapeZoomMin.ypos = yOffset+390;
          gen2DShapeEnableSmoothing.xpos = xOffset+330;
          gen2DShapeEnableSmoothing.ypos = yOffset+430;

          //load initial values into GUI elements        
          gen2DShapeFillColor.selColor = genContent2DShape[mediaContentTile[workingTileID].instanceID].fillColor;
          gen2DShapeStrokeColor.selColor = genContent2DShape[mediaContentTile[workingTileID].instanceID].strokeColor;         
          gen2DShapeStrokeWeight.setValue(genContent2DShape[mediaContentTile[workingTileID].instanceID].strokeWeight);
          gen2DShapeSize.setValue(genContent2DShape[mediaContentTile[workingTileID].instanceID].baseSize);
          gen2DShapeRotationSpeed.setValue(genContent2DShape[mediaContentTile[workingTileID].instanceID].rotationSpeed);
          gen2DShapeZoomSpeed.setValue(genContent2DShape[mediaContentTile[workingTileID].instanceID].zoomSpeed);
          gen2DShapeZoomMax.setValue(genContent2DShape[mediaContentTile[workingTileID].instanceID].zoomMax);
          gen2DShapeZoomMin.setValue(genContent2DShape[mediaContentTile[workingTileID].instanceID].zoomMin);
          gen2DShapeEnableSmoothing.selected = genContent2DShape[mediaContentTile[workingTileID].instanceID].enableSmoothing;

          break;
        case 10:  //"3D Shape"
          gen3DShapeSize.xpos = xOffset+330;
          gen3DShapeSize.ypos = yOffset+110;
          gen3DShapeRotationX.xpos = xOffset+330;
          gen3DShapeRotationX.ypos = yOffset+150;
          gen3DShapeRotationY.xpos = xOffset+330;
          gen3DShapeRotationY.ypos = yOffset+190;
          gen3DShapeStrokeWeight.xpos = xOffset+330;
          gen3DShapeStrokeWeight.ypos = yOffset+230;
          gen3DShapeEnableSmoothing.xpos = xOffset+330;
          gen3DShapeEnableSmoothing.ypos = yOffset+270;
          gen3DShapeStrokeColor.xpos = xOffset+330;
          gen3DShapeStrokeColor.ypos = yOffset+310;

          //load initial values into GUI elements
          gen3DShapeSize.setValue(genContent3DShape[mediaContentTile[workingTileID].instanceID].size);
          gen3DShapeStrokeWeight.setValue(genContent3DShape[mediaContentTile[workingTileID].instanceID].strokeWeight);
          gen3DShapeRotationX.setValue(genContent3DShape[mediaContentTile[workingTileID].instanceID].rotationValX);
          gen3DShapeRotationY.setValue(genContent3DShape[mediaContentTile[workingTileID].instanceID].rotationValY);
          gen3DShapeEnableSmoothing.selected = genContent3DShape[mediaContentTile[workingTileID].instanceID].enableSmoothing;
          gen3DShapeStrokeColor.selColor = genContent3DShape[mediaContentTile[workingTileID].instanceID].strokeColor;
          break;
        case 11:  //"Sine Wave"
          genSineWaveMode.xpos = xOffset+330;
          genSineWaveMode.ypos = yOffset+110;
          genSineWaveAuidoMode.xpos = xOffset+330;
          genSineWaveAuidoMode.ypos = yOffset+150;
          genSineWaveYOffset.xpos = xOffset+330;
          genSineWaveYOffset.ypos = yOffset+190;
          genSineWaveAmplitude.xpos = xOffset+330;
          genSineWaveAmplitude.ypos = yOffset+230;
          genSineWavePeriod.xpos = xOffset+330;
          genSineWavePeriod.ypos = yOffset+270;
          genSineWaveDecay.xpos = xOffset+330;
          genSineWaveDecay.ypos = yOffset+310;
          genSineWaveFillColor.xpos = xOffset+330;
          genSineWaveFillColor.ypos = yOffset+350;

          //load initial values into GUI elements
          genSineWaveMode.setValue(genContentSineWave[mediaContentTile[workingTileID].instanceID].mode); 
          genSineWaveAuidoMode.setValue(genContentSineWave[mediaContentTile[workingTileID].instanceID].audioMode); 
          genSineWaveYOffset.setValue(genContentSineWave[mediaContentTile[workingTileID].instanceID].yOffset); 
          genSineWaveAmplitude.setValue(genContentSineWave[mediaContentTile[workingTileID].instanceID].amplitude); 
          genSineWavePeriod.setValue(genContentSineWave[mediaContentTile[workingTileID].instanceID].period); 
          genSineWaveDecay.setValue(genContentSineWave[mediaContentTile[workingTileID].instanceID].decay); 
          genSineWaveFillColor.selColor = genContentSineWave[mediaContentTile[workingTileID].instanceID].fillColor; 
          break;       
        case 12:  //"Dancing Bars"
          genBarsMode.xpos = xOffset+330;
          genBarsMode.ypos = yOffset+110;
          genBarsAuidoMode.xpos = xOffset+330;
          genBarsAuidoMode.ypos = yOffset+150;
          genBarsWidth.xpos = xOffset+330;
          genBarsWidth.ypos = yOffset+190;
          genBarsSpacing.xpos = xOffset+330;
          genBarsSpacing.ypos = yOffset+230;
          genBarsAmplitude.xpos = xOffset+330;
          genBarsAmplitude.ypos = yOffset+270;
          genBarsDecay.xpos = xOffset+330;
          genBarsDecay.ypos = yOffset+310;
          genBarsFillColor.xpos = xOffset+330;
          genBarsFillColor.ypos = yOffset+350;

          //load initial values into GUI elements
          genBarsMode.setValue(genContentBars[mediaContentTile[workingTileID].instanceID].mode);
          genBarsAuidoMode.setValue(genContentBars[mediaContentTile[workingTileID].instanceID].audioMode);
          genBarsWidth.setValue(genContentBars[mediaContentTile[workingTileID].instanceID].barWidth);
          genBarsSpacing.setValue(genContentBars[mediaContentTile[workingTileID].instanceID].barSpacing);
          genBarsAmplitude.setValue(genContentBars[mediaContentTile[workingTileID].instanceID].barAmplitude);
          genBarsDecay.setValue(genContentBars[mediaContentTile[workingTileID].instanceID].decay); 
          genBarsFillColor.selColor = genContentBars[mediaContentTile[workingTileID].instanceID].fillColor; 
          break;           
        case 13:  //"Template"
          genTemplateColor.xpos = xOffset+330;
          genTemplateColor.ypos = yOffset+110;

          genTemplateStrokeWeight.xpos = xOffset+330;
          genTemplateStrokeWeight.ypos = yOffset+140;

          genTemplateSize.xpos = xOffset+330;
          genTemplateSize.ypos = yOffset+190;

          genTemplateEnableSmoothing.xpos = xOffset+330;
          genTemplateEnableSmoothing.ypos = yOffset+230;

          //load initial values into GUI elements
          //user must add custom ones using the same methods as the rest
          break;
        } //end generated ID switch
        break;   //--------------------------------------------------------------------------------------------------    
      case cTypeIDDataFile:  //recorded data file input 

        break;
      case cTypeIDExtData:
        //select COM ports and such
        break;
      } //end typeID switch

      break;
    case cOverlayEffectsMenu:
      effectsOptionsDD.xpos = xOffset+100; 
      effectsOptionsDD.ypos = yOffset+80;  
      effectsFilterInputField.xpos = xOffset+250; 
      effectsFilterInputField.ypos = yOffset+80;  

      effectsTintColor.xpos = xOffset+140; 
      effectsTintColor.ypos = yOffset+440; 

      effectContrastNIF.xpos = xOffset+520; 
      effectContrastNIF.ypos = yOffset+80;  

      effectMinColorNIFRed.xpos = xOffset+350; 
      effectMinColorNIFRed.ypos = yOffset+140;  
      effectMinColorNIFGreen.xpos = xOffset+350; 
      effectMinColorNIFGreen.ypos = yOffset+180;  
      effectMinColorNIFBlue.xpos = xOffset+350; 
      effectMinColorNIFBlue.ypos = yOffset+220; 

      effectMaxColorNIFRed.xpos = xOffset+350; 
      effectMaxColorNIFRed.ypos = yOffset+300;  
      effectMaxColorNIFGreen.xpos = xOffset+350; 
      effectMaxColorNIFGreen.ypos = yOffset+340;  
      effectMaxColorNIFBlue.xpos = xOffset+350; 
      effectMaxColorNIFBlue.ypos = yOffset+380; 


      effectMinColorSliderRed.xpos = xOffset+100; 
      effectMinColorSliderRed.ypos = yOffset+140;  
      effectMinColorSliderGreen.xpos = xOffset+100; 
      effectMinColorSliderGreen.ypos = yOffset+180;  
      effectMinColorSliderBlue.xpos = xOffset+100; 
      effectMinColorSliderBlue.ypos = yOffset+220;  

      effectMaxColorSliderRed.xpos = xOffset+100; 
      effectMaxColorSliderRed.ypos = yOffset+300;  
      effectMaxColorSliderGreen.xpos = xOffset+100; 
      effectMaxColorSliderGreen.ypos = yOffset+340;  
      effectMaxColorSliderBlue.xpos = xOffset+100;    
      effectMaxColorSliderBlue.ypos = yOffset+380;  

      effectsOptionsDD.setValue(contentLayerPtr.effectFilterIDNum);
      effectsFilterInputField.setValue(contentLayerPtr.effectFilterVariable);

      effectsTintColor.selColor = contentLayerPtr.tintColor;

      effectContrastNIF.setValue(contentLayerPtr.effectContrast);
      effectMinColorNIFRed.setValue(red(contentLayerPtr.minColor));
      effectMinColorNIFGreen.setValue(green(contentLayerPtr.minColor)); 
      effectMinColorNIFBlue.setValue(blue(contentLayerPtr.minColor));

      effectMaxColorNIFRed.setValue(red(contentLayerPtr.maxColor));
      effectMaxColorNIFGreen.setValue(green(contentLayerPtr.maxColor)); 
      effectMaxColorNIFBlue.setValue(blue(contentLayerPtr.maxColor));   

      effectMinColorSliderRed.setValue((int)red(contentLayerPtr.minColor));
      effectMinColorSliderGreen.setValue((int)green(contentLayerPtr.minColor));
      effectMinColorSliderBlue.setValue((int)blue(contentLayerPtr.minColor));

      effectMaxColorSliderRed.setValue((int)red(contentLayerPtr.maxColor));
      effectMaxColorSliderGreen.setValue((int)green(contentLayerPtr.maxColor));
      effectMaxColorSliderBlue.setValue((int)blue(contentLayerPtr.maxColor));

      break;
    case cOverlayMainMenu:
      reloadConfigFilesButton.xpos = xOffset+15; 
      reloadConfigFilesButton.ypos = yOffset+70;  
      loadContentFileButton.xpos = xOffset+170; 
      loadContentFileButton.ypos = yOffset+70;  
      saveContentFileButton.xpos = xOffset+280; 
      saveContentFileButton.ypos = yOffset+70;   
      break;
    } //end ObjID switch
  } //end display()

  //-----------------------------------------------------------------------------------------------

  boolean over() 
  {
    if (mouseXS >= xpos && mouseXS <= xpos+Width && mouseYS >= ypos && mouseYS <= ypos+Height) 
    {      
      return true;
    } 
	else {
      return false;
    }
  } //end over()

  //-----------------------------------------------------------------------------------------------

  boolean overEllipse() 
  {
    if (mouseXS >= xpos-(Width/2) && mouseXS <= xpos+(Width/2) && mouseYS >= ypos-(Height/2) && mouseYS <= ypos+(Height/2)) 
    {      
      return true;
    } 
	else {
      return false;
    }
  } //end over()  

  //-----------------------------------------------------------------------------------------------

  boolean mousePressed()
  {

    switch(ObjID)
    {
    case cOverlayMediaTileMenu:  //Media Content Tiles
      //common to all types
      for (int i = 0; i != menuMediaTileMenuButtons.length; i++)
      {
        if (menuMediaTileMenuButtons[i].over())
        {
          println("Clicked menuMediaTileMenuButtons "+i);
          menuMediaTileMenuButtonsFunc(i);
          menuMediaTileMenuButtons[i].selected = true; //the above function clears all the button .selected, so reset .selected.
          allowMousePressHold = false; //DEBUG-issue with opening file dialog twice
          return true;
        } //end if()
      } //end for()
      //end common

      switch(getmediaContentObjTypeID())
      {
      case cTypeIDNULL:

        break;
      case cTypeIDVideo:    
      case cTypeIDAniGIF:
      case cTypeIDImage:
      case cTypeIDSpout:
        if (contentOffsetX.over())   return true;
        if (contentOffsetY.over())   return true;
        if (mediaMenuGUICropW.over())  return true;  
        if (mediaMenuGUICropH.over()) return true;
        if (imgScalingOptionsDD.over()) return true;    
        break;
      case cTypeIDGenerated: //--------------------------------------------------------------------------------------------------
        if (generatedMediaDD.over()) return true;
        if (generatedMediaFPS.over()) return true;

        //start specific for each generated type need switch 
        switch(mediaContentTile[workingTileID].generatedType)  //add additional generated types/objects here
        {
        case 0: //null

          break;

        case 1: //"Text"
          if (genTextLabel.over()) return true;
          if (genNIFTextSize.over()) return true; //will be true if any of it was clicked
          if (genNIFTextXOffset.over()) return true; //will be true if any of it was clicked
          if (genNIFTextYOffset.over()) return true; //will be true if any of it was clicked
          if (genTextColor.over()) return true;
          if (genTextBackgroundColor.over()) return true;
          if (genTextScrollTypeDD.over()) return true;     
          if (genTextFontTypeDD.over()) return true;
          break;
        case 2: //"Star Field"
          if (genStarsShapeDD.over()) return true;
          if (genStarsStrokeNIF.over()) return true; //will be true if any of it was clicked
          if (genStarsSizeNIF.over()) return true; //will be true if any of it was clicked
          if (genStarsQuantityNIF.over()) return true; //will be true if any of it was clicked
          if (genStarsDecayNIF.over()) return true; //will be true if any of it was clicked
          if (genStarsZDistEnable.over()) return true;
          if (genStarsFillColor.over()) return true;     
          if (genStarsStrokeColor.over()) return true;  
          break;
        case 3: //"Falling Blocks"
          if (genFallingBlocksDirection.over()) return true;
          if (genFallingBlocksSize.over()) return true;
          if (genFallingBlocksDecay.over()) return true;
          if (genFallingBlocksFrequency.over()) return true;
          if (genFallingBlocksColor.over()) return true;
          break;
        case 4: //"Meta Balls"
          if (genMetaBallsColorMode.over()) return true;
          if (genMetaBallsAmount.over()) return true;
          if (genMetaBallsSize.over()) return true;
          if (genMetaBallsFequency.over()) return true;
          if (genMetaBallsColor.over()) return true;
          break;
        case 5: //"Ripples"
          if (genRipplesShape.over()) return true;
          if (genRipplesAudioMode.over()) return true;
          if (genRipplesAmplitude.over()) return true;
          if (genRipplesStrokeWidth.over()) return true;         
          if (genRipplesfillMethod.over()) return true;
          if (genRipplesFillColor.over()) return true;
          if (genRipplesStrokeColor.over()) return true;
          break;       
        case 6: //"Spiral"
          if (genSpiralColorMode.over()) return true;
          if (genSpiralModeVariable.over()) return true;
          if (genSpiralCoils.over()) return true;
          if (genSpiralDecay.over()) return true;
          if (genSpiralColor.over()) return true;
          break;    
        case 7: //"Solid Color"
          if (genSolidColorFill.over()) return true;
          break;        
        case 8: //"Plasma"
          //no parameters
          break;
        case 9: //"2D Shape"
          if (gen2DShapeFillColor.over()) return true;
          if (gen2DShapeStrokeColor.over()) return true;
          if (gen2DShapeStrokeWeight.over()) return true;
          if (gen2DShapeSize.over()) return true;
          if (gen2DShapeRotationSpeed.over()) return true;
          if (gen2DShapeZoomSpeed.over()) return true;
          if (gen2DShapeZoomMax.over()) return true; 
          if (gen2DShapeZoomMin.over()) return true;
          if (gen2DShapeEnableSmoothing.over()) return true;
          break;
        case 10:  //"3D Shape"
          if (gen3DShapeSize.over()) return true;
          if (gen3DShapeRotationX.over()) return true;
          if (gen3DShapeRotationY.over()) return true;
          if (gen3DShapeStrokeWeight.over()) return true;
          if (gen3DShapeEnableSmoothing.over()) return true;
          if (gen3DShapeStrokeColor.over()) return true;       
          break;
        case 11:  //"Sine Wave"
          if (genSineWaveMode.over()) return true;
          if (genSineWaveAuidoMode.over()) return true;
          if (genSineWaveYOffset.over()) return true;
          if (genSineWaveAmplitude.over()) return true;
          if (genSineWavePeriod.over()) return true;
          if (genSineWaveDecay.over()) return true;       
          if (genSineWaveFillColor.over()) return true;       
          break;       
        case 12:  //"Dancing Bars"
          if (genBarsMode.over()) return true;
          if (genBarsAuidoMode.over()) return true;
          if (genBarsWidth.over()) return true;
          if (genBarsSpacing.over()) return true;
          if (genBarsAmplitude.over()) return true;
          if (genBarsDecay.over()) return true;
          if (genBarsFillColor.over()) return true;         
          break;              
        case 13:  //"Template"
          if (genTemplateColor.over()) return true;
          if (genTemplateStrokeWeight.over()) return true;
          if (genTemplateSize.over()) return true;
          if (genTemplateEnableSmoothing.over()) return true;
          break;
        } //end typeIDNum switch()
        break;
      case cTypeIDDataFile: //recorded data file input 
        //no GUI elements to check
        break;  
      case cTypeIDExtData:
        //no GUI elements to check
        break;
      } //end mediaContentObjTypeID switch
      break;
    case cOverlayEffectsMenu:
      if (effectsOptionsDD.over()) return true;
      if (effectsFilterInputField.over()) return true;
      if (effectContrastNIF.over()) return true;
      if (effectsTintColor.over()) return true;

      if (effectMinColorNIFRed.over()) return true;
      if (effectMinColorNIFGreen.over()) return true;
      if (effectMinColorNIFBlue.over()) return true;
      if (effectMaxColorNIFRed.over()) return true;
      if (effectMaxColorNIFGreen.over()) return true;
      if (effectMaxColorNIFBlue.over()) return true;       
      if (effectMinColorSliderRed.over()) return true;
      if (effectMinColorSliderGreen.over()) return true;
      if (effectMinColorSliderBlue.over()) return true;
      if (effectMaxColorSliderRed.over()) return true;
      if (effectMaxColorSliderGreen.over()) return true;
      if (effectMaxColorSliderBlue.over()) return true;
      break;
    case cOverlayMainMenu:
      if (reloadConfigFilesButton.over())
      {
        LoadConfigurationFiles();
      }

      if (loadContentFileButton.over())
      {
		//selectInput("Select AllPixMatrix content file(.allpix)", "fileSelectContentFile");  
        SelectedFilePath = "/configs/"+software.configFilePath+"/"+matrix.contentFileName;  //DEBUG FOR NOW - FILE DIALOG USAGE TO BE ADDED
        LoadUserContentFile(SelectedFilePath);	
		delay(500); //prevents some sort of endless errors if user clicks multiple times too fast
      }

      if (saveContentFileButton.over())
      {
        SelectedFilePath = "/configs/"+software.configFilePath+"/"+matrix.contentFileName; //DEBUG FOR NOW - FILE DIALOG USAGE TO BE ADDED
        SaveUserContentFile(SelectedFilePath);
      }
      break;
    } //end overlay ObjID switch
    return false;
  } //end mouse pressed
} //end overlayMenu class
