//======================================================================================================

void generatedContentBarsModeFunc()
{
  genContentBars[mediaContentTile[workingTileID].instanceID].mode = DropDownPointer.getValue();
}

void generatedContentBarsAudioModeFunc()
{
  genContentBars[mediaContentTile[workingTileID].instanceID].audioMode = DropDownPointer.getValue();
}

void generatedContentBarsWidthFunc()
{
  genericNumberInputField();
  genContentBars[mediaContentTile[workingTileID].instanceID].barWidth = (int)numberInputFieldPtr.value;
}

void generatedContentBarsSpacingFunc()
{
  genericNumberInputField();
  genContentBars[mediaContentTile[workingTileID].instanceID].barSpacing = (int)numberInputFieldPtr.value;
}

void generatedContentBarsAmplitudeFunc()
{
  genericNumberInputField();
  genContentBars[mediaContentTile[workingTileID].instanceID].barAmplitude = (int)numberInputFieldPtr.value;
}

void generatedContentBarsDecayFunc()
{
  genericNumberInputField();
  genContentBars[mediaContentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //stay as float
}

void generatedContentBarsFillColorFunc()
{
  genContentBars[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

//======================================================================================================

void generatedContentSineWaveModeFunc()
{
  genContentSineWave[mediaContentTile[workingTileID].instanceID].mode = DropDownPointer.getValue();
}

void generatedContentSineWaveAudioModeFunc()
{
  genContentSineWave[mediaContentTile[workingTileID].instanceID].audioMode = DropDownPointer.getValue();
}

void generatedContentSineWaveYOffsetFunc()
{
  genericNumberInputField();
  genContentSineWave[mediaContentTile[workingTileID].instanceID].yOffset = (int)numberInputFieldPtr.value;
}

void generatedContentSineWaveAmplitudeFunc()
{
  genericNumberInputField();
  genContentSineWave[mediaContentTile[workingTileID].instanceID].amplitude = (int)numberInputFieldPtr.value;
}

void generatedContentSineWavePeriodFunc()
{
  genericNumberInputField();
  genContentSineWave[mediaContentTile[workingTileID].instanceID].period = (int)numberInputFieldPtr.value;
}

void generatedContentSineWaveDecayFunc()
{
  genericNumberInputField();
  genContentSineWave[mediaContentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //stay as float
}

void generatedContentSineWaveFillColorFunc()
{
  genContentSineWave[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

//======================================================================================================

void generatedContentColorGenFunc()
{
  genContentSolidColor[mediaContentTile[workingTileID].instanceID].bgColor = color(guiColorSelectorMenu.red, guiColorSelectorMenu.green, guiColorSelectorMenu.blue, guiColorSelectorMenu.alpha);  //colorSquarePtr.selColor;
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
  genContent3DShape[mediaContentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContent3DShapeSizeFunc()
{
  genericNumberInputField();
  genContent3DShape[mediaContentTile[workingTileID].instanceID].size = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeStrokeWidthFunc()
{
  genericNumberInputField();
  genContent3DShape[mediaContentTile[workingTileID].instanceID].strokeWeight = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeRotXFunc()
{
  genericNumberInputField();
  genContent3DShape[mediaContentTile[workingTileID].instanceID].rotationValX = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeRotYFunc()
{
  genericNumberInputField();
  genContent3DShape[mediaContentTile[workingTileID].instanceID].rotationValY = (int)numberInputFieldPtr.value;
}

void generatedContent3DShapeSmoothingFunc()
{
  genContent3DShape[mediaContentTile[workingTileID].instanceID].enableSmoothing = gen3DShapeEnableSmoothing.selected;
}

//======================================================================================================

void generatedContent2DShapeRotSpeedFunc()
{
  genericNumberInputField();
  genContent2DShape[mediaContentTile[workingTileID].instanceID].rotationSpeed = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeZoomSpeedFunc()
{
  genericNumberInputField();
  genContent2DShape[mediaContentTile[workingTileID].instanceID].zoomSpeed = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeZoomMinFunc()
{
  genericNumberInputField();
  genContent2DShape[mediaContentTile[workingTileID].instanceID].zoomMin = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeZoomMaxFunc()
{
  genericNumberInputField();
  genContent2DShape[mediaContentTile[workingTileID].instanceID].zoomMax = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeFillColorFunc()
{
  genContent2DShape[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContent2DShapeStrokeColorFunc()
{
  genContent2DShape[mediaContentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContent2DShapeStrokeWidthFunc()
{
  genericNumberInputField();
  genContent2DShape[mediaContentTile[workingTileID].instanceID].strokeWeight = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeSizeFunc()
{
  genericNumberInputField();
  genContent2DShape[mediaContentTile[workingTileID].instanceID].baseSize = (int)numberInputFieldPtr.value;
}

void generatedContent2DShapeSmoothingFunc()
{
  genContent2DShape[mediaContentTile[workingTileID].instanceID].enableSmoothing = gen2DShapeEnableSmoothing.selected;
}

//======================================================================================================

void generatedContentSpiralColorFunc()
{
  genContentSpiral[mediaContentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContentSpiralColorModeFunc()
{
  genContentSpiral[mediaContentTile[workingTileID].instanceID].colorMode = genSpiralColorMode.getValue();
}

void generatedContentSpiralModeVariableFunc()
{
  genericNumberInputField();
  genContentSpiral[mediaContentTile[workingTileID].instanceID].modeVariable = (int)numberInputFieldPtr.value;
}

void generatedContentSpiralCoilsFunc()
{
  genericNumberInputField();
  genContentSpiral[mediaContentTile[workingTileID].instanceID].coils = (int)numberInputFieldPtr.value;
}

void generatedContentSpiralDecayFunc()
{
  genericNumberInputField();
  genContentSpiral[mediaContentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //stay as float
}

//======================================================================================================

void generatedContentRipplAmplitudeFunc()
{
  genericNumberInputField();
  genContentRipples[mediaContentTile[workingTileID].instanceID].amplitude = (int)numberInputFieldPtr.value;
}

void generatedContentRipplAudioModeFunc()
{
  genContentRipples[mediaContentTile[workingTileID].instanceID].audioMode = DropDownPointer.getValue();
}

void generatedContentRippleFillColorFunc()
{
  genContentRipples[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentRippleStrokeColorFunc()
{
  genContentRipples[mediaContentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContentRippleFillMethod()
{
  genContentRipples[mediaContentTile[workingTileID].instanceID].fillMethod = DropDownPointer.getValue();
}

void generatedContentRippleShape()
{
  genContentRipples[mediaContentTile[workingTileID].instanceID].shape = DropDownPointer.getValue();
}

void generatedContentRippleStrokeWidth()
{
  genericNumberInputField();
  genContentRipples[mediaContentTile[workingTileID].instanceID].strokeWeight = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentMetaBallsColorFunc()
{
  genContentMetaBalls[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentMetaBallsColorModeFunc()
{
  genContentMetaBalls[mediaContentTile[workingTileID].instanceID].colorMode = genMetaBallsColorMode.getValue();
}

void generatedContentMetaBallsAmountFunc()
{
  genericNumberInputField();
  genContentMetaBalls[mediaContentTile[workingTileID].instanceID].ballAmount = (int)numberInputFieldPtr.value;
}

void generatedContentMetaBallsSizeFunc()
{
  genericNumberInputField();
  genContentMetaBalls[mediaContentTile[workingTileID].instanceID].ballSize = (int)numberInputFieldPtr.value;
}

void generatedContentMetaBallsFrequencyFunc()
{
  genericNumberInputField();
  genContentMetaBalls[mediaContentTile[workingTileID].instanceID].colorFrequency = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentFallingColorFunc()
{
  genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentFallingBlocksDirectionFunc()
{
  genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].direction = genFallingBlocksDirection.getValue();
}

void generatedContentFallingBlocksSizeFunc()
{
  genericNumberInputField();
  genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].size = (int)numberInputFieldPtr.value;
}

void generatedContentFallingBlocksDecayFunc()
{
  genericNumberInputField();
  genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value; //already a float, no typecast
}

void generatedContentFallingBlocksFreqFunc()
{
  genericNumberInputField();
  genContentFallingBlocks[mediaContentTile[workingTileID].instanceID].frequency = (int)numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentStarsStrokeColorFunc()
{
  genContentStarField[mediaContentTile[workingTileID].instanceID].strokeColor = colorSquarePtr.selColor;
}

void generatedContentStarsColorFunc()
{
  genContentStarField[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentStarsZDistFunc()
{
  genContentStarField[mediaContentTile[workingTileID].instanceID].starZDist = genStarsZDistEnable.selected;
}

void generatedContentStarsStrokeFunc()
{
  genericNumberInputField();
  genContentStarField[mediaContentTile[workingTileID].instanceID].starStrokeWidth = (int)numberInputFieldPtr.value;
}

void generatedContentStarsShapeFuncSizeFunc()
{
  genericNumberInputField();
  genContentStarField[mediaContentTile[workingTileID].instanceID].starSize = (int)numberInputFieldPtr.value;
}

void generatedContentStarsQuantityFunc()
{
  genericNumberInputField();
  genContentStarField[mediaContentTile[workingTileID].instanceID].starQuantity = (int)numberInputFieldPtr.value;
}

void generatedContentStarsShapeFunc()
{
  genContentStarField[mediaContentTile[workingTileID].instanceID].starShape = genStarsShapeDD.getValue();
}

void generatedContentStarsDecayFunc()
{
  genericNumberInputField();
  genContentStarField[mediaContentTile[workingTileID].instanceID].decay = numberInputFieldPtr.value;
}

//======================================================================================================

void generatedContentTextBGColorFunc()
{
  genContentText[mediaContentTile[workingTileID].instanceID].bgColor = colorSquarePtr.selColor;
}

void generatedContentTextColorFunc()
{
  genContentText[mediaContentTile[workingTileID].instanceID].fillColor = colorSquarePtr.selColor;
}

void generatedContentTextSizeFunc()
{
  genericNumberInputField(); 
  genContentText[mediaContentTile[workingTileID].instanceID].textSize = (int)numberInputFieldPtr.value;
  println("Used "+mediaContentTile[workingTileID].instanceID);
}

void generatedContentTextXFunc()
{
  genericNumberInputField(); 
  genContentText[mediaContentTile[workingTileID].instanceID].xOffset = (int)numberInputFieldPtr.value;
}

void generatedContentTextYFunc()
{
  genericNumberInputField(); 
  genContentText[mediaContentTile[workingTileID].instanceID].yOffset = (int)numberInputFieldPtr.value;
}

void generatedContentTextLabelFunc()
{
  genContentText[mediaContentTile[workingTileID].instanceID].textLabel = genTextLabel.label;
  genericHandlerTextField(); // just sets pointer obj to false
}

void generatedContentTextScrollType()
{
  genContentText[mediaContentTile[workingTileID].instanceID].scrollingType = genTextScrollTypeDD.getValue();
  genContentText[mediaContentTile[workingTileID].instanceID].scrollVal = 0; //reset scrolling value when type is changed
}


//======================================================================================================
