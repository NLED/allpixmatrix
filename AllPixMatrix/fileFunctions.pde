
//=============================================================================================================

void SaveUserContentFile(String passedFilePath)
{
  println("SaveUserContentFile() with path "+passedFilePath);
  String[] WorkString = new String[DefinedMediaTiles+1+7]; //or use cSoftwareMaxMediaTiles

  //Save other stuff first - version# - intensity and mixer values - layersA123- layersB123 -
  WorkString[0] = ""+cSoftwareVersion+cFileSep+cSoftwareRevision+cFileSep+DefinedMediaTiles+cFileSep+CrossFaderValue+cFileSep+MasterIntensity+cFileSep+FeedIntensityA+cFileSep+FeedIntensityB;

  WorkString[1] = contentLayerA[0].saveLayer();
  WorkString[2] = contentLayerA[1].saveLayer();
  WorkString[3] = contentLayerA[2].saveLayer();

  WorkString[4] = contentLayerB[0].saveLayer();
  WorkString[5] = contentLayerB[1].saveLayer();
  WorkString[6] = contentLayerB[2].saveLayer();

  for (int i = 0; i <= DefinedMediaTiles; i++)
  {
    WorkString[i+7] = mediaContentTile[i].saveContent();
  } //end for 

  saveStrings(passedFilePath, WorkString); //now save to file
}

//=============================================================================================================


void ResetObjects()
{
  genContentText = new generatedText[cMaxGeneratedObjects];
  genContentStarField = new generatedStarField[cMaxGeneratedObjects];
  genContentFallingBlocks = new generatedFallingBlocks[cMaxGeneratedObjects];
  genContentMetaBalls = new generatedMetaBalls[cMaxGeneratedObjects];
  genContentRipples = new generatedRipples[cMaxGeneratedObjects];
  genContentSpiral = new generatedSpiral[cMaxGeneratedObjects];
  genContentSolidColor = new generatedSolidColor[cMaxGeneratedObjects];
  genContentPlasma = new generatedPlasma[cMaxGeneratedObjects];
  genContent2DShape = new generated2DShape[cMaxGeneratedObjects];
  genContent3DShape = new generated3DShape[cMaxGeneratedObjects];
  genContentTemplate = new generatedTemplate[cMaxGeneratedObjects]; //empty slot use to add another generated function
  genContentSineWave = new generatedSineWave[cMaxGeneratedObjects];
  genContentBars = new generatedBars[cMaxGeneratedObjects];
  
   //Reset media tiles, in case loading a new content file
  mediaContentTile  = new mediaContentObj[cSoftwareMaxMediaTiles];
}

//=============================================================================================================

void LoadUserContentFile(String passedFilePath)
{
  println("LoadUserContentFile()");
  
  try {
  String[] strLines = loadStrings(passedFilePath);
  String[] workString = new String[100]; 
  int lineCount = 7; 

 // println(strLines[0]); //show the top line, not loaded for now
  workString = split(strLines[0], ',');
  //version = workString[0]
  //revision = workString[1]  
  //DefinedMediaTiles = workString[2]
  CrossFaderValue = float(workString[3]);
  MasterIntensity = float(workString[4]);  
  FeedIntensityA = float(workString[5]);
  FeedIntensityB = float(workString[6]);

  DefinedMediaTiles = 0; //start from beginning
  workingTileID = 0; //start from beginning

  ResetObjects(); //resets objects so new instance IDs and media tile settings are cleared
  
  for (int i = 0; i <= strLines.length-8; i++) //starts at 0 since it saves the [0] null content object
  {
    DisposeGeneratedObjects(); //get rid of any objects that are currently assigned, if any. Only applicable on any load after one in setup()

    createMediaContentObj("Loading", 0, 0, ""); //add place hold object, filled later
    
    mediaContentTile[i].loadContent(strLines[lineCount]); //use the saved string to fill with proper values and parameters
      
    if(mediaContentTile[i].typeID == cTypeIDGenerated)
    {
    println("Load generated parameters");
    mediaContentTile[i].localLoadParameters(strLines[lineCount]);
    }
  
    workingTileID++;
    lineCount++;
  } //end for 


  //now that the mediaContentTiles are loaded and populated, assign layers from save file
  //workString = split(strLines[1], ',');     //layer ID numbers
  contentLayerA[0].loadLayer(strLines[1]);
  contentLayerA[1].loadLayer(strLines[2]);
  contentLayerA[2].loadLayer(strLines[3]);
  contentLayerB[0].loadLayer(strLines[4]);
  contentLayerB[1].loadLayer(strLines[5]);
  contentLayerB[2].loadLayer(strLines[6]);
  }
  catch(Exception e)
  {
	  println("There was a problem loading the media content file");
	  
  }
  
  
  mediaContentScrollBar.value = 0; //set media tile scroll area to lowest
}

