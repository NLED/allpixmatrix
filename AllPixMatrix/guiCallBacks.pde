 //<>// //<>// //<>// //<>//
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

void generatedSourceContentFPSFunc()
{
  genericNumberInputField(); 
  sourceConentTile[workingTileID].contentFPS = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void scaleOptionsDDFunc()
{
  sourceConentTile[workingTileID].scaleOption = imgScalingOptionsDD.getValue();
}

//======================================================================================================

void contentCropWFunc()
{
  genericNumberInputField();
  sourceConentTile[workingTileID].cropWidth = int(contentGUICropW.value);
}

void contentCropHFunc()
{
  genericNumberInputField();
  sourceConentTile[workingTileID].cropHeight = int(contentGUICropH.value);
}

void contentOffsetXFieldFunc()
{
  genericNumberInputField();
  sourceConentTile[workingTileID].offsetX = int(contentOffsetX.value);
}

void contentOffsetYFieldFunc()
{
  genericNumberInputField();
  sourceConentTile[workingTileID].offsetY = int(contentOffsetY.value);
}

//======================================================================================================

void generatedSourceContentDDFunc()
{
  println("generatedSourceContentDDFunc() using ID#: "+workingTileID);

  //if currently a generated source content, dispose the object so it can be reused in the future
  DisposeGeneratedObjects();

  sourceConentTile[workingTileID].generatedType = generatedSourceContentDD.getValue();
  sourceConentTile[workingTileID].loadSourceContent(5); //5= ID for generated content
  guiOverlayMenus[OverlayMenuID].initMenu(); //this will intialize the locations of the GUI elements, since they will change
  sourceConentTile[workingTileID].updateContent();
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
  println("fileSelectDataile()");
  createSourceContentTile("Data File "+workingTileID, cTypeIDDataFile, 0, SelectedFilePath); //create new object if adding
  guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
} //end func

//======================================================================================================

void fileSelectVideoFile(File selection)
{
  if (!validateFileDialogSelection(selection)) return;
  println("fileSelectVideoFile()");
  createSourceContentTile("Video "+workingTileID, cTypeIDVideo, 0, SelectedFilePath); //create new object if adding
  guiOverlayMenus[OverlayMenuID].initMenu(); //now that the type is selected, init the menu so elements display properly
} //end func

//======================================================================================================

void fileSelectImageFile(File selection)
{
  if (!validateFileDialogSelection(selection)) return;
  println("fileSelectImageFile()");
  createSourceContentTile("Image "+workingTileID, cTypeIDImage, 0, SelectedFilePath); //create new object if adding
  guiOverlayMenus[OverlayMenuID].initMenu(); //now that the type is selected, init the menu so elements display properly
} //end func

//======================================================================================================

void menuSourceConentButtonsFunc(int passedID)
{
  switch(passedID) //this is the button object id number, not the typeID
  {
  case 0: //video
    // FileBrowserAction = 1; //set callback ID to load video file
    selectInput("Select MOV, AVI, or similar:", "fileSelectVideoFile");  
    break;

  case 1: //GIF
    println("GIF Not yet enabled");
    break;

  case 2: //Image
    //FileBrowserAction = 2; //set callback ID to load image
    selectInput("Select JPG, GIF, PNG, TIFF, or similar:", "fileSelectImageFile");  
    break;

  case 3: //Syphon/Spout
    //don't really want to create the spout receiver before selection of sender, but no other option since can't detect a selectSender() cancel
    createSourceContentTile("Spout "+workingTileID, cTypeIDSpout, 0, ""); //create new object if adding
    break;  

  case 4: //Generated
    createSourceContentTile("Generated "+workingTileID, cTypeIDGenerated, 0, ""); //create new object if adding
    guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
    break;

  case 5: //Data File
  //  createSourceContentTile("Data File "+workingTileID, cTypeIDDataFile, 0, ""); //create new object if adding
  //  guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
    selectInput("Select Recorded File, TXT", "fileSelectDataFile");  
    break;

  case 6: //External Data
    createSourceContentTile("ExternalData "+workingTileID, cTypeIDExtData, 0, ""); //create new object if adding
    guiOverlayMenus[OverlayMenuID].initMenu(); //the GUI elements for the generated content are initialized here, so just run it
    break;
  } //end switch


  for (int i = 0; i != menuSourceConentButtons.length; i++)
  {
    menuSourceConentButtons[i].selected = false;
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

void sourceContentSliderFunc()
{
  //  println("sourceContentSliderFunc()");
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
