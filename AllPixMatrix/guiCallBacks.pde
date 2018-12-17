 //<>// //<>// //<>// //<>// //<>// //<>//
//======================================================================================================

void mainBlendModeFunc()
{
  MainBlendMode = mainBlendModeDD.getValue(); //DropDownPointer.getValue();
}

//======================================================================================================

void effectMaxColorSliderRFunc()
{
  contentLayerPtr.maxColor = color(SliderPointer.getUnsignedChar(), green(contentLayerPtr.maxColor), blue(contentLayerPtr.maxColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMaxColorSliderGFunc()
{
  contentLayerPtr.maxColor = color(red(contentLayerPtr.maxColor), SliderPointer.getUnsignedChar(), blue(contentLayerPtr.maxColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMaxColorSliderBFunc()
{
  contentLayerPtr.maxColor = color(red(contentLayerPtr.maxColor), green(contentLayerPtr.maxColor), SliderPointer.getUnsignedChar());
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMinColorSliderRFunc()
{
  contentLayerPtr.minColor = color(SliderPointer.getUnsignedChar(), green(contentLayerPtr.minColor), blue(contentLayerPtr.minColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMinColorSliderGFunc()
{
  contentLayerPtr.minColor = color(red(contentLayerPtr.minColor), SliderPointer.getUnsignedChar(), blue(contentLayerPtr.minColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMinColorSliderBFunc()
{
  contentLayerPtr.minColor = color(red(contentLayerPtr.minColor), green(contentLayerPtr.minColor), SliderPointer.getUnsignedChar());
  guiOverlayMenus[OverlayMenuID].initMenu();
}

//======================================================================================================

void effectMaxColorRFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.maxColor = color((int)numberInputFieldPtr.value, green(contentLayerPtr.maxColor), blue(contentLayerPtr.maxColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMaxColorGFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.maxColor = color(red(contentLayerPtr.maxColor), (int)numberInputFieldPtr.value, blue(contentLayerPtr.maxColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMaxColorBFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.maxColor = color(red(contentLayerPtr.maxColor), green(contentLayerPtr.maxColor), (int)numberInputFieldPtr.value);
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMinColorRFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.minColor = color((int)numberInputFieldPtr.value, green(contentLayerPtr.minColor), blue(contentLayerPtr.minColor));
  guiOverlayMenus[OverlayMenuID].initMenu();
}

void effectMinColorGFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.minColor = color(red(contentLayerPtr.minColor), (int)numberInputFieldPtr.value, blue(contentLayerPtr.minColor));
}

void effectMinColorBFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.minColor = color(red(contentLayerPtr.minColor), green(contentLayerPtr.minColor), (int)numberInputFieldPtr.value);
  guiOverlayMenus[OverlayMenuID].initMenu();
}

//======================================================================================================

void effectsTintColor()
{
  contentLayerPtr.tintColor = colorSquarePtr.selColor;
}

void effectContrastFunc()
{
  genericNumberInputField(); //common to all
  contentLayerPtr.effectContrast = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void layerBlendingModeFunc()
{
  println("layerBlendingModeFunc()");
  contentLayerPtr.blendMode = DropDownPointer.getValue();
}

//======================================================================================================

void layerSpeedAdjFunc()
{
genericNumberInputField(); //common to all
contentLayerPtr.setLayerFPS((int)numberInputFieldPtr.value);
}

//======================================================================================================

void layerOpacitySliderFunc()
{
    contentLayerPtr.layerOpacity = SliderPointer.getUnsignedChar();
}

//======================================================================================================

void colorSelectorSliderRed()
{
  guiColorSelectorMenu.red = menuColorSelSliderRed.value;
  guiColorSelectorMenu.updateColorGUIElements();
}

//======================================================================================================

void colorSelectorSliderGreen()
{
  guiColorSelectorMenu.green = menuColorSelSliderGreen.value;
  guiColorSelectorMenu.updateColorGUIElements();
}

//======================================================================================================

void colorSelectorSliderBlue()
{
  guiColorSelectorMenu.blue = menuColorSelSliderBlue.value;
  guiColorSelectorMenu.updateColorGUIElements();
}

//======================================================================================================

void colorSelectorSliderWhite()
{
  guiColorSelectorMenu.white = menuColorSelSliderWhite.value;
  guiColorSelectorMenu.updateColorGUIElements();
}

//======================================================================================================

void colorSelectorSliderAlpha()
{
  guiColorSelectorMenu.alpha = menuColorSelSliderAlpha.value;
  guiColorSelectorMenu.updateColorGUIElements();
}

//======================================================================================================

void colorSelectorValueRed()
{
  genericNumberInputField(); 
  guiColorSelectorMenu.red = (int)numberInputFieldPtr.value;
  menuColorSelSliderRed.setValue(guiColorSelectorMenu.red);
}

//======================================================================================================

void colorSelectorValueGreen()
{
  genericNumberInputField(); 
  guiColorSelectorMenu.green = (int)numberInputFieldPtr.value;
  menuColorSelSliderGreen.setValue(guiColorSelectorMenu.green);
}

//======================================================================================================

void colorSelectorValueBlue()
{
  genericNumberInputField(); 
  guiColorSelectorMenu.blue = (int)numberInputFieldPtr.value;
  menuColorSelSliderBlue.setValue(guiColorSelectorMenu.blue);
}

//======================================================================================================

void colorSelectorValueWhite()
{
  genericNumberInputField(); 
  guiColorSelectorMenu.white = (int)numberInputFieldPtr.value;
  menuColorSelSliderWhite.setValue(guiColorSelectorMenu.white);
}

//======================================================================================================

void colorSelectorValueAlpha()
{
  genericNumberInputField(); 
  guiColorSelectorMenu.alpha = (int)numberInputFieldPtr.value;
  menuColorSelSliderAlpha.setValue(guiColorSelectorMenu.alpha); //update slider
}

//======================================================================================================

void feedIntensityFuncA()
{
  FeedIntensityA = 1-((float)intensitySliderA.value / 100); //convert to float
}

//======================================================================================================

void feedIntensityFuncB()
{
  FeedIntensityB = 1-((float)intensitySliderB.value / 100); //convert to float
}

//======================================================================================================

void generatedMediaFPSFunc()
{
  genericNumberInputField(); 
  mediaContentTile[workingTileID].contentFPS = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void scaleOptionsDDFunc()
{
  mediaContentTile[workingTileID].scaleOption = imgScalingOptionsDD.getValue();
}

//======================================================================================================

void mediaCropWFunc()
{
	mediaMenuGUICropW.maxValue = (mediaContentTile[workingTileID].nativeWidth - mediaContentTile[workingTileID].offsetX);
	genericNumberInputField();
	mediaContentTile[workingTileID].cropWidth = int(mediaMenuGUICropW.value);
}

void mediaCropHFunc()
{
	mediaMenuGUICropH.maxValue = (mediaContentTile[workingTileID].nativeHeight - mediaContentTile[workingTileID].offsetY);
	genericNumberInputField();
	mediaContentTile[workingTileID].cropHeight = int(mediaMenuGUICropH.value);
}

void mediaOffsetXFieldFunc()
{
	contentOffsetX.maxValue = mediaContentTile[workingTileID].nativeWidth; //set max offset, which is image width
	genericNumberInputField();
	mediaContentTile[workingTileID].offsetX = int(contentOffsetX.value);

	//update companion field if required
	if((mediaContentTile[workingTileID].nativeWidth - mediaContentTile[workingTileID].offsetX) < mediaContentTile[workingTileID].cropWidth)
	{
	mediaContentTile[workingTileID].cropWidth = (mediaContentTile[workingTileID].nativeWidth - mediaContentTile[workingTileID].offsetX);
	mediaMenuGUICropW.setValue(mediaContentTile[workingTileID].cropWidth);
	}
}

void mediaOffsetYFieldFunc()
{
	contentOffsetY.maxValue = mediaContentTile[workingTileID].nativeHeight; //set max offset, which is image width
	genericNumberInputField();
	mediaContentTile[workingTileID].offsetY = int(contentOffsetY.value);

	//update companion field if required
	if((mediaContentTile[workingTileID].nativeHeight - mediaContentTile[workingTileID].offsetY) < mediaContentTile[workingTileID].cropHeight)
	{
	mediaContentTile[workingTileID].cropHeight = (mediaContentTile[workingTileID].nativeHeight - mediaContentTile[workingTileID].offsetY);
	mediaMenuGUICropH.setValue(mediaContentTile[workingTileID].cropHeight);
	}
}

//======================================================================================================

void generatedMediaDDFunc()
{
  println("generatedMediaDD() using ID#: "+workingTileID);

  //if currently a generated media content, dispose the object so it can be reused in the future
  DisposeGeneratedObjects();

  mediaContentTile[workingTileID].generatedType = generatedMediaDD.getValue();
  mediaContentTile[workingTileID].loadMediaSource(5); //5= ID for generated content
  guiOverlayMenus[OverlayMenuID].initMenu(); //this will intialize the locations of the GUI elements, since they will change
  mediaContentTile[workingTileID].updateMedia();
}

//======================================================================================================

void effectsOptionsDDFunc()
{
  println("effectsOptionsDDFunc()");
  contentLayerPtr.effectFilterIDNum = effectsOptionsDD.getValue();
  handleEffectsFilterElements(effectsOptionsDD.getValue());
}

//======================================================================================================

void genericDDCallBack()
{
  //do nothing
}

//======================================================================================================

void genericHandlerTextField()
{
  textFieldPtr.selected = false;
}

//======================================================================================================

void effectsFilterInputFieldFunc()
{
  genericNumberInputField();
  contentLayerPtr.effectFilterVariable = effectsFilterInputField.value;
}

//======================================================================================================

void genericNumberInputField()
{
  println("genericNumberInputField() with "+numberInputFieldPtr.selected);
  allowMousePressHold = true; //DEBUG - think I am keeping it

  if (numberInputFieldPtr.inputMethod == 3) //floats
  {
    switch(numberInputFieldPtr.selected)
    {
    case 0:
      break;
    case 1: //decrement
      if ((numberInputFieldPtr.value-0.1) > numberInputFieldPtr.minValue)   numberInputFieldPtr.value-=0.05;
      else numberInputFieldPtr.value = numberInputFieldPtr.minValue;
      break;
    case 2: //increment
      if ((numberInputFieldPtr.value+0.1) < numberInputFieldPtr.maxValue)   numberInputFieldPtr.value+=0.05;
      else numberInputFieldPtr.value = numberInputFieldPtr.maxValue;
      break; 
    case 3: //typed in selection
      numberInputFieldPtr.selected = 0; //clear selection

      numberInputFieldPtr.value = float(numberInputFieldPtr.label); //covert string to float
      if (numberInputFieldPtr.value < numberInputFieldPtr.minValue)  numberInputFieldPtr.value = numberInputFieldPtr.minValue;
      else if (numberInputFieldPtr.value > numberInputFieldPtr.maxValue)   numberInputFieldPtr.value = numberInputFieldPtr.maxValue;
      break;
    } //end switch
    numberInputFieldPtr.label = str(numberInputFieldPtr.value);   //not setValue() I guess
    return;
  } 
  else if (numberInputFieldPtr.inputMethod == 1) //integers
  {
    switch(numberInputFieldPtr.selected)
    {
    case 0:
      break;
    case 1: //decrement
      if (numberInputFieldPtr.value > numberInputFieldPtr.minValue)   numberInputFieldPtr.value--;
      break;
    case 2: //increment
      if (numberInputFieldPtr.value < numberInputFieldPtr.maxValue)   numberInputFieldPtr.value++;
      break; 
    case 3:
      numberInputFieldPtr.selected = 0; //clear selection

      numberInputFieldPtr.value = int(numberInputFieldPtr.label); //covert string to int
      if (numberInputFieldPtr.value < numberInputFieldPtr.minValue)  numberInputFieldPtr.value = numberInputFieldPtr.minValue;
      else if (numberInputFieldPtr.value > numberInputFieldPtr.maxValue)   numberInputFieldPtr.value = numberInputFieldPtr.maxValue;
      break;
    } //end switch
    numberInputFieldPtr.label = str(int(numberInputFieldPtr.value));
    //return
  }
} //end func()

//======================================================================================================================

void deselectTextField()
{
  if (TextFieldActive == true)
  {
    if (textFieldPtr.selected == true) 
    {
      textFieldPtr.selected = false; 
      textFieldPtr.label = GlobalLabelStore; //restore
    }
    TextFieldActive = false;
  }

  //---------------------------------------------------------

  if (NumberInputFieldActive == true)
  {
    if (numberInputFieldPtr.selected > 0) 
    {
      numberInputFieldPtr.selected = 0; 
      numberInputFieldPtr.label = GlobalLabelStore; //restore
    }
    NumberInputFieldActive = false;
  }
} //end mousePressedHandleTextFields


//======================================================================================================

void fileSelectDataFile(File selection)
{
  if (!validateFileDialogSelection(selection)) return;
  println("fileSelectDataFile()");
  createMediaContentObj("Data File "+workingTileID, cTypeIDDataFile, 0, SelectedFilePath); //create new object if adding
  guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
} //end func

//======================================================================================================

void fileSelectVideoFile(File selection)
{
  if (!validateFileDialogSelection(selection)) return;
  println("fileSelectVideoFile()");
  createMediaContentObj("Video "+workingTileID, cTypeIDVideo, 0, SelectedFilePath); //create new object if adding
  guiOverlayMenus[OverlayMenuID].initMenu(); //now that the type is selected, init the menu so elements display properly
} //end func

//======================================================================================================

void fileSelectImageFile(File selection)
{
  if (!validateFileDialogSelection(selection)) return;
  println("fileSelectImageFile()");
  createMediaContentObj("Image "+workingTileID, cTypeIDImage, 0, SelectedFilePath); //create new object if adding
  guiOverlayMenus[OverlayMenuID].initMenu(); //now that the type is selected, init the menu so elements display properly
} //end func

//======================================================================================================

//Doesn't work casues errors, think it is because selectInput() is a thread
void fileSelectContentFile(File selection)
{
  if (!validateFileDialogSelection(selection)) return;
  println("fileSelectContentFile()"); 
  LoadUserContentFile(SelectedFilePath);	//SelectedFilePath was updated by validateFileDialogSelection()
}

//======================================================================================================

void menuMediaTileMenuButtonsFunc(int passedID)
{
  println("menuMediaTileMenuButtonsFunc() with "+passedID);
	
  switch(passedID) //this is the button object id number, not the typeID
  {
  case 0: //video
    selectInput("Select MOV, AVI, or similar:", "fileSelectVideoFile");  
    break;

  case 1: //GIF
    println("GIF Not yet enabled");
    break;

  case 2: //Image
    selectInput("Select JPG, GIF, PNG, TIFF, or similar:", "fileSelectImageFile");  
    break;

  case 3: //Syphon/Spout
    //don't really want to create the spout receiver before selection of sender, but no other option since can't detect a selectSender() cancel
    createMediaContentObj("Spout "+workingTileID, cTypeIDSpout, 0, ""); //create new object if adding
	guiOverlayMenus[OverlayMenuID].initMenu();
    break;  

  case 4: //Generated
    createMediaContentObj("Generated "+workingTileID, cTypeIDGenerated, 0, ""); //create new object if adding
    guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
    break;

  case 5: //Data File
    selectInput("Select Recorded File, TXT", "fileSelectDataFile");  
    break;

  case 6: //External Data
    createMediaContentObj("ExternalData "+workingTileID, cTypeIDExtData, 0, ""); //create new object if adding
    guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
    break;
  } //end switch


  for (int i = 0; i != menuMediaTileMenuButtons.length; i++)
  {
    menuMediaTileMenuButtons[i].selected = false;
  } //end for()

  //in case it was a generated that was changed, this gets rid of the object and opens the slot
  DisposeGeneratedObjects();
} //end func

//======================================================================================================

void mainIntensityFunc()
{
  MasterIntensity = (float)mainIntensityFader.value / 100; //convert to float
}

//======================================================================================================

void mediaContentSliderFunc()
{
  if(DefinedMediaTiles <= cSoftwareMaxViewedTiles-2)  mediaContentScrollBar.max = 0;
  else mediaContentScrollBar.max = DefinedMediaTiles-cSoftwareMaxViewedTiles+1;
  
  if(mediaContentScrollBar.max >= (cSoftwareMaxMediaTiles-cSoftwareMaxViewedTiles)) mediaContentScrollBar.max = cSoftwareMaxMediaTiles-cSoftwareMaxViewedTiles-1; //limit to max tiles 
  //println("mediaContentSliderFunc() "+mediaContentScrollBar.max);
}

//======================================================================================================

void mainCrossFaderFunc()
{
  // println("mainCrossFaderFunc()");
  CrossFaderValue = (float)mainCrossFader.value / 100; //convert to float
}

//======================================================================================================

void crossHardCutAcallBack()
{
  CrossFaderValue = 0;
  mainCrossFader.value = int(mainCrossFader.max*CrossFaderValue); //update GUI element
}

//======================================================================================================

void crossHardCutBcallBack()
{
  CrossFaderValue = 1;
  mainCrossFader.value = int(mainCrossFader.max*CrossFaderValue); //update GUI element
}

//======================================================================================================
//======================================================================================================
