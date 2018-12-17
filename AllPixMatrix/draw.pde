void draw() 
{
	
  // --------------------------------------------------- Handle GUI Refresh ------------------------------------------------------------------

  guiRefreshMs++; //increment counter

  if (guiRefreshMs > software.frameRateMs)
  {
    guiRefreshMs = 0; //if timers match, refresh the GUI and clear the counter

    //update in case of slider or other gui features
    mouseXS = round((float)mouseX / SF); //update scaled mouseX & Y, allows window resizing to work
    mouseYS = round((float)mouseY / SF);

    // --------------------------------------------------- Start GUI Drawing ------------------------------------------------------------------

    scale(SF, SF); //scales the drawing of window and GUI elements to fit

    background(gui.windowBackground);
    noStroke();
    fill(50); //black
    rect(0, 0, 450, 260); //left preview background
    rect(455, 0, 450, 260); //center preview background
    rect(910, 0, 450, 260); //right preview background

    fill(gui.layerBackground);
    stroke(gui.textColor);
    strokeWeight(2);
    rect(0, 650, 1366, 90); //content box
    noStroke();

    fill(gui.textColor);
    textSize(18);

    text("Output Rate(mS): "+(millis()-holdMillis), 345, 580);  
    text("GUI Rate(FPS): "+cGUIRefreshFPS, 345, 600);  
    text("Loop Rate(FPS): "+frameRate, 345, 620);
    text("Status: "+StatusMessage(), 345, 640);

    text("Main Intensity: "+(100*MasterIntensity)+"%", 540, 425);
    text("Feed A Intensity: "+(100*FeedIntensityA)+"%", 540, 445);
    text("Feed B Intensity: "+(100*FeedIntensityB)+"%", 540, 465);

    // --------------------------------------------------- Update any GUI elements that need it ------------------------------------------------------------------

    if (GlobalDragging == true) SliderPointer.runCallBack();

    // --------------------------------------------------- Display GUI Elements ------------------------------------------------------------------

    for (int i=0; i != contentLayerA.length; i++) contentLayerA[i].display();
    for (int i=0; i != contentLayerB.length; i++) contentLayerB[i].display();

    if (SelectFeedID == 1) feedLayersTileButtonsA[SelectLayerID].displayOutline();       //displays box to indicate selected layer
    else if (SelectFeedID == 2) feedLayersTileButtonsB[SelectLayerID].displayOutline();  //displays box to indicate selected layer

    displayMediaTiles();

    mediaContentScrollBar.display();

    mainCrossFader.display();
    mainIntensityFader.display();

    intensitySliderA.display();
    intensitySliderB.display();

    mainBlendModeDD.display();
    crossHardCutA.display();
    crossHardCutB.display();
    crossAutoA.display();
    crossAutoB.display();

    feedPlayPauseA.display();
    feedPlayPauseB.display();

    openMainMenuButton.display();
    recordToFileButton.display();

    // --------------------------------------------------- Mouse Press and Hold Function ------------------------------------------------------------------

    //still can catch two elements if the mouse is dragged over multiple elements - whatever
    if (mousePressed == true && allowMousePressHold == true && GlobalDDOpen == false)
    {
      if ((pressHoldTimer+pressHoldRollingTimer) < millis()) 
      {
        if (pressHoldRollingTimer > cMousePressHoldMinTime) pressHoldRollingTimer -= cMousePressHoldAdjustmentTime; //adjust rolling timer to increase the speed the longer its held

        pressHoldTimer = millis();
        if (mousePressLeftHandler() == false) allowMousePressHold = false; //if mouse is no longer over the element, disable press hold function - but only called after timer rollover, so it can select multiple elements
      }
    } else if (mousePressed == false) allowMousePressHold = false;

    // --------------------------------------------------- Display Image Previews ---------------------------------------------------


	
    // -------------------------------------- Display Pixelated GUI Previews ----------------------------------------------------------------

    //if(transmitPixelBuffer == null) transmitPixelBuffer = MixedContentGBuf.get(); //errors without this

    try {
      //default style
      stroke(0); //black outline - could also do white(255)
      strokeWeight(1);

      //output preview
      for (int i = 0; i < TotalPixels; i++)//=pixSize)
      {
        color pix = transmitPixelBuffer.get(PatchCoordX[i], PatchCoordY[i]);
        fill(pix);
        rect(465+displayOffsetX+(PatchCoordX[i]*displayPixSize), 10+displayOffsetY+(PatchCoordY[i]*displayPixSize), displayPixSize, displayPixSize);
      }
    }
    catch(Exception e) {
    }

    feedPreviewImgA = LayerContentGBufA.get(); //quicker to convert the PGraphics to PImage before running .get() it seems,
    feedPreviewImgB = LayerContentGBufB.get(); //distinctly noticable when fading back and fourth

    //Feed A preview
    for (int i = 0; i < feedPreviewImgA.width; i++)//=pixSize)
    {
      for (int j = 0; j < feedPreviewImgA.height; j++)//=pixSize)
      {
        color pix = feedPreviewImgA.get(i, j);
        fill(pix);
        rect(10+displayOffsetX+(i*displayPixSize), 10+displayOffsetY+(j*displayPixSize), displayPixSize, displayPixSize);
      }
    }

    //Feed B preview
    for (int i = 0; i < feedPreviewImgB.width; i++)//=pixSize)
    {
      for (int j = 0; j < feedPreviewImgB.height; j++)//=pixSize)
      {
        color pix = feedPreviewImgB.get(i, j);
        fill(pix);
        rect(920+displayOffsetX+(i*displayPixSize), 10+displayOffsetY+(j*displayPixSize), displayPixSize, displayPixSize);
      }
    }

    //------------------------------------------------ Display Overlay Menu If Open ------------------------------------------------------
    
    //Do this last so it overlays everything
    if (OverlayMenuID > 0) guiOverlayMenus[OverlayMenuID].display();

    //------------------------------------------------ Display Color Selector Menu If Open ------------------------------------------------------

    if (guiColorSelectorMenu.menuOpen == true) guiColorSelectorMenu.display();

    //---------------------------------------------- Dropdown GUI Element Display --------------------------------------------------------

    if (GlobalDDOpen == true)   DropDownPointer.display(); //always do last or other GUI elements could overlay the menu

    //--------------------------------------------------- HANDLE OUTPUT ---------------------------------------------------

    /*
    //Disable for now, but really want this to work - if transmit a syphon, and the software that created it receives it, errors occur.
     spoutSenderA.sendTexture(LayerContentGBufA);
     spoutSenderB.sendTexture(LayerContentGBufB);
     spoutSenderMixed.sendTexture(MixedContentGBuf);
     */

    //================================== START SCREEN SIZE =======================================================================    

    //monitors if the user altered the screen size by dragging the window larger, and handles if resized
    if (PrevWidth != width || PrevHeight != height)
    {
      println("Window Resized to: "+width+" : "+height+" from "+PrevWidth+" : "+PrevHeight);    
      //not yet finished, works but doesn't resize itself to stay within aspect ratio
      PrevHeight = height;  //used to watch if the grid window's size is changed
      PrevWidth = width;  
      //SaveSoftwareConfigFile();  //save window size - not yet
      SF = (float)width / cDefaultGUIWidth; //set new scale factor
    }//end if()
  } //end guiRefreshMs if()

  // --------------------------------------------------- End GUI Refresh ------------------------------------------------------------------

  //Content must be updated from draw, most cases it can draw to PGraphics without error, but not all the time. Depends on renderer, P3D for sure 
  //	won't work if drawn from outside draw() otherwise this would be a background thread. There may be a method to thread updateMedia() but not 
  //	that I know of as of now. The remainder of draw() is what requires the framerate to be 1000 for 1mS timing. Each media tile has it's own
  //	framerate that it needs to update at. This is required so actual play back speeds of the media does not vary between software gui

  //The following updateMedia() is the timing source for the generated media
  
  //------------------------------------------------ Feed A Content Update ----------------------------------------------------------------

  try {
      if ((millis()-mediaContentTile[contentLayerA[0].mediaIDNum].holdMillis) > contentLayerA[0].getMsUpdateVal())
      {
        if (mediaContentTile[contentLayerA[0].mediaIDNum].playMode == 0)
        {
          mediaContentTile[contentLayerA[0].mediaIDNum].holdMillis = millis();
          mediaContentTile[contentLayerA[0].mediaIDNum].updateMedia();
          mixFeeds = true;
        }
      }
      if ((millis()-mediaContentTile[contentLayerA[1].mediaIDNum].holdMillis) > contentLayerA[1].getMsUpdateVal())
      {
        mediaContentTile[contentLayerA[1].mediaIDNum].holdMillis = millis();
        mediaContentTile[contentLayerA[1].mediaIDNum].updateMedia();
        mixFeeds = true;
      }
      if ((millis()-mediaContentTile[contentLayerA[2].mediaIDNum].holdMillis) > contentLayerA[2].getMsUpdateVal())
      {
        mediaContentTile[contentLayerA[2].mediaIDNum].holdMillis = millis();
        mediaContentTile[contentLayerA[2].mediaIDNum].updateMedia();
        mixFeeds = true;
      }
  }
  catch(Exception e) { 
    println("FeedA had an error");
  } 

  //------------------------------------------------ Feed B Content Update ----------------------------------------------------------------

  try
  {
      if ((millis()-mediaContentTile[contentLayerB[0].mediaIDNum].holdMillis) > contentLayerB[0].getMsUpdateVal())
      {
        mediaContentTile[contentLayerB[0].mediaIDNum].holdMillis = millis();
        mediaContentTile[contentLayerB[0].mediaIDNum].updateMedia();
        mixFeeds = true;
      }
      if ((millis()-mediaContentTile[contentLayerB[1].mediaIDNum].holdMillis) > contentLayerB[1].getMsUpdateVal())
      {
        mediaContentTile[contentLayerB[1].mediaIDNum].holdMillis = millis();
        mediaContentTile[contentLayerB[1].mediaIDNum].updateMedia();
        mixFeeds = true;
      }
      if ((millis()-mediaContentTile[contentLayerB[2].mediaIDNum].holdMillis) > contentLayerB[2].getMsUpdateVal())
      {
        mediaContentTile[contentLayerB[2].mediaIDNum].holdMillis = millis();
        mediaContentTile[contentLayerB[2].mediaIDNum].updateMedia();
        mixFeeds = true;
      }
  }
  catch(Exception e) { 
    println("FeedB had an error");
  } 

 //if (FeedPlayModeA == 1 && FeedPlayModeB == 1) mixFeeds = true; //if both feeds are paused, still need to mix them for the output

  //------------------------------------------------ Feeds Updated, Now Mix Them ----------------------------------------------------------------

  //If any media content has changed and the output FPS timer has elapsed, indicate to the transmission thread to send a packet
  if (mixFeeds == true)
  {
    if ((millis()-holdMillis) > matrix.outputFPS)
    {
      //println("mixed "+(millis()-holdMillis));
      //holdMillis = millis();

      mixFeeds = false;
      //now mix the layers
      MainMixFunction(); //mix FeedA and FeedB
      transmitPixelBuffer = MixedContentGBuf.get();
      //holdMillis = millis(); //update here
      PacketReadyForTransmit = true; //indicates to transmission thread that a new frame is ready
    }
  } //end mixFeeds if()
} //end draw()

