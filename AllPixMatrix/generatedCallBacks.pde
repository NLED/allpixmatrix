//======================================================================================================

void generatedContentBarsModeFunc()
{
  genContentBars[sourceConentTile[workingTileID].instanceID].mode = DropDownPointer.getValue();
}

void generatedContentBarsAudioModeFunc()
{
  genContentBars[sourceConentTile[workingTileID].instanceID].audioMode = DropDownPointer.getValue();
}

void generatedContentBarsWidthFunc()
{
  genericNumberInputField();
  genContentBars[sourceConentTile[workingTileID].instanceID].barWidth = (int)numberInputFieldPtr.value;
}

void generatedContentBarsSpacingFunc()
{
  genericNumberInputField();
  genContentBars[sourceConentTile[workingTileID].instanceID].barSpacing = (int)numberInputFieldPtr.value;
}

void generatedContentBarsAmplitudeFunc()
{
  genericNumberInputField();
  genContentBars[sourceConentTile[workingTileID].instanceID].barAmplitude = (int)numberInputFieldPtr.value;
}

void generatedContentBarsDecayFunc()
{
  genericNumberInputField();
  genContentBars[sourceConentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //stay as float
}

void generatedContentBarsFillColorFunc()
{
  genContentBars[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

//======================================================================================================

void generatedContentSineWaveModeFunc()
{
  genContentSineWave[sourceConentTile[workingTileID].instanceID].mode = DropDownPointer.getValue();
}

void generatedContentSineWaveAudioModeFunc()
{
  genContentSineWave[sourceConentTile[workingTileID].instanceID].audioMode = DropDownPointer.getValue();
}

void generatedContentSineWaveYOffsetFunc()
{
  genericNumberInputField();
  genContentSineWave[sourceConentTile[workingTileID].instanceID].yOffset = (int)numberInputFieldPtr.value;
}

void generatedContentSineWaveAmplitudeFunc()
{
  genericNumberInputField();
  genContentSineWave[sourceConentTile[workingTileID].instanceID].amplitude = (int)numberInputFieldPtr.value;
}

void generatedContentSineWavePeriodFunc()
{
  genericNumberInputField();
  genContentSineWave[sourceConentTile[workingTileID].instanceID].period = (int)numberInputFieldPtr.value;
}

void generatedContentSineWaveDecayFunc()
{
  genericNumberInputField();
  genContentSineWave[sourceConentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //stay as float
}

void generatedContentSineWaveFillColorFunc()
{
  genContentSineWave[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

//======================================================================================================

void generatedContentColorGenFunc()
{
  genContentSolidColor[sourceConentTile[workingTileID].instanceID].bgColor = color(guiColorSelectorMenu.red, guiColorSelectorMenu.green, guiColorSelectorMenu.blue, guiColorSelectorMenu.alpha);  //colorSquarePtr.selColor;
}

//======================================================================================================

void generatedContentTemplateSmoothingFunc()
{
  //stuff
}

void generatedContentTemplateStrokeWidthFunc()
{
  genericNumberInputField();
  //set variables or actions
}

void generatedContentTemplateSizeFunc()
{
  genericNumberInputField();
  //set variables or actions
}

//======================================================================================================

void generatedContent3DShapeStrokeColorFunc()
{
  genContent3DShape[sourceConentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContent3DShapeSizeFunc()
{
  genericNumberInputField();
  genContent3DShape[sourceConentTile[workingTileID].instanceID].size = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeStrokeWidthFunc()
{
  genericNumberInputField();
  genContent3DShape[sourceConentTile[workingTileID].instanceID].strokeWeight = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeRotXFunc()
{
  genericNumberInputField();
  genContent3DShape[sourceConentTile[workingTileID].instanceID].rotationValX = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeRotYFunc()
{
  genericNumberInputField();
  genContent3DShape[sourceConentTile[workingTileID].instanceID].rotationValY = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeSmoothingFunc()
{
  genContent3DShape[sourceConentTile[workingTileID].instanceID].enableSmoothing = gen3DShapeEnableSmoothing.selected;
}

//======================================================================================================

void generatedContent2DShapeRotSpeedFunc()
{
  genericNumberInputField();
  genContent2DShape[sourceConentTile[workingTileID].instanceID].rotationSpeed = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeZoomSpeedFunc()
{
  genericNumberInputField();
  genContent2DShape[sourceConentTile[workingTileID].instanceID].zoomSpeed = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeZoomMinFunc()
{
  genericNumberInputField();
  genContent2DShape[sourceConentTile[workingTileID].instanceID].zoomMin = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeZoomMaxFunc()
{
  genericNumberInputField();
  genContent2DShape[sourceConentTile[workingTileID].instanceID].zoomMax = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeFillColorFunc()
{
  genContent2DShape[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContent2DShapeStrokeColorFunc()
{
  genContent2DShape[sourceConentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContent2DShapeStrokeWidthFunc()
{
  genericNumberInputField();
  genContent2DShape[sourceConentTile[workingTileID].instanceID].strokeWeight = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeSizeFunc()
{
  genericNumberInputField();
  genContent2DShape[sourceConentTile[workingTileID].instanceID].baseSize = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeSmoothingFunc()
{
  genContent2DShape[sourceConentTile[workingTileID].instanceID].enableSmoothing = gen2DShapeEnableSmoothing.selected;
}

//======================================================================================================

void generatedContentSpiralColorFunc()
{
  genContentSpiral[sourceConentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContentSpiralColorModeFunc()
{
  genContentSpiral[sourceConentTile[workingTileID].instanceID].colorMode = genSpiralColorMode.getValue();
}

void generatedContentSpiralModeVariableFunc()
{
  genericNumberInputField();
  genContentSpiral[sourceConentTile[workingTileID].instanceID].modeVariable = (int)numberInputFieldPtr.value;
}

void generatedContentSpiralCoilsFunc()
{
  genericNumberInputField();
  genContentSpiral[sourceConentTile[workingTileID].instanceID].coils = (int)numberInputFieldPtr.value;
}

void generatedContentSpiralDecayFunc()
{
  genericNumberInputField();
  genContentSpiral[sourceConentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //stay as float
}

//======================================================================================================

void generatedContentRipplAmplitudeFunc()
{
  genericNumberInputField();
  genContentRipples[sourceConentTile[workingTileID].instanceID].amplitude = (int)numberInputFieldPtr.value;
}

void generatedContentRipplAudioModeFunc()
{
  genContentRipples[sourceConentTile[workingTileID].instanceID].audioMode = DropDownPointer.getValue();
}

void generatedContentRippleFillColorFunc()
{
  genContentRipples[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentRippleStrokeColorFunc()
{
  genContentRipples[sourceConentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContentRippleFillMethod()
{
  genContentRipples[sourceConentTile[workingTileID].instanceID].fillMethod = DropDownPointer.getValue();
}

void generatedContentRippleShape()
{
  genContentRipples[sourceConentTile[workingTileID].instanceID].shape = DropDownPointer.getValue();
}

void generatedContentRippleStrokeWidth()
{
  genericNumberInputField();
  genContentRipples[sourceConentTile[workingTileID].instanceID].strokeWeight = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentMetaBallsColorFunc()
{
  genContentMetaBalls[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentMetaBallsColorModeFunc()
{
  genContentMetaBalls[sourceConentTile[workingTileID].instanceID].colorMode = genMetaBallsColorMode.getValue();
}

void generatedContentMetaBallsAmountFunc()
{
  genericNumberInputField();
  genContentMetaBalls[sourceConentTile[workingTileID].instanceID].ballAmount = (int)numberInputFieldPtr.value;
}

void generatedContentMetaBallsSizeFunc()
{
  genericNumberInputField();
  genContentMetaBalls[sourceConentTile[workingTileID].instanceID].ballSize = (int)numberInputFieldPtr.value;
}

void generatedContentMetaBallsFrequencyFunc()
{
  genericNumberInputField();
  genContentMetaBalls[sourceConentTile[workingTileID].instanceID].colorFrequency = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentFallingColorFunc()
{
  genContentFallingBlocks[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentFallingBlocksDirectionFunc()
{
  genContentFallingBlocks[sourceConentTile[workingTileID].instanceID].direction = genFallingBlocksDirection.getValue();
}

void generatedContentFallingBlocksSizeFunc()
{
  genericNumberInputField();
  genContentFallingBlocks[sourceConentTile[workingTileID].instanceID].size = (int)numberInputFieldPtr.value;
}

void generatedContentFallingBlocksDecayFunc()
{
  genericNumberInputField();
  genContentFallingBlocks[sourceConentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //already a float, no typecast
}

void generatedContentFallingBlocksFreqFunc()
{
  genericNumberInputField();
  genContentFallingBlocks[sourceConentTile[workingTileID].instanceID].frequency = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentStarsStrokeColorFunc()
{
  genContentStarField[sourceConentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContentStarsColorFunc()
{
  genContentStarField[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentStarsTwinkleFunc()
{
  genContentStarField[sourceConentTile[workingTileID].instanceID].starTwinkle = genStarsTwinkleEnable.selected;
}

void generatedContentStarsStrokeFunc()
{
  genericNumberInputField();
  genContentStarField[sourceConentTile[workingTileID].instanceID].starStrokeWidth = (int)numberInputFieldPtr.value;
}

void generatedContentStarsShapeFuncSizeFunc()
{
  genericNumberInputField();
  genContentStarField[sourceConentTile[workingTileID].instanceID].starSize = (int)numberInputFieldPtr.value;
}

void generatedContentStarsQuantityFunc()
{
  genericNumberInputField();
  genContentStarField[sourceConentTile[workingTileID].instanceID].starQuantity = (int)numberInputFieldPtr.value;
}

void generatedContentStarsShapeFunc()
{
  genContentStarField[sourceConentTile[workingTileID].instanceID].starShape = genStarsShapeDD.getValue();
}

void generatedContentStarsDecayFunc()
{
  genericNumberInputField();
  genContentStarField[sourceConentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentTextBGColorFunc()
{
  genContentText[sourceConentTile[workingTileID].instanceID].bgColor = colorSquarePtr.selColor;
}

void generatedContentTextColorFunc()
{
  genContentText[sourceConentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentTextSizeFunc()
{
  genericNumberInputField(); 
  genContentText[sourceConentTile[workingTileID].instanceID].textSize = (int)numberInputFieldPtr.value;
  println("Used "+sourceConentTile[workingTileID].instanceID);
}

void generatedContentTextXFunc()
{
  genericNumberInputField(); 
  genContentText[sourceConentTile[workingTileID].instanceID].xOffset = (int)numberInputFieldPtr.value;
}

void generatedContentTextYFunc()
{
  genericNumberInputField(); 
  genContentText[sourceConentTile[workingTileID].instanceID].yOffset = (int)numberInputFieldPtr.value;
}

void generatedContentTextLabelFunc()
{
  genContentText[sourceConentTile[workingTileID].instanceID].textLabel = genTextLabel.label;
  genericHandlerTextField(); // just sets pointer obj to false
}

void generatedContentTextScrollType()
{
  genContentText[sourceConentTile[workingTileID].instanceID].scrollingType = genTextScrollTypeDD.getValue();
  genContentText[sourceConentTile[workingTileID].instanceID].scrollVal = 0; //reset scrolling value when type is changed
}


//======================================================================================================
