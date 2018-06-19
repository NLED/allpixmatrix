
//======================================================================================================

void createSourceContentTile(String passedStr, int passedTypeID, int passedGenType, String passedFilePath)
{
  println("createSourceContentTile() "+workingTileID+"   "+DefinedContentSources);

  SelectedFilePath = passedFilePath; //required for loadSourceContent();

  println("starting with "+SelectedFilePath); 
  //if (matrix.footageFilePathMethod == false) 
  SelectedFilePath = SelectedFilePath.replace(sketchPath(""), ""); //create relative path
  //else absolute
  println("Ending with "+SelectedFilePath);

  sourceConentTile[workingTileID] = new SourceContentTile(passedStr, workingTileID);
  sourceConentTile[workingTileID].generatedType = passedGenType; //must be set before loadSourceContent()
  sourceConentTile[workingTileID].loadSourceContent(passedTypeID); //loads and intializes the content

  if (workingTileID > DefinedContentSources) DefinedContentSources++; //keeps global count
}

//======================================================================================================

float scaleImageRatio(int image_width, int image_height, int reference_width, int reference_height)
{
  float ratio = max((float)image_width / reference_width, (float)image_height / reference_height);
  return ratio;
}

int scaleImageW(int image_width, int image_height, int reference_width, int reference_height)
{
  float ratio = max((float)image_width / reference_width, (float)image_height / reference_height);
  //  println("W: "+ratio+"   "+int((float)image_width / ratio));
  return int((float)image_width / ratio);
}

int scaleImageH(int image_width, int image_height, int reference_width, int reference_height)
{
  float ratio = max((float)image_width / reference_width, (float)image_height / reference_height);
  //  println("H: "+ratio+"   "+int((float)image_height / ratio));
  return int((float)image_height / ratio);
}


//======================================================================================================

String StatusMessage()
{
  String tempStr = "You are connected to COM "+serialPort;

  return tempStr;
}

//======================================================================================================

//Since the object is not yet created this will see if it is available or direct it to the NULL contentTile until loadSource is ran
int getSourceContentTileTypeID()
{
  int temp = 0;

  try {
    temp = sourceConentTile[workingTileID].typeID;
  }
  catch(Exception e)
  {
    temp = 0;
  }
  return temp;
}

//======================================================================================================

void handleEffectsFilterElements(int passedVal)
{
  println("handleEffectsFilterElements() with "+passedVal+"   ");

  //sets the status and range of effectsFilterInputField based on effectFilterIDNum

  effectsFilterInputField.status = 0;//0=show, 1=grey out, 2=hide

  if (cFilterIDStr[passedVal] == THRESHOLD)
  {
    effectsFilterInputField.status = 0;//0=show, 1=grey out, 2=hide
    effectsFilterInputField.inputMethod = 3; //floats
    effectsFilterInputField.maxValue = 1;
    effectsFilterInputField.minValue = 0;
    effectsFilterInputField.value = 0.5;
    effectsFilterInputField.label = ""+effectsFilterInputField.value;
  } else if (cFilterIDStr[passedVal] == POSTERIZE)
  {
    effectsFilterInputField.status = 0;//0=show, 1=grey out, 2=hide
    effectsFilterInputField.inputMethod = 1; //integers
    effectsFilterInputField.maxValue = 255;
    effectsFilterInputField.minValue = 2;
    effectsFilterInputField.value = 2;
    effectsFilterInputField.label = ""+int(effectsFilterInputField.value);
  } else if (cFilterIDStr[passedVal] == BLUR)
  {
    effectsFilterInputField.status = 0;//0=show, 1=grey out, 2=hide
    effectsFilterInputField.inputMethod = 1; //integers
    effectsFilterInputField.maxValue = 24;
    effectsFilterInputField.minValue = 1;
    effectsFilterInputField.value = 1;
    effectsFilterInputField.label = ""+int(effectsFilterInputField.value);
  } else effectsFilterInputField.status = 1;//0=show, 1=grey out, 2=hide
} //end func