//===============================================================================================================================

void MainMixFunction()
{
  //only call from draw() otherwise creates graphical glitches
  //This function uses a PImage or PGraphics buffer for both Feeds(A&B), the mixed buffer. A scratch buffer is used to copy the
  //	the mediaTile's graphic buffer, the media images are layered an to create the mixed layer image.
  //	The mixed layer image

  
  // --------------------------------------------------- Mix Side A ------------------------------------------------------------------

  LayerContentGBufA.beginDraw();
  LayerContentGBufA.background(0, 0, 0, 0); //clears the layer graphic buffer with transparency(required for tint())
  LayerContentGBufA.endDraw();

  //----------------------------------------- Feed A, Bottom Layer ----------------------------------------------------

  contentLayerA[2].updateLayerFrame();

  scratchGBuf.beginDraw();
  scratchGBuf.background(0, 0, 0, 0); //required... for now anyway, needed for tint to work
  scratchGBuf.tint(255, contentLayerA[2].layerOpacity);  //Opacity 3rd Layery
  MixingCommonScaleFunc(mediaContentTile[contentLayerA[2].mediaIDNum].scaleOption);
  MixingCommonApplyEffects(contentLayerA[2].effectFilterIDNum, contentLayerA[2].effectFilterVariable);
  scratchGBuf.endDraw();

  LayerContentGBufA.beginDraw();
  LayerContentGBufA.blendMode(cBlendID[contentLayerA[2].blendMode]);
  MixingCommonApplyColorEffects(contentLayerA[2]);
  LayerContentGBufA.image(scratchGBuf, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
  LayerContentGBufA.endDraw();

  //--------------------------------------------- Feed A, Middle Layer ------------------------------------------------

  contentLayerA[1].updateLayerFrame();
  
  scratchGBuf.beginDraw();
  scratchGBuf.background(0, 0, 0, 0); //required... for now anyway, needed for tint to work
  scratchGBuf.tint(255, contentLayerA[1].layerOpacity);  //Opacity 2nd Layer
  MixingCommonScaleFunc(mediaContentTile[contentLayerA[1].mediaIDNum].scaleOption);
  MixingCommonApplyEffects(contentLayerA[1].effectFilterIDNum, contentLayerA[1].effectFilterVariable);
  scratchGBuf.endDraw();

  LayerContentGBufA.beginDraw();
  LayerContentGBufA.blendMode(cBlendID[contentLayerA[1].blendMode]);
  MixingCommonApplyColorEffects(contentLayerA[1]);
  LayerContentGBufA.image(scratchGBuf, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
  LayerContentGBufA.endDraw();

  //-------------------------------------------- Feed A, Top Layer -------------------------------------------------

  contentLayerA[0].updateLayerFrame();
  
  scratchGBuf.beginDraw();
  scratchGBuf.background(0, 0, 0, 0); //required... for now anyway, needed for tint to work
  scratchGBuf.tint(255, contentLayerA[0].layerOpacity);  //Opacity 1st Layer
  MixingCommonScaleFunc(mediaContentTile[contentLayerA[0].mediaIDNum].scaleOption);
  MixingCommonApplyEffects(contentLayerA[0].effectFilterIDNum, contentLayerA[0].effectFilterVariable);
  scratchGBuf.endDraw();

  LayerContentGBufA.beginDraw();
  LayerContentGBufA.blendMode(cBlendID[contentLayerA[0].blendMode]);
  MixingCommonApplyColorEffects(contentLayerA[0]);
  LayerContentGBufA.image(scratchGBuf, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
  LayerContentGBufA.endDraw();

  // --------------------------------------------------- Mix Side B ---------------------------------------------------

  LayerContentGBufB.beginDraw();
  LayerContentGBufB.background(0, 0, 0, 0); //clears the layer graphic buffer with transparency(required for tint())
  LayerContentGBufB.endDraw();

  //----------------------------------------------- Feed B, Top Layer ----------------------------------------------

  contentLayerB[2].updateLayerFrame();
  
  scratchGBuf.beginDraw();
  scratchGBuf.background(0, 0, 0, 0); //required... for now anyway, needed for tint to work
  scratchGBuf.tint(255, contentLayerB[2].layerOpacity);  //Intensity 3rd Layer
  MixingCommonScaleFunc(mediaContentTile[contentLayerB[2].mediaIDNum].scaleOption);
  MixingCommonApplyEffects(contentLayerB[2].effectFilterIDNum, contentLayerB[2].effectFilterVariable);
  scratchGBuf.endDraw();

  LayerContentGBufB.beginDraw();
  LayerContentGBufB.blendMode(cBlendID[contentLayerB[2].blendMode]);
  MixingCommonApplyColorEffects(contentLayerB[2]);
  LayerContentGBufB.image(scratchGBuf, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
  LayerContentGBufB.endDraw();

  //-------------------------------------------- Feed B, Middle Layer -------------------------------------------------

  contentLayerB[1].updateLayerFrame();
  
  scratchGBuf.beginDraw();
  scratchGBuf.background(0, 0, 0, 0); //required... for now anyway, needed for tint to work
  scratchGBuf.tint(255, contentLayerB[1].layerOpacity);  //Intensity 2nd Layer
  MixingCommonScaleFunc(mediaContentTile[contentLayerB[1].mediaIDNum].scaleOption);
  MixingCommonApplyEffects(contentLayerB[1].effectFilterIDNum, contentLayerB[1].effectFilterVariable);
  scratchGBuf.endDraw();


  LayerContentGBufB.beginDraw();
  LayerContentGBufB.blendMode(cBlendID[contentLayerB[1].blendMode]);
  MixingCommonApplyColorEffects(contentLayerB[1]);
  LayerContentGBufB.image(scratchGBuf, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
  LayerContentGBufB.endDraw();

  //----------------------------------------- Feed B, Bottom Layer ----------------------------------------------------

  contentLayerB[0].updateLayerFrame();
  
  scratchGBuf.beginDraw();
  scratchGBuf.background(0, 0, 0, 0); //required... for now anyway, needed for tint to work
  scratchGBuf.tint(255, contentLayerB[0].layerOpacity);  //Intensity 2nd Layer
  MixingCommonScaleFunc(mediaContentTile[contentLayerB[0].mediaIDNum].scaleOption);
  MixingCommonApplyEffects(contentLayerB[0].effectFilterIDNum, contentLayerB[0].effectFilterVariable);
  scratchGBuf.endDraw();

  LayerContentGBufB.beginDraw();
  LayerContentGBufB.blendMode(cBlendID[contentLayerB[0].blendMode]);
  MixingCommonApplyColorEffects(contentLayerB[0]);
  LayerContentGBufB.image(scratchGBuf, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
  LayerContentGBufB.endDraw();

  // --------------------------------------------------- Final Mix ---------------------------------------------------

  MixedContentGBuf.beginDraw();
  MixedContentGBuf.background(0, 0, 0, 0); //clear graphics buffer
  MixedContentGBuf.noTint();
  MixedContentGBuf.tint(255, 255*(1-CrossFaderValue));
  MixedContentGBuf.image(GraphicsBufferOpacity(FeedIntensityA, LayerContentGBufA), 0, 0);
  MixedContentGBuf.blendMode(cBlendID[MainBlendMode]);
  MixedContentGBuf.tint(255, (255*CrossFaderValue));
  MixedContentGBuf.image(GraphicsBufferOpacity(FeedIntensityB, LayerContentGBufB), 0, 0);

  MixedContentGBuf.endDraw();
} //end func

//===============================================================================================================================

//scales the image according to the set value
void MixingCommonScaleFunc(int passedIDNum)
{
  switch(passedIDNum)
  {
  case 0:
    scratchGBuf.image(scratchImg, 0, 0); //display content image - no scaling or anything
    break;
  case 1: //scale
    scratchGBuf.image(scratchImg, 0, 0, scratchGBuf.width, scratchGBuf.height); //display content image
    break;  
  case 2: //scale W
    scratchGBuf.image(scratchImg, 0, 0, scratchGBuf.width, ((float)scratchGBuf.width / scratchImg.width)*scratchImg.height); //display content image
    break;
  case 3: //scale H
    scratchGBuf.image(scratchImg, 0, 0, ((float)scratchGBuf.height / scratchImg.height)*scratchImg.width, scratchGBuf.height); //display content image
    break;
  }
}//end func

//===============================================================================================================================

//Applies the color max and color min effects, along with contrast
void MixingCommonApplyColorEffects(guiContentLayer passedObj)
{
  color pixColor;
  int myRed, myGreen, myBlue;
  int minR, minG, minB;
  int maxR, maxG, maxB;

  minR = (int)red(passedObj.minColor);
  minG = (int)green(passedObj.minColor);
  minB = (int)blue(passedObj.minColor);
  maxR = (int)red(passedObj.maxColor);
  maxG = (int)green(passedObj.maxColor);
  maxB = (int)blue(passedObj.maxColor);

  if (minR < passedObj.effectContrast) minR = passedObj.effectContrast;
  if (minG < passedObj.effectContrast) minG = passedObj.effectContrast;
  if (minB < passedObj.effectContrast) minB = passedObj.effectContrast;

  scratchGBuf.loadPixels();
  for (int i = 0; i != scratchGBuf.pixels.length; i++) //decay/ fade out entire pixel[] array
  {
    pixColor = scratchGBuf.pixels[i];

    myRed = pixColor >> 16 & 0xFF; //convert colors to 8-bit
    if (myRed < minR) myRed = 0;
    else if (myRed > maxR) myRed = maxR;

    myGreen = pixColor >> 8 & 0xFF;
    if (myGreen < minG) myGreen = 0;
    else if (myGreen > maxG) myGreen = maxG;

    myBlue = pixColor & 0xFF; 
    if (myBlue < minB) myBlue = 0;
    else if (myBlue > maxB) myBlue = maxB;

    scratchGBuf.pixels[i] = color(myRed, myGreen, myBlue, alpha(pixColor));
  }
  scratchGBuf.updatePixels();
  
  //overlay color tint
  if(passedObj.layerOpacity > 0 && alpha(passedObj.tintColor) > 0) //don't bother running if either opacity/alpha is already 0
  {
  scratchGBuf.beginDraw();
  //scale the tint color alpha channel with layerOpacity
  scratchGBuf.fill(red(passedObj.tintColor),green(passedObj.tintColor),blue(passedObj.tintColor),((float)passedObj.layerOpacity/255)*alpha(passedObj.tintColor));
  //now draw a rect with proper opacity over the buffer
  scratchGBuf.noStroke();
  scratchGBuf.rect(0,0,matrix.width,matrix.height);  
  scratchGBuf.endDraw();
  }
}

//===============================================================================================================================

void MixingCommonApplyEffects(int passedIDNum, float passedParameter1)//.effectFilterIDNum
{
  try {
    //APPLY EFFECTS BEFORE AND AFTER... Filter() after others before...
    if (cFilterIDStr[passedIDNum] == POSTERIZE || cFilterIDStr[passedIDNum] == THRESHOLD || cFilterIDStr[passedIDNum] == BLUR ) 
      scratchGBuf.filter(cFilterIDStr[passedIDNum], passedParameter1);
    else scratchGBuf.filter(cFilterIDStr[passedIDNum]);
  }
  catch(Exception e) {
  }
}//end func

//===============================================================================================================================

//returns a PImage with opacity applied, tint() wasn't going to work for this. Also did not want to alter the original buffers or the preview would be wrong
PImage GraphicsBufferOpacity(float passedValue, PGraphics buf)
{
  // println("DecayBuffer() with "+passedValue);

  //multi use function for decay/trail effect
  color myColor;
  int myRed, myGreen, myBlue;
  float alpha;

  PImage localBuf = buf.get();

  if (passedValue == 1) return buf.get(); //leave if no decay is too be applied

  localBuf.loadPixels();

  for (int i = 0; i != localBuf.pixels.length; i++) //decay/ fade out entire pixel[] array
  {
    myColor = localBuf.pixels[i];
    alpha = alpha(myColor);

    myRed = myColor >> 16 & 0xFF; //convert colors to 8-bit
    myGreen = myColor >> 8 & 0xFF;
    myBlue = myColor & 0xFF; 

    localBuf.pixels[i] = color(round(myRed*passedValue), round(myGreen*passedValue), round(myBlue*passedValue), alpha);
  }
  localBuf.updatePixels();
  return localBuf.get();
}

//===============================================================================================================================