//=============================================================================================================

void LoadConfigurationFiles()
{
  //loads config.ini to get the path to the device configuration file, each matrix will most likley require their own device config file 
  println("LoadConfigurationFile()");

  String[] workString = new String[5]; //used to divide the lines into tab
  String[] strLines = loadStrings("software.ini"); //divides the lines
  //software.ini now loaded

  workString = split(strLines[0], '\t'); //get CONFIGDIR directory string
  software.configFilePath = workString[1];

  println("Using config directory: "+software.configFilePath);
  
  workString = split(strLines[1], '\t'); //get GUIWIDTH value
  software.GUIWidth = int(workString[1]);

  workString = split(strLines[2], '\t'); //get GUIHEIGHT value
  software.GUIHeight = int(workString[1]);

  workString = split(strLines[3], '\t'); //get MOUSEOVER value
  software.mouseOverEnabled = boolean(workString[1]);

  workString = split(strLines[4], '\t'); //get MIDIENABLE value
  software.MIDIenable = boolean(workString[1]);

  workString = split(strLines[5], '\t'); //get MIDIENABLE value
  software.MIDIport = int(workString[1]);

  // frameRateMs never filled from file

  //can't do this here
  // surface.setSize(software.GUIWidth,software.GUIHeight); //resize window
  // PrevWidth = 0;
  // PrevHeight = 0;
  // set SF value

  //------------------ now load the matrix config file ---------------------------------------------

  strLines = loadStrings(File.separator+"configs"+File.separator+software.configFilePath+"/matrix-config.ini"); //divides the lines
  //config file for matrix is now loaded
  //printArray(strLines); 

  workString = split(strLines[0], '\t'); //get NAME string
  matrix.name = workString[1];

  workString = split(strLines[1], '\t'); //get PATCHFILE string
  matrix.patchFileName = workString[1];

  workString = split(strLines[2], '\t'); //get CONTENTFILE string
  matrix.contentFileName = workString[1];

  workString = split(strLines[3], '\t'); //get FOOTAGEDIR boolean
  matrix.footagePath = workString[1];

  workString = split(strLines[4], '\t'); //get AUTOMATICFILE boolean
  matrix.automaticFileName = workString[1];

//not sure if this is a good way, but have to utilize relative paths for ease of use, but absolute for expanded usage
/*
  if(matrix.footagePath.equals("LOCAL")) 
  {
  println("SET LOCAL ACTIVE");
  matrix.footageFilePathMethod = false; //use relative
  matrix.footagePath = sketchPath("");
  }
  else
  {
  matrix.footageFilePathMethod = true; //use absolute
  matrix.footagePath = "";
  }
  */
  
  //------------------ Load Output Config File ---------------------------------------------

  strLines = loadStrings("/configs/"+software.configFilePath+"/output-config.ini"); //divides the lines
  //output file for matrix now loaded

  workString = split(strLines[0], '\t'); //get OUTPUTTYPE integer
  matrix.transmissionType = int(workString[1]);

  workString = split(strLines[1], '\t'); //get OUTPUTPORT integer
  matrix.serialPort = int(workString[1]);

  workString = split(strLines[2], '\t'); //get OUTPUTBAUD integer
  matrix.serialBaud = int(workString[1]);

  workString = split(strLines[3], '\t'); //get OUTPUTFPS integer
  matrix.outputFPS = 1000/int(workString[1]); //store as mS

  workString = split(strLines[4], '\t'); //get COLORORDER integer
  matrix.colorOrderID = int(workString[1]); 

  workString = split(strLines[5], '\t'); //get AURORACMD boolean
  matrix.auroraCMD = boolean(workString[1]);

  workString = split(strLines[6], '\t'); //get EXTERNALDATA integer
  matrix.externalDataEnable = boolean(workString[1]); 

  workString = split(strLines[7], '\t'); //get EXTERNALPORT integer
  matrix.externalDataPort = int(workString[1]); 

  workString = split(strLines[8], '\t'); //get EXTERNALBAUD integer
  matrix.externalDataBaud = int(workString[1]); 

  EstablishOutputConnection();

  println("Configs loaded");
} //end load config

//=============================================================================================================

void ReadDataFile()
{
  //println("ReadDataFile(), Frame: "+FilePlayDataCount);
  FilePlayDataBuffer = int(split(FilePlayStrLines[FilePlayDataCount], ','));
  FilePlayDataCount++;
  if (FilePlayDataCount >= FilePlayStrLines.length) FilePlayDataCount = 0;
}

//=============================================================================================================