//======================================================================================================

void FillContentLayer(int passedVal)
{
  contentLayerPtr.loadContentToLayer(passedVal);
  SelectFeedID = 0; //clear as it indicates function
} //end func

//======================================================================================================

int scanSpoutReceivers()
{
  int IDScanner = 0;
  //scans through the syphon/spout receivers, and finds the next undefined one.
  try {
    for (int i = 0; i != spoutReciever.length; i++) 
    {
      img = spoutReciever[i].receivePixels(img); //try to read the spout buffer, if not there, object not defined
      IDScanner++; //increment counter
    } //end for()
  }
  catch(Exception e)
  {
    //found an undefined spout object
    println("Next Available Spout ID: "+IDScanner);
  }
  return IDScanner;
}

void createSpout(int passedID)
{
  if (passedID >= cSoftwareMaxSpout) 
  {
    println("Max Syphon/Spout objects reached"); 
    return;
  }
  println("createSpout() with "+passedID);
  spoutReciever[passedID] = new Spout(this);
}

//======================================================================================================

//Checks if the user selected a file properly or just closed the dialog.
boolean validateFileDialogSelection(File selection)
{
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    return false;
  } 
  else 
  {
    println("User selected " + selection.getAbsolutePath());

    SelectedFilePath = selection.getAbsolutePath();
  //  if (matrix.footageFilePathMethod == false) selection.getAbsolutePath().replace(sketchPath(""), ""); //create relative path
 //   else SelectedFilePath = selection.getAbsolutePath(); //absolute
    return true;
  }
} //end func

//======================================================================================================

void CloseOverLayMenu()
{
  println("CloseOverLayMenu()"); 
  OverlayMenuID = 0;
  SelectFeedID = 0;
  SelectLayerID = 0;
  GlobalDDOpen = false;
}

//======================================================================================================

void OpenOverlayMenu(int passedID, int passedArgument1)
{
  println("OpenOverlayMenu("+passedID+") Passed1: "+passedArgument1); 

  OverlayMenuID = passedID;
  //what else to do?

  if (passedID == cOverlaySourceContent)
  {
    workingTileID = passedArgument1;
  } //end if()
  else if (passedID == cOverlayEffectsMenu)
  {
    //the per layer EffectsMenu is Open
    //contentLayerPtr is already updated
    effectsOptionsDD.setValue(contentLayerPtr.effectFilterIDNum);
    handleEffectsFilterElements(effectsOptionsDD.getValue());
  }
  guiOverlayMenus[OverlayMenuID].initMenu();
} //end func

//======================================================================================================

void displaySourceContentTiles()
{

  try {
    for (int i=1; i != sourceConentTile.length; i++) 
    {

      sourceConentTile[i+sourceContentScrollBar.getValue()].display(10+((i-1)*90), 655); //starts at tile #1
    } //end for
  }
  catch(Exception e) {
  }

  //These buttons are never shown but are used for over() detection
  //for (int i=0; i != contentSelectionButtons.length; i++) contentSelectionButtons[i].display();

  //Displays the (+) add Source button to the tile area
  if ((DefinedContentSources-sourceContentScrollBar.value) < contentSelectionButtons.length)
  {
    if ((DefinedContentSources-sourceContentScrollBar.value) >= 0)
    {
      //println("VALUE IS: "+DefinedContentSources+"   "+sourceContentScrollBar.Value+"   "+contentSelectionButtons.length);
      contentSelectionButtons[(DefinedContentSources)-sourceContentScrollBar.value].display();
    }
  }
} //end displaySourceContentTiles()

//======================================================================================================

void stop()
{
  try {
    fw.close();
    bw.close();
    serialPort.dispose();
    externalSerialPort.dispose();
  }
  catch(Exception e) {
  }
}

//======================================================================================================
