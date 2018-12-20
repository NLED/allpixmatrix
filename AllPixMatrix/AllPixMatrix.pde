/*
 MIT License
 
 Copyright (c) 2018 Northern Lights Electronic Design, LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 Original Author: Jeffrey Nygaard
 Copyright 2018
 Company: Northern Lights Electronic Design, LLC
 Contact: JNygaard@NLEDShop.com
 Date Updated: December 19, 2018 
 Software Version:  v.1b
 Webpage: www.NLEDShop.com/nledallpixmatrix
 Written in Processing v3.4  - www.Processing.org
 
 
 ======================================================================================================================================
 
What It Does:
The software uses many media types such as images, animated GIFs, videos(many codecs), Spout/Syphon, external data reception(like Glediator) and software
generated content. It converts or maintains the media to low resolution, that will display well on low resolution LED matrices. Small scale LED matrices
require low resolution media, as scaling down larger standard sized media results in poor looking images once down scaled. The different types of 
media content can be mixed together in different ways, and have effects and filters applied to them. The resulting output is transmitted out to a serial
port(like a FTDI or USB enabled microcontroller) which converts it to a pixel chipset protocol and sends it to the pixels.

Description:
This program was written for use with my projects and products, but hope it will be useful to others as well. I am frequently asked about how best to 
create content for low-resolution pixel matrices. There are a few choices out there, but none that are feature rich and open source. This software was 
kept simple as possible with the ability to easily modify and add to it. Processing has many inbuilt graphics functions that made it a good choice for 
this type of software.

Compatible Controllers: There are many ways to receive the output from this software.
NLED Pixel Controller Micro - Serial
NLED Pixel Controller Mini - Serial
NLED Pixel Controller Ion - Aurora USB or Serial
NLED Pixel Controller Electron - Aurora USB or Serial
More NLED Controllers will be available soon
Arduino Controllers that are compatible with Glediator

Currently no Arduino sktech, but should work with any Gleidator compatible sketches. If someone wants to write one, I can link it.
Previously I have had reports that USB enabled Arduinos may not work with the default USB stack. I think this is because the default USB stack
can not handle the data volume. So the stack may need to be adjusted or rewritten.

Maximum Size matrix: 512x512 - not tested or know if it would actually work. But software would support it.

 ======================================================================================================================================
 
 Changes v.1a to v.1b:
	- Added Artnet output support, ID#3, use the OUTPUTPORT line on matrix-output.ini to set the IP address
	- Overhauled the the application timing. No longer uses frameRate(1000) for timing
		- Threads off the media updating, layer mixing, and final mixing. - Creates a few issues
			- The mixing function's color min/max causes graphical GUI glitches and CPU usage has increased
		- Now output transmission packet rate is a lot tighter and regular.
	- Fixed the display "Output Rate(mS)" as it was showing incorrect time
	- Numerous variable optimizations
 
Changes BETA 0.99 to v.1a
	- numerous GUI fixes
	- Star fieild 'twinkle' changed to z-distance
	- Updated media crop/resize options
	- Centered matrix preview grids
	- Numerous fixes to prevent stalls/freezes when loading external data streams
	- Fixed per layer pausing and feed pausing
	- Fixed issues with re-loading config files during application runtime
	- Renamed numerous variables and objects with more refined naming schemes
	- Added option to record to file for string or binary/raw formated files
	
	
======================================================================================================================================
	
Added Notes: ----------------------------------------------------------------------------------------------------
 	 
	With Aurora USB protocol, could only get 60mS packet rate with 784 pixels(2352 byte frames)
	 
	 
General Notes: ----------------------------------------------------------------------------------------------------
 
 May run terribly on some systems - Still needs much more optimization. Use a computer with good CPU.
   - Tested on a i7-7700K, 32GB RAM, GTX 1070 GPU
		- 27% CPU with hint(DISABLE_OPTIMIZED_STROKE), 160MB RAM
		- 17% CPU without hint(DISABLE_OPTIMIZED_STROKE), 160MB RAM
		- In the MainMixingThread() adding the delay(), which sleeps the thread, reduces CPU usage as well

Known Issues: ----------------------------------------------------------------------------------------------------
 
	- Aurora command protocol not compatible with network(TCP/UDP) transmission methods yet
 
	- Graphical GUI glitches - it is because of editing the pixel array for the scratchGBuf from a thread.
		- No idea why it is happening, but see the MixingCommonApplyColorEffects() for details
		- For now if a layer is not using the min/max color effects it won't run the code and won't cause the glitches
 
	- if a USB controller or adapter is disconnected from the PC, the software will not detect it and will continue running normally
		- this is supposedly an unsolveable issue software side. Java can't detect if the serial port is not receiving on the hardware end
		- for now unplug the USB serial device, run "Reload Configs" from main menu, plug back in the serial device and run "Reload Configs" again.
		- If anyone has any input on this, it would be very helpful to get fixed.
 
	- if a media content tile is on both feeds, it can't be paused by the Feed Pause, unless both feeds are paused
	
	- can only have one "Data File" media loaded at once, otherwise will use the data file that was last selected
 
	- If a media tile is on multiple feeds or layers, some per layer or per feed settings are applied to all of the refrences
		- the last one to be placed highest speed over rides, among others such as play modes(play pause)
 
	- Doesn't fully produce a thumbnail of a generated media type until it is added to a layer or otherwise ran for multiple frames
 
    - Need to prevent commas from being used in file paths, since it will jam up the content file loading/saving
 
    - Glediator data or image needs to be rotated clockwise 90 degrees
 
    - If AURORACMD is set but a serial device is connected it may put it out of frame. Pause the output then re-enable to reset.
 
	- hint(DISABLE_OPTIMIZED_STROKE) significantly increases draw() time, but strokes overlay menus if it is not used
		- Would also help on slower systems to disable the hint(), doesn't cause any functional issues just GUI stuff
 
 
Mouse and Keyboard Input: ----------------------------------------------------------------------------------------------------

	To fill a layer, click the layer preview icon, it will highlight red, then click one of the mediaContentTile to fill the layer. Right click to cancel the selection.
	Clicking the layer preview icon when selected will open the media content tile menu if a content is loaded onto the layer. Same as opening it through the media content tile area.
	Right click a layer preview icon to clear the layer.

	MouseWheel or the scrollbar over media content selection area to the view the available tiles.

	Use mouse arrow down/up to select drop down items - click the drop down first
	Use mouse arrow left/right to adjust sliders - click the slider first

	
 Usage Notes: ----------------------------------------------------------------------------------------------------

 - selectInput() when used with P2D or P3D renderer has an open issue, the fix is to minimize the main window while the file dialog is open
	- issue is posted on github, maybe fixed someday
 
 - All media buffers stay in PImage or PGraphics buffers until last step when the buffered images are converted into raw bytes for transmission
 - Have to use imageBuffer.get() to copy, otherwise PImage = PImage acts as a pointer, doubt it is suppose to.
 
 - Should effects(filter(), contrast, color min/max, tint) be per layer or per media tile?
 
 - Gui element values are only updated never called, global variables and objects should be filled and applied to the elements
    - Getters and setters, no long variable pulling from objects - didn't quite work out like that
 
 - Content previews on tiles and layers are not affected by filters and effects
 
 - Software uses the default rxtx files, so no need for a special confusing install
 
 - Use Java Mission control to try and optimize more
 
 - Large Patches for certain slows down the software
	 - doesn't matter if serial or USB(serial)

	 
 Audio Notes: ----------------------------------------------------------------------------------------------------
 
 - Requires a 'line in' in order to use sound reactivity - using generated media sources.
 - Might be cool to detect the BPM and run actions on beat. Like what actions? 
 - Sound reactivity input - future changes
	 - map it to various parameters dynamically
	 - create multiple Audio value streams with options, then map them to parameters
	 - use generated instanceID for selecting audioInputs
	 

 GUI Notes: --------------------------------------------------------------------------------------------
 
 - Fully scalable GUI in 16:9 resolution - native is 1366 x 768
 - Fully resizable window, uses scale() feature, requires mouseX and mouseY to be converted to mouseXS and mouseYS 
 - All the drawing is static sized, the scale() function scales it accordingly.
 - GUI elements are meant to be large to make it more touchscreen compatible. 
 
 
 Frame Rates: --------------------------------------------------------------------------------------------
 
 - Software runs at a default of 30 FPS. Currently DISABLE_OPTIMIZED_STROKE is dragging that down to 15FPS
 - Transmission output is based on when newly updated data is available for transmission. Sent once flag is set.
 - Content has a FPS and layers have an FPS. When content is loaded to a layer it sets the layers FPS.
 - The layer FPS can be adjusted on the fly and does not affect the media source FPS.
 
 
 Processing Renders: ---------------------------------------------------------------------------------------------
 
 https://forum.processing.org/two/discussion/14874/p2d-now-slow-even-on-an-empty-sketch-wasn-t-so-slow-before
 
 - Default renderer works well. No syphon support, 3D generated won't work at all. Other generated issues.
 - P2D is required for syphon/spout, but has lag problems
 - problem was size() P2D with P2D scratch and mixing PGraphics buffers.
 - P3D works well, but all strokes overlay everything else that is drawn.
 - hint(DISABLE_OPTIMIZED_STROKE); makes strokes display correctly.
 
 
 Overlay Menus: ---------------------------------------------------------------------------------------------
 
 - Effects: generated per layer.
 - Color Chooser: no library one, uses custom one with alpha/transparency options. All 8-bit colors.
 - Media Tile Loading: not all use GUI menu, some need ini defines(glediator input COM port & baud).
 - Options Menu: not yet populated, not sure what will go there.
 
 
 Generated Media: ---------------------------------------------------------------------------------------------
 
 - Each type of generated content is an object with parameters and methods. Allowing multiple of the same type to run at the same time, with independant parameters.
 - Parameters are saved and restored with the content save(.allpix) files.
 - When selecting a generated media type it scans and either finds an empty slot or adds another object. Variable is instanceID, the cMaxGeneratedObjects is the maximum instances.
 - When changed to another generated media type or similar, it disposes the previous generated object, loosing any settings.
 - Generated content does not support negative framerates, which indicates 'play in reverse'. It could be done, but some generated types have parameters that reverse it's function
 - DecayBuffer() not working that well with transparency. Think it is a bit strange, but fine for now.
 
 
 "Star Field" 
 - starts with too many stars.
 "Falling Blocks"
 - Falling blocks needs more randomization, can turn into a solid line
 - frequency - spaces the blocks out after they are reset after falling 'off' screen
 "Meta Balls"
 "Plasma" - want to rewrite this with a different method of plasma generation
 "Ripples"
 - add reverse option, shapes move inwards
 "Spiral"
 "Text"
 - textWidth() not working properly for scrolling, add some spaces for now
 "Solid Color"
 - Add fade scroll to solid color, solid or gradient or whatever add some usage to it
 - multiple colors, an angle adjustment, scroll speed(FPS?)
 "2D Shape" - square/circle
 "3D Shape" - only one shape, that is box()/cube
 "Sine Wave" - either audio sines, or generated sine
 "Dancing Bars" - either audio or random based
 "Template" - empty generated type with a few elements for adding new media generation routines
 
 
 Effects & Filters: ---------------------------------------------------------------------------------------------
 
 - Uses the built in processing function filter() with a paramater
 
 Additional Stand-Alone Effects:
 - Minimum/Contrast - actual contrast is complicated - this just sets the minimum a color value can be. If contrast is 40, and red is 38, red = 0. Makes 'muddy' colors more vibrant
 - Max Color Value - sets the highest value the color can be, otherwise sets it to the max color value. If set to 220, and red is 240, red = 220.
 - Min Color Value - similar to minimum/contrast but on a per color basis. If set to 10 and red is 8, red = 0
 - Color Tint - overlays a color on top of the layer. Use transparency/alpha for best results
 - Add brightness maybe in the future
 

 Effects: 
 - Want things like mirror, kaleidescope, what else?
 
 
 Blending: ---------------------------------------------------------------------------------------------
 
 - Figure out blending modes, why some allow transparency variation and some don't - doesn't make sense
     - gotta be how alpha channel is being used, when it writes to PGraphics it maintains alpha, 
 - Add minim and maxim blend modes for main mixing like NLED Matrix, they work well for this usage
 
 From Processing docs:
	 We recommend using blendMode() and not the previous blend() function. However, unlike blend(), 
	 the blendMode() function does not support the following: HARD_LIGHT, SOFT_LIGHT, OVERLAY, DODGE, BURN. On older hardware, 
	 the LIGHTEST, DARKEST, and DIFFERENCE modes might not be available as well.
	 
	 
 Media Content Resolution Notes: ---------------------------------------------------------------------------------------------
 
 - Can use any sized media content, but it must be cropped or shrunk if over-sized
 - The function uses X,Y offsets and width and height of crop.
 - Can be scaled to X&Y which ignores porportions, scaled to W or to H which may leave black space or crop off content
 - Generated content is always at a native matrix size, same for external data content. Is never scaled by matrix size, only the settings.
 
 
 Spout/Syphon Notes:  ---------------------------------------------------------------------------------------------
 
 - Spout IDs will be different every time the software loads, due to they are IDed based on what? when the order the transmitters are started?
 - NEVER SELECT THE SPOUT SENDER INSIDE SOFTWARE
 - Can not pull the width and height, have to grab them at source loading
 - Spout feed was cropw and croph of 1, so only one pixel showed.. was from mildrop - was because no spout feeds were available at software start up
 
 
 Future Updates: ---------------------------------------------------------------------------------------------
 
 - Artnet reception as a media type - receive from other matrix programs
 - Media tiles need to be updated to hold layer sets. So a single selection of a media tile will load multiple layers with media.
 - Remote control - midi or OSC or whatever
 - Still need to add automatic fading, and automated playlist modes. Among many other small features. Will be a automated mixing routine.
 - Thread off automatic mode once written
 - And need to port to spout to syphon and get Mac version working.
 - Lock or notify if media content is assigned to a layer if when the menu is open. Since certain per layer features are applied to the media tile
 - Get rid of tile buttons, use just the object - define an area, add an over() - Maybe merge all the element mousedPressed like display() 
 - Add option to preview matrix as circles rather than squares
 - Add dithering/gamma correction as last step
 - For cropping media content in the media tile menu, drag the handles to adjust
 - Keep image and video IDs, but make them load from a single button/GUI elements, its easier, then check extension for validity and image vs video - forget it
 - Type face or font selection for generated media text type
 - Rolling backup content file saving	
 
 
 Relevant Links: ---------------------------------------------------------------------------------------------
 
 https://github.com/leadedge/SpoutProcessing/blob/master/src/spout/Spout.java#L97

 https://processing.org/reference/XML.html
 https://en.wikipedia.org/wiki/16:9
 http://syphon.v002.info/FrameworkDocumentation/annotated.html
 http://spout.zeal.co/
 https://github.com/leadedge/SpoutProcessing/blob/master/src/spout/Spout.java
 https://byrodrigo.wordpress.com/2010/09/24/pixelate-with-processing/
 */

//=========================================================================================================================================================================

// IMPORT Libraries
import spout.*;
import processing.video.*;
import processing.serial.*;
import processing.net.*;   //used for UDP communication

//For sound reactivity
import ddf.minim.*;
import ddf.minim.analysis.*;

//FileWriter libraries for recording output to file
import java.io.BufferedWriter; //required for file recording mode
import java.io.FileWriter; //required for file recording mode

//Midi for external control - add later

//Artnet via artnetp4j
import ch.bildspur.artnet.*;


//============================ Software Constants ================================

final int cSoftwareVersion = 0;
final int cSoftwareRevision = 0;

final int cSoftwareMaxMediaTiles = 65; //128 later
final int cSoftwareMaxSpout = 8; 
final int cSoftwareMaxLayers = 3;
final int cSoftwareMaxViewedTiles = 15;


final int cMaxGeneratedObjects = 8;

final int cPreviewContentWidth = 450; 
final int cPreviewContentHeight = 260; 

final int cDefaultGUIWidth = 1366;
final int cDefaultGUIHeight = 768;

final int tileWidth = 80;
final int tileHeight = 80;  

final int cAudioBufferSize = 512;  //used to construct the audio input object, some generated contents use it. In case of no audioin object

final int cGUIRefreshFPS = 30;
final int cDefaultContentFPS = 24;
final int cDefaultOutputFPS = 30;

final int cBackgroundColor = color(65, 65, 65); // have to update all Handlestatus so can remove

//Overlay Menu IDs
final int cOverlayMediaTileMenu = 1; //menu IDs
final int cOverlayEffectsMenu = 2;
final int cOverlayMainMenu = 3;

final int cTypeIDNULL = 0;
final int cTypeIDVideo = 1;
final int cTypeIDAniGIF = 2;
final int cTypeIDImage = 3;
final int cTypeIDSpout = 4;
final int cTypeIDGenerated = 5;
final int cTypeIDDataFile = 6;
final int cTypeIDExtData = 10;

final int cMousePressHoldBaseTime = 500;
final int cMousePressHoldMinTime = 50;
final int cMousePressHoldAdjustmentTime = 100;

final String cFileSep = ","; //used for file saving

//============================ Application Constants ================================

final String cDDStrListBlendModes[] = {"Blend", "Add", "Subtract", "Darkest*", "Lightest", "Difference", "Exclusion", "Multiply", "Screen", "Replace"};
final int cBlendID[] = {BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, REPLACE}; //needed to call blendMode(variable)

final String cScaleOptionsDDStr[] = {"Native/None", "Scale W & H", "Scale To W", "Scale To H"};

final String cColorOrderStr[] = {"RGB", "BRG", "GBR", "RBG", "BGR", "GRB"};

final String cDDStrListFilterModes[] = {"NONE", "THRESHOLD", "GRAY", "OPAQUE", "INVERT", "POSTERIZE", "BLUR", "ERODE", "DILATE"};
final int cFilterIDStr[] = {9999, THRESHOLD, GRAY, OPAQUE, INVERT, POSTERIZE, BLUR, ERODE, DILATE};

final String cDDStrListGeneratedTypes[] = {"None", "Text", "Star Field", "Falling Blocks", "Meta Balls", "Ripples", "Spiral", "Solid Color", "Plasma", "2D Shape", "3D Shape", "Sine Wave", "Dancing Bars", "Template"};
final String cDDStrListGeneratedShapes[] = {"Point", "Square", "Circle"};
final String cDDStrListGeneratedScrollType[] = {"Stationary", "Left", "Right", "Up", "Down"};
final String cDDStrListGeneratedFontType[] = {"Default"};
final String cDDGeneratedDirection[] = {"Down", "Up", "Right", "Left"};
final String cDDGeneratedColorMode[] = {"Color Cycle", "Color Select"};
final String cDDGeneratedRippleShapes[] = {"Circle", "Square"};
final String cDDGeneratedRippleFillMethod[] = {"Stroke", "Fill", "Fill & Stroke"};
final String cDDGeneratedSpiralColorMode[] = {"Color Select", "Color Cycle", "Rainbow"};
final String cDDGeneratedBarsModes[] = {"Bottom", "Bottom, Full", "Wave Bars", "Wave Mirrored"};
final String cDDGeneratedSineWaveModes[] = {"Wave", "Full Wave", "Sine Wave"};
final String cDDGeneratedAudioModes[] = {"Random", "Audio In"};

//========================================= Variables ==================================================

//Graphics buffers
PGraphics LayerContentGBufA, LayerContentGBufB, MixedContentGBuf; //final location of the mixed layers
PGraphics scratchGBuf; //used for generated content

PImage transmitPixelBuffer, feedPreviewImgA, feedPreviewImgB;

PImage img, scratchImg; // Image to receive a texture and scratch
PImage imgSliderBarHoriz, imgMixerHandleHoriz,imgMixerHandleVert, imgSliderBarVert, imgColorSelector;

//GUI element variables
boolean GlobalDDOpen = false;
boolean GlobalDragging = false;
boolean TextFieldActive = false;
boolean NumberInputFieldActive = false;

int OverlayMenuID = 0;

String GlobalLabelStore = "";  //used for text fields

int pressHoldTimer = 0;
int pressHoldRollingTimer = 500;
boolean allowMousePressHold = false;

//GUI variables
int mouseXS, mouseYS; //scaled mouse values for resizing, must be updated before use. Do not use native mouseX or mouseY
float SF = 1; //scale factor

boolean mixFeeds = false;
int holdMillisDraw = millis();
int OutputFrameRateMs = 0;


int displayPixSize = 10; //start at default, recalculated to new size when patch file is loaded
int displayOffsetX = 0;
int displayOffsetY = 0;

int PrevHeight = 0;  //used to monitor if the grid window's size is changed
int PrevWidth = 0;

//Software variables
float CrossFaderValue = 0.5;
float MasterIntensity = 0.25;
float FeedIntensityA = 1;
float FeedIntensityB = 1;
int MainBlendMode = 0;

int FeedPlayModeA = 0; //0 = play, 1 = pause
int FeedPlayModeB = 0; //0 = play, 1 = pause

int DefinedMediaTiles = 0; //keeps track of how many mediaContentTiles are populated with content
int workingTileID = 0;
int holdLayerID = 0;

int SelectLayerID = 0;
int SelectFeedID = 0;

short[] PatchCoordX = new short[1];
short[] PatchCoordY = new short[1];


//System Variables
boolean PrintDebugMessages = false;
boolean AudioInputEnabled = false;

String SelectedFilePath = ""; //holds file paths

//Data Transmission Variables
boolean PacketReadyForTransmit = false;
byte[] TransmissionArray = new byte[1]; //packs the data to be sent out into here, it sends it faster if they are bytes

String RecorderFileName = "";
int FileRecorderFormat = 0; //USER MUST CHANGE THIS, fill find a GUI method later: 0 = NLED String format, 1 = raw byte format

//Globals for the external data protocol - such as glediator
short[] ExternalDataArray = new short[1]; 
int ExternalDataCounter = 0;
int ExternalDataHoldMillis = 0;
int ExternalDataMillis = 0;
boolean ExternalDataFramed = false;

int[] FilePlayDataBuffer = new int[1]; 
String[] FilePlayStrLines;
int FilePlayDataCount = 0;


String ArtNetIPDefault = "127.0.0.1"; //used as the default, in case an IP address was not properly listed in matrix-output.ini

//=================================================================================================================================

//DECLARE A SPOUT OBJECT
Spout[] spoutReciever;
Spout spoutSenderMixed, spoutSenderA, spoutSenderB;

ArtNetClient artnetServer;

Serial serialPort, externalSerialPort;  

BufferedWriter bw = null;
FileWriter fw;

Movie[] movieFile; //for sure used an extra 50MB by defining this. went from ~150MB to 200MB
//tried defining in object, but no dice. Could do a IDs and only define as they are created.
// think it is acceptable, although it did use more memory as more videos were added

AudioInput AudioIn; //used for LineIn
Minim minim;

GUIObj gui; //gui object, holds colors and such
MatrixObj matrix;
SoftwareObj software;

//Start GUI Element Objects ---------------------
//not actually pointers but 'refrences' similar usage in this circumstance
guiDropDown DropDownPointer;
//guiButton buttonPointer;
guiSliderBar SliderPointer;
guiTextField textFieldPtr;
guiNumberInputField numberInputFieldPtr;
guiColorSquare colorSquarePtr;
guiContentLayer contentLayerPtr;

mediaContentObj[]  mediaContentTile;

//One per side
guiContentLayer[] contentLayerA, contentLayerB;
guiButton[] feedLayersTileButtonsA, feedLayersTileButtonsB;
guiButton[] feedLayersEffectsButtonsA, feedLayersEffectsButtonsB;
guiButton[] feedLayersOptionsButtonsA, feedLayersOptionsButtonsB;
guiSliderBar[] feedLayersOpacitySliderA, feedLayersOpacitySliderB;
guiButton[] feedLayersPlayPauseA, feedLayersPlayPauseB;
guiNumberInputField[] feedLayersSpeedNIFA, feedLayersSpeedNIFB;

guiDropDown[] feedLayersBlendModeDDA, feedLayersBlendModeDDB;

guiSliderBar mainCrossFader, mainIntensityFader, intensitySliderA, intensitySliderB;

guiButton crossHardCutA, crossHardCutB, crossAutoA, crossAutoB;
guiButton feedPlayPauseA, feedPlayPauseB;
guiButton reloadConfigFilesButton, loadContentFileButton, saveContentFileButton, openMainMenuButton, recordToFileButton;

guiDropDown mainBlendModeDD, generatedMediaDD, effectsOptionsDD, imgScalingOptionsDD;

guiNumberInputField generatedMediaFPS;

guiButton[] playControlsA, playControlsB; //covers play/pause and stop buttons

guiSliderBar mediaContentScrollBar;
guiButton[] mediaTileSelectionButtons;
guiButton[] loadContentButtons;

OverlayMenu[] guiOverlayMenus;

guiColorSelector guiColorSelectorMenu;
guiNumberInputField menuColorSelNIFRed, menuColorSelNIFGreen, menuColorSelNIFBlue, menuColorSelNIFWhite, menuColorSelNIFAlpha;
guiSliderBar menuColorSelSliderRed, menuColorSelSliderGreen, menuColorSelSliderBlue, menuColorSelSliderWhite, menuColorSelSliderAlpha;

guiButton menuCloseButton, menuColorSelClose;

guiButton[] menuMediaTileMenuButtons;

guiNumberInputField effectsFilterInputField, effectContrastNIF;
guiColorSquare effectsTintColor;
guiNumberInputField effectMinColorNIFRed, effectMinColorNIFGreen, effectMinColorNIFBlue;
guiNumberInputField effectMaxColorNIFRed, effectMaxColorNIFGreen, effectMaxColorNIFBlue;
guiSliderBar effectMinColorSliderRed, effectMinColorSliderGreen, effectMinColorSliderBlue;
guiSliderBar effectMaxColorSliderRed, effectMaxColorSliderGreen, effectMaxColorSliderBlue;

guiNumberInputField contentOffsetX, contentOffsetY, mediaMenuGUICropW, mediaMenuGUICropH;

//Generated Content Classes
generatedText[] genContentText;
generatedStarField[] genContentStarField;
generatedFallingBlocks[] genContentFallingBlocks;
generatedMetaBalls[] genContentMetaBalls;
generatedRipples[] genContentRipples;
generatedSpiral[] genContentSpiral;
generatedSolidColor[] genContentSolidColor;
generatedPlasma[]  genContentPlasma;
generated2DShape[]  genContent2DShape;
generated3DShape[]  genContent3DShape;
generatedSineWave[]  genContentSineWave;
generatedBars[]  genContentBars;

generatedTemplate[] genContentTemplate;

//Generated Text GUI Elements
guiTextField genTextLabel;
guiNumberInputField genNIFTextXOffset, genNIFTextYOffset, genNIFTextSize;
guiDropDown genTextScrollTypeDD, genTextFontTypeDD;
guiColorSquare genTextColor, genTextBackgroundColor;

guiDropDown genStarsShapeDD;
guiNumberInputField genStarsSizeNIF, genStarsStrokeNIF, genStarsQuantityNIF, genStarsDecayNIF;
guiCheckBox genStarsZDistEnable;
guiColorSquare genStarsFillColor, genStarsStrokeColor;

guiDropDown genFallingBlocksDirection;
guiNumberInputField genFallingBlocksSize, genFallingBlocksDecay, genFallingBlocksFrequency;
guiColorSquare genFallingBlocksColor;

guiDropDown genMetaBallsColorMode;
guiNumberInputField genMetaBallsAmount, genMetaBallsSize, genMetaBallsFequency;
guiColorSquare genMetaBallsColor;

guiDropDown genRipplesShape, genRipplesAudioMode, genRipplesfillMethod;
guiNumberInputField genRipplesStrokeWidth, genRipplesAmplitude;
guiColorSquare genRipplesFillColor, genRipplesStrokeColor;

guiDropDown genSpiralColorMode;
guiNumberInputField genSpiralModeVariable, genSpiralCoils, genSpiralDecay;
guiColorSquare genSpiralColor;


guiColorSquare genSolidColorFill;

//no parameters for genPlasma

guiColorSquare gen2DShapeFillColor, gen2DShapeStrokeColor;
guiNumberInputField gen2DShapeStrokeWeight, gen2DShapeSize, gen2DShapeRotationSpeed, gen2DShapeZoomSpeed, gen2DShapeZoomMax, gen2DShapeZoomMin;
guiCheckBox gen2DShapeEnableSmoothing;


guiNumberInputField gen3DShapeSize, gen3DShapeRotationX, gen3DShapeRotationY, gen3DShapeStrokeWeight;
guiCheckBox gen3DShapeEnableSmoothing;
guiColorSquare gen3DShapeStrokeColor;

guiDropDown genSineWaveMode, genSineWaveAuidoMode;
guiNumberInputField genSineWaveYOffset, genSineWaveAmplitude, genSineWavePeriod, genSineWaveDecay;
guiColorSquare genSineWaveFillColor;

guiDropDown genBarsMode, genBarsAuidoMode;
guiNumberInputField genBarsWidth, genBarsSpacing, genBarsAmplitude, genBarsDecay;
guiColorSquare genBarsFillColor;

//example/template gui objects for generated content - no function
guiColorSquare genTemplateColor;
guiNumberInputField genTemplateStrokeWeight, genTemplateSize;
guiCheckBox genTemplateEnableSmoothing;

//================================== ArrayList for GUI MouseOver Elements ====================================================

//ArrayList<mediaContentObj> mediaContentObjList; //makes list to make it easier to mouseover
//mediaContentObj ContentTilePtr;

ArrayList<guiButton> ButtonList; //makes list to make it easier to mouseover
guiButton PointerButton;

ArrayList<guiTextField> TextFieldList;
guiTextField TextFieldListPointer;

ArrayList<guiCheckBox> CheckBoxList;
guiCheckBox CheckBoxListPointer;

ArrayList<guiDropDown> DropDownList; //makes list to make it easier to mouseover
//DropDown DropDownListPointer;
int DropDownMouseOverID = 0;

PFont font, generatedFont;

//========================= END OBJECT DECLARTION ==============================
//========================= START SETUP FUNCTION ==============================

void settings() 
{
  // Initial window size
  String[] workString = new String[5]; //used to divide the lines into tab
  String[] strLines = loadStrings("software.ini"); //divides the lines
  //software.ini now loaded
  workString = split(strLines[1], '\t'); //get GUIWIDTH value
  int tempW = int(workString[1]);
  workString = split(strLines[2], '\t'); //get GUIHEIGHT value
  size(tempW, int(workString[1]), P3D); //size window   
  //size(1366, 768, P3D); //P3D is required, but has some issues

  //PImage titlebaricon = loadImage("favicon.gif"); //doesn't work with P3D it seems
  //surface.setIcon(titlebaricon);
}


void setup() {
  //without this P3D renderer will draw all strokes last, so they overlay all other drawing
  hint(DISABLE_OPTIMIZED_STROKE); //Significantly slows down the GUI
  
  surface.setResizable(true);   // Needed for resizing the window to the sender size
  surface.setLocation(100, 100);
  surface.setTitle("NLED AllPixMatrix - Northern Lights Electronic Design, LLC");

  colorMode(RGB);
  frameRate(cGUIRefreshFPS); //set to any default, only affects the GUI, does not affect media or output rates

  
  font = createFont("Arial-BoldMT", 48);
  generatedFont = loadFont("Arial-BoldMT-48.vlw"); //for use with the text generated media, edit with your own if you want
  textFont(font);
  gui = new GUIObj(); //init graphic user interface from XML file or something

  software = new SoftwareObj(); //not doing anything yet - except enableMouseOver

  //---------------------- End Software Setup ---------------------------------------------
  
  //was not able to get patch changes working mid program, restart software if you need to change the patch file for now
  //have to resize all the image buffers (LayerContentGBufA, scratchImg etc) but that will cause crashes since it will be accessed by threads before fully updated

  matrix = new MatrixObj(); 
  LoadConfigurationFiles(); //Load all configuration files , patch files, and the rest - does not load media content files

  matrix.loadPatchFile();
  
  println("Matrix Object built, Width: "+matrix.width+"   Height: "+matrix.height);
  println("Using patch file: "+matrix.patchFileName);

  //---------------------- End Matrix and Patch Setup ---------------------------------------------

  try
  {
    //WONT WORK ON SOME SYSTEMS WITHOUT A MICROPHONE PLUGGED IN  
    minim = new Minim(this);
    // use the getLineIn method of the Minim object to get an AudioInput
    AudioIn = minim.getLineIn(Minim.MONO, cAudioBufferSize); //sets it to have 256 data points per update
    AudioIn.enableMonitoring();
    AudioIn.mute(); // disable this line to *hear* what is being monitored, in addition to 'seeing' it

    AudioInputEnabled = true; //used to poll incase of no audio input
  }
  catch(Exception e) {
    println("Unable to load audio line in");
  }

  // CREATE A NEW SPOUT OBJECT for Reception
  // Create a canvas or an image to receive the data.
  // Graphics and image objects can be created
  // at any size, but their dimensions are changed
  // to match the sender that the receiver connects to.
  spoutReciever = new Spout[cSoftwareMaxSpout];
  // for ( int i = 0; i < cSoftwareMaxSpout; i++) spoutReciever[i] = new Spout(this);

  movieFile = new Movie[cSoftwareMaxMediaTiles]; //not sure how else to do it, maybe assign IDs like with spout or generated content

  LayerContentGBufA =  createGraphics(matrix.width, matrix.height);
  LayerContentGBufB =  createGraphics(matrix.width, matrix.height);
  MixedContentGBuf =  createGraphics(matrix.width, matrix.height);

  scratchGBuf = createGraphics(matrix.width, matrix.height);
  scratchImg = createImage(matrix.width, matrix.height, ARGB);

  //--------------------------------------------- Init Images ---------------------------------------------

  imgMixerHandleHoriz = loadImage("mixerhandle-horiz.png");  
  imgSliderBarHoriz = loadImage("sliderbg-horiz.png");
  imgSliderBarVert = loadImage("sliderbg-vert.png");
  imgMixerHandleVert = loadImage("mixerhandle-vert.png");  
  
  //--------------------------------------------- Init ArrayList for objects ---------------------------------------------

  //mediaContentObjList = new ArrayList<mediaContentObj>();  
  ButtonList = new ArrayList<guiButton>();  
  DropDownList = new ArrayList<guiDropDown>();  
  TextFieldList = new ArrayList<guiTextField>();  
  CheckBoxList = new ArrayList<guiCheckBox>();  

  //--------------------------------------------- Init General Objects ---------------------------------------------



  //---------------------------------------------  Init GUI Element Objects  ---------------------------------------------

  mediaTileSelectionButtons = new guiButton[cSoftwareMaxViewedTiles]; //based on window width, since that affects bottom scroll area
  for (int i=0; i != mediaTileSelectionButtons.length; i++) mediaTileSelectionButtons[i] = new guiButton("+", 10+(i*90), 655, 80, 80, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, false); 

  //this creates some media conent tiles
  mediaContentTile  = new mediaContentObj[cSoftwareMaxMediaTiles];
  mediaContentTile[0] = new mediaContentObj("NULL", 0); //init null object, prevents nullpointer errors and offers an 'empty' source  content

  //--------------------------------------------- Define layer elements ---------------------------------------------

  feedLayersTileButtonsA = new guiButton[cSoftwareMaxLayers];
  feedLayersEffectsButtonsA = new guiButton[cSoftwareMaxLayers];
  feedLayersOptionsButtonsA = new guiButton[cSoftwareMaxLayers];
  feedLayersPlayPauseA = new guiButton[cSoftwareMaxLayers];
  feedLayersOpacitySliderA = new guiSliderBar[cSoftwareMaxLayers];
  feedLayersBlendModeDDA = new guiDropDown[cSoftwareMaxLayers];
  feedLayersSpeedNIFA = new guiNumberInputField[cSoftwareMaxLayers];

  contentLayerA = new guiContentLayer[cSoftwareMaxLayers];
  for (int i=0; i != contentLayerA.length; i++) contentLayerA[i] = new guiContentLayer(i, 0);

  feedLayersTileButtonsB = new guiButton[cSoftwareMaxLayers];
  feedLayersEffectsButtonsB = new guiButton[cSoftwareMaxLayers];
  feedLayersOptionsButtonsB = new guiButton[cSoftwareMaxLayers];
  feedLayersPlayPauseB = new guiButton[cSoftwareMaxLayers];
  feedLayersOpacitySliderB = new guiSliderBar[cSoftwareMaxLayers];
  feedLayersBlendModeDDB = new guiDropDown[cSoftwareMaxLayers];
  feedLayersSpeedNIFB = new guiNumberInputField[cSoftwareMaxLayers]; 

  contentLayerB = new guiContentLayer[cSoftwareMaxLayers];
  for (int i=0; i != contentLayerB.length; i++) contentLayerB[i] = new guiContentLayer(i, 1);

  //---------------------------------------- END LAYER Elements ---------------------------------------

  mainCrossFader = new guiSliderBar(543, 280, 250, 40, 0, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, false, false, true, "mainCrossFaderFunc"); 
  mainIntensityFader = new guiSliderBar(543, 380, 250, 20, 100, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, false, false, true, "mainIntensityFunc"); 
  mainIntensityFader.setValue(int(mainIntensityFader.max*MasterIntensity));
  intensitySliderA  = new guiSliderBar(340, 310, 25, 220, 0, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, true, true, true, "feedIntensityFuncA"); 
  intensitySliderB  = new guiSliderBar(1000, 310, 25, 220, 0, 0, 100, color(255), color(0), color(255, 0, 0), color(0), true, true, true, true, "feedIntensityFuncB"); 
  mediaContentScrollBar = new guiSliderBar(0, 740, 1366, 28, 0, 0, cSoftwareMaxMediaTiles, color(255), color(0), color(255, 0, 0), color(0), true, false, true, false, "mediaContentSliderFunc"); 

  crossHardCutA = new guiButton("A", 480, 280, 40, 40, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
  crossHardCutB = new guiButton("B", 815, 280, 40, 40, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
  crossAutoA = new guiButton("Auto A", 535, 340, 80, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
  crossAutoB = new guiButton("Auto B", 750, 340, 80, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);

  feedPlayPauseA = new guiButton("► ‖", 340, 270, 35, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true);
  feedPlayPauseB = new guiButton("► ‖", 990, 270, 35, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 

  mainBlendModeDD = new guiDropDown(cDDStrListBlendModes, 0, 628, 340, 110, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "mainBlendModeFunc");
  generatedMediaDD = new guiDropDown(cDDStrListGeneratedTypes, 0, 628, 340, 150, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedMediaDDFunc");
  effectsOptionsDD  = new guiDropDown(cDDStrListFilterModes, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "effectsOptionsDDFunc");
  imgScalingOptionsDD = new guiDropDown(cScaleOptionsDDStr, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "scaleOptionsDDFunc");

  contentOffsetX = new guiNumberInputField(0, 0, 25, 60, 0, 10000, 1, "mediaOffsetXFieldFunc");
  contentOffsetY = new guiNumberInputField(0, 0, 25, 60, 0, 10000, 1, "mediaOffsetYFieldFunc");
  mediaMenuGUICropW = new guiNumberInputField(0, 0, 25, 60, 1, 10000, 1, "mediaCropWFunc");
  mediaMenuGUICropH = new guiNumberInputField(0, 0, 25, 60, 1, 10000, 1, "mediaCropHFunc");

  effectsFilterInputField = new guiNumberInputField(0, 0, 30, 60, 0, 1, 3, "effectsFilterInputFieldFunc"); //floats 
  generatedMediaFPS = new guiNumberInputField(0, 0, 30, 60, 1, 600, 1, "generatedMediaFPSFunc"); //numbers

  openMainMenuButton = new guiButton("Open Menu", 890, 575, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
  recordToFileButton = new guiButton("Record to File", 890, 540, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true);
  
  reloadConfigFilesButton = new guiButton("Reload Configs", 0, 0, 120, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
  loadContentFileButton = new guiButton("Load File", 0, 0, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);
  saveContentFileButton  = new guiButton("Save File", 0, 0, 100, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true);

  effectContrastNIF  = new guiNumberInputField(0, 0, 30, 60, 0, 255, 1, "effectContrastFunc");

  effectsTintColor = new guiColorSquare(0, 0, 30, "effectsTintColor"); 

  effectMinColorNIFRed = new guiNumberInputField(0, 0, 25, 60, 0, 255, 1, "effectMinColorRFunc");
  effectMinColorNIFGreen = new guiNumberInputField(0, 0, 25, 60, 0, 255, 1, "effectMinColorGFunc");
  effectMinColorNIFBlue = new guiNumberInputField(0, 0, 25, 60, 0, 255, 1, "effectMinColorBFunc");
  effectMaxColorNIFRed = new guiNumberInputField(0, 0, 25, 60, 0, 255, 1, "effectMaxColorRFunc");
  effectMaxColorNIFGreen = new guiNumberInputField(0, 0, 25, 60, 0, 255, 1, "effectMaxColorGFunc");
  effectMaxColorNIFBlue = new guiNumberInputField(0, 0, 25, 60, 0, 255, 1, "effectMaxColorBFunc");

  effectMinColorSliderRed = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(255, 0, 0), color(0), true, false, false, false, "effectMinColorSliderRFunc"); 
  effectMinColorSliderGreen = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(0, 255, 0), color(0), true, false, false, false, "effectMinColorSliderGFunc"); 
  effectMinColorSliderBlue = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(0, 0, 255), color(0), true, false, false, false, "effectMinColorSliderBFunc"); 
  effectMaxColorSliderRed = new guiSliderBar(0, 740, 160, 20, 255, 0, 255, color(160), color(100), color(255, 0, 0), color(0), true, false, false, false, "effectMaxColorSliderRFunc"); 
  effectMaxColorSliderGreen = new guiSliderBar(0, 740, 160, 20, 255, 0, 255, color(160), color(100), color(0, 255, 0), color(0), true, false, false, false, "effectMaxColorSliderGFunc"); 
  effectMaxColorSliderBlue = new guiSliderBar(0, 740, 160, 20, 255, 0, 255, color(160), color(100), color(0, 0, 255), color(0), true, false, false, false, "effectMaxColorSliderBFunc"); 

  //---------------------------------------------  START OVERLAY MENUS ---------------------------------------

  guiOverlayMenus = new OverlayMenu[8];
  guiOverlayMenus[0] = new OverlayMenu(0, 0, 0, 0, 0); //null Menu
  guiOverlayMenus[1] = new OverlayMenu(cOverlayMediaTileMenu, 10, 40, 800, 600); //media content selection
  guiOverlayMenus[2] = new OverlayMenu(cOverlayEffectsMenu, 10, 40, 800, 550); //layer effects menu
  guiOverlayMenus[3] = new OverlayMenu(cOverlayMainMenu, 10, 40, 400, 500); //main menu

  //---------------------------------------------  START Color Selector MENU ---------------------------------------

  guiColorSelectorMenu = new guiColorSelector(400, 425);
  imgColorSelector = loadImage("colorpickerimg.png");

  menuColorSelClose = new guiButton("Close", 0, 0, 80, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true); //common to all/most menus 
  menuColorSelNIFRed = new guiNumberInputField(0, 0, 30, 60, 0, 255, 1, "colorSelectorValueRed"); //number only
  menuColorSelNIFGreen = new guiNumberInputField(0, 0, 30, 60, 0, 255, 1, "colorSelectorValueGreen"); //number only
  menuColorSelNIFBlue = new guiNumberInputField(0, 0, 30, 60, 0, 255, 1, "colorSelectorValueBlue"); //number only
  menuColorSelNIFWhite = new guiNumberInputField(0, 0, 30, 60, 0, 255, 1, "colorSelectorValueWhite"); //number only
  menuColorSelNIFWhite.status = 1; //grey out, not yet used for anything
  menuColorSelNIFAlpha = new guiNumberInputField(0, 0, 30, 60, 0, 255, 1, "colorSelectorValueAlpha"); //number only

  menuColorSelSliderRed = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(255, 0, 0), color(0), true, false, false, false, "colorSelectorSliderRed"); 
  menuColorSelSliderGreen = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(0, 255, 0), color(0), true, false, false, false, "colorSelectorSliderGreen"); 
  menuColorSelSliderBlue = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(0, 0, 255), color(0), true, false, false, false, "colorSelectorSliderBlue"); 
  menuColorSelSliderWhite = new guiSliderBar(0, 740, 160, 20, 0, 0, 255, color(160), color(100), color(255, 255, 255), color(0), true, false, false, false, "colorSelectorSliderWhite"); 
  menuColorSelSliderWhite.status = 1;  //grey out, not yet used for anything
  menuColorSelSliderAlpha = new guiSliderBar(0, 740, 160, 20, 255, 0, 255, color(160), color(100), color(0, 0, 0), color(0), true, false, false, false, "colorSelectorSliderAlpha"); 

  //---------------------------------------------  START OVERLAY MENU GUI ELEMENTS ---------------------------------------

  genTextLabel = new guiTextField("Your Text", 0, 050, 300, 25, gui.textFieldBG, gui.textFieldHighlight, 0, 1, 512, true, false, "generatedContentTextLabelFunc"); //any text
  genNIFTextSize = new guiNumberInputField(0, 0, 30, 60, 8, 1000, 1, "generatedContentTextSizeFunc"); //number only
  genNIFTextXOffset = new guiNumberInputField(0, 0, 30, 60, -1000, 1000, 1, "generatedContentTextXFunc"); //number only
  genNIFTextYOffset = new guiNumberInputField(0, 0, 30, 60, -1000, 1000, 1, "generatedContentTextYFunc"); //number only
  genNIFTextXOffset.setValue(0);
  genNIFTextYOffset.setValue(0);
  genTextScrollTypeDD = new guiDropDown(cDDStrListGeneratedScrollType, 0, 628, 340, 110, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentTextScrollType");
  genTextFontTypeDD = new guiDropDown(cDDStrListGeneratedFontType, 0, 628, 340, 110, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "genericDDCallBack");
  genTextColor = new guiColorSquare(0, 0, 30, "generatedContentTextColorFunc");
  genTextBackgroundColor = new guiColorSquare(0, 0, 30, "generatedContentTextBGColorFunc");


  genStarsShapeDD  = new guiDropDown(cDDStrListGeneratedShapes, 0, 628, 340, 110, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentStarsShapeFunc");
  genStarsStrokeNIF = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentStarsStrokeFunc"); //number only
  genStarsSizeNIF = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentStarsShapeFuncSizeFunc"); //number only
  genStarsQuantityNIF = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentStarsQuantityFunc"); //number only
  genStarsDecayNIF = new guiNumberInputField(0, 0, 30, 60, 0, 1, 3, "generatedContentStarsDecayFunc"); //float only
  genStarsZDistEnable = new guiCheckBox(0, 0, 25, color(255), color(0), color(0), false, "generatedContentStarsZDistFunc");
  genStarsFillColor = new guiColorSquare(0, 0, 30, "generatedContentStarsColorFunc");
  genStarsStrokeColor = new guiColorSquare(0, 0, 30, "generatedContentStarsStrokeColorFunc");


  genFallingBlocksDirection  = new guiDropDown(cDDGeneratedDirection, 0, 628, 340, 110, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentFallingBlocksDirectionFunc");
  genFallingBlocksSize = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentFallingBlocksSizeFunc"); //number only
  genFallingBlocksDecay = new guiNumberInputField(0, 0, 30, 60, 0, 1, 3, "generatedContentFallingBlocksDecayFunc"); //floats
  genFallingBlocksFrequency = new guiNumberInputField(0, 0, 30, 60, 0, 1000, 1, "generatedContentFallingBlocksFreqFunc"); //number only
  genFallingBlocksColor = new guiColorSquare(0, 0, 30, "generatedContentFallingColorFunc");


  genMetaBallsColorMode  = new guiDropDown(cDDGeneratedColorMode, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentMetaBallsColorModeFunc");
  genMetaBallsAmount  = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentMetaBallsAmountFunc"); //number only
  genMetaBallsSize = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentMetaBallsSizeFunc"); //number only
  genMetaBallsFequency = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentMetaBallsFrequencyFunc"); //number only
  genMetaBallsColor = new guiColorSquare(0, 0, 30, "generatedContentMetaBallsColorFunc");


  genRipplesShape = new guiDropDown(cDDGeneratedRippleShapes, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentRippleShape");
  genRipplesAudioMode = new guiDropDown(cDDGeneratedAudioModes, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentRipplAudioModeFunc");
  genRipplesAmplitude = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentRipplAmplitudeFunc"); //number only
  genRipplesfillMethod = new guiDropDown(cDDGeneratedRippleFillMethod, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentRippleFillMethod"); 
  genRipplesStrokeWidth = new guiNumberInputField(0, 0, 30, 60, 1, 100, 1, "generatedContentRippleStrokeWidth"); //number only
  genRipplesFillColor = new guiColorSquare(0, 0, 30, "generatedContentRippleFillColorFunc");
  genRipplesStrokeColor = new guiColorSquare(0, 0, 30, "generatedContentRippleStrokeColorFunc");


  genSpiralColorMode = new guiDropDown(cDDGeneratedSpiralColorMode, 0, 628, 340, 130, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentSpiralColorModeFunc");
  genSpiralModeVariable = new guiNumberInputField(0, 0, 30, 60, 0, 100, 1, "generatedContentSpiralModeVariableFunc"); //number only
  genSpiralCoils = new guiNumberInputField(0, 0, 30, 60, 1, 100, 1, "generatedContentSpiralCoilsFunc"); //number only
  genSpiralDecay = new guiNumberInputField(0, 0, 30, 60, 0, 1, 3, "generatedContentSpiralDecayFunc"); //float only
  genSpiralColor = new guiColorSquare(0, 0, 30, "generatedContentSpiralColorFunc");

  genSolidColorFill = new guiColorSquare(0, 0, 30, "generatedContentColorGenFunc");


  //plasma no parameters
  gen2DShapeFillColor = new guiColorSquare(0, 0, 30, "generatedContent2DShapeFillColorFunc");
  gen2DShapeStrokeColor = new guiColorSquare(0, 0, 30, "generatedContent2DShapeStrokeColorFunc");
  gen2DShapeStrokeWeight = new guiNumberInputField(0, 0, 30, 60, 0, 1000, 1, "generatedContent2DShapeStrokeWidthFunc"); //number only
  gen2DShapeSize = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContent2DShapeSizeFunc"); //number only
  gen2DShapeRotationSpeed = new guiNumberInputField(0, 0, 30, 60, -1000, 1000, 1, "generatedContent2DShapeRotSpeedFunc"); //number only
  gen2DShapeZoomSpeed = new guiNumberInputField(0, 0, 30, 60, 1, 100, 1, "generatedContent2DShapeZoomSpeedFunc"); //number only
  gen2DShapeZoomMax = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContent2DShapeZoomMaxFunc"); //number only
  gen2DShapeZoomMin = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContent2DShapeZoomMinFunc"); //number only
  gen2DShapeEnableSmoothing = new guiCheckBox(0, 0, 25, color(255), color(0), color(0), false, "generatedContent2DShapeSmoothingFunc"); 

  gen3DShapeSize = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContent3DShapeSizeFunc"); //number only
  gen3DShapeRotationX = new guiNumberInputField(0, 0, 30, 60, -1000, 1000, 1, "generatedContent3DShapeRotXFunc"); //number only
  gen3DShapeRotationY = new guiNumberInputField(0, 0, 30, 60, -1000, 1000, 1, "generatedContent3DShapeRotYFunc"); //number only
  gen3DShapeStrokeWeight = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContent3DShapeStrokeWidthFunc"); //number only
  gen3DShapeEnableSmoothing = new guiCheckBox(0, 0, 25, color(255), color(0), color(0), false, "generatedContent3DShapeSmoothingFunc"); 
  gen3DShapeStrokeColor = new guiColorSquare(0, 0, 30, "generatedContent3DShapeStrokeColorFunc");

  genSineWaveMode = new guiDropDown(cDDGeneratedSineWaveModes, 0, 628, 340, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentSineWaveModeFunc");
  genSineWaveAuidoMode = new guiDropDown(cDDGeneratedAudioModes, 0, 628, 340, 120, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentSineWaveAudioModeFunc");
  genSineWaveYOffset = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentSineWaveYOffsetFunc"); //number only
  genSineWaveAmplitude = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentSineWaveAmplitudeFunc"); //number only
  genSineWavePeriod = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentSineWavePeriodFunc"); //number only
  genSineWaveDecay = new guiNumberInputField(0, 0, 30, 60, 0, 1, 3, "generatedContentSineWaveDecayFunc"); //floats only
  genSineWaveFillColor = new guiColorSquare(0, 0, 30, "generatedContentSineWaveFillColorFunc");

  genBarsMode = new guiDropDown(cDDGeneratedBarsModes, 0, 628, 340, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentBarsModeFunc");
  genBarsAuidoMode = new guiDropDown(cDDGeneratedAudioModes, 0, 628, 340, 120, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, "generatedContentBarsAudioModeFunc");
  genBarsWidth = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentBarsWidthFunc"); //number only
  genBarsSpacing = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentBarsSpacingFunc"); //number only
  genBarsAmplitude = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentBarsAmplitudeFunc"); //number only
  genBarsDecay = new guiNumberInputField(0, 0, 30, 60, 0, 1, 3, "generatedContentBarsDecayFunc"); //floats only
  genBarsFillColor = new guiColorSquare(0, 0, 30, "generatedContentBarsFillColorFunc");

  //example objects, no current usage - make custom changes here
  genTemplateColor  = new guiColorSquare(0, 0, 30, "NONEYET");
  genTemplateStrokeWeight  = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentTemplateStrokeWidthFunc"); //number only
  genTemplateSize = new guiNumberInputField(0, 0, 30, 60, 1, 1000, 1, "generatedContentTemplateSizeFunc"); //number only
  genTemplateEnableSmoothing= new guiCheckBox(0, 0, 25, color(255), color(0), color(0), false, "generatedContentTemplateSmoothingFunc"); 

  //---------------------------------------------  START OVERLAY MENU GUI ELEMENTS   ---------------------------------------

  menuCloseButton  = new guiButton("Close", 0, 0, 80, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, false, false, true); //common to all/most menus 

  //0=NULL, 1=Video File(AVI, MOV, etc), 2=Animated GIF, 3=Static Image, 4=Syphon/Spout, 10=glediator data stream
  menuMediaTileMenuButtons = new guiButton[7];
  menuMediaTileMenuButtons[0] = new guiButton("Video File", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 
  menuMediaTileMenuButtons[1] = new guiButton("Animated GIF", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 
  menuMediaTileMenuButtons[2] = new guiButton("Image File", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 
  menuMediaTileMenuButtons[3] = new guiButton("Spout/Syphon", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 
  menuMediaTileMenuButtons[4] = new guiButton("Generated", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 
  menuMediaTileMenuButtons[5] = new guiButton("Data File", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 
  menuMediaTileMenuButtons[6] = new guiButton("External Data", 0, 0, 140, 25, gui.buttonColor, gui.buttonHighlightColor, gui.textColor, true, false, true); 

  //---------------------------------------------  FINAL OBJECT SETUP  ---------------------------------------

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

  numberInputFieldPtr = genNIFTextSize; ///set to something, anything

  //---------------------------------------------  SPOUT TRANSMITTER ---------------------------------------

  //Had to define this last, as if a loadMediaSource with spout ran before it, it would grab the first spout sender on the list,
  // sometimes it would be this spout sender. Then if tried to sendTexture() with a PGraphics it would error.
  //But would work with PImage that was defined with loadImage, but not one that was PGraphics.get()

  //Figured it out, if I sendTexture() a PGraphics and try to revceive it I get the EXCEPTION_ACCESS_VIOLATION
  //  if I never try to receive the transmission, it will work like from another app.
  // But it I can send and recvieve from the same app if no PGraphics or PImage is passed

  // CREATE A NAMED SENDER
  // A sender can be created now with any name.
  // Otherwise a sender is created the first time
  // "sendTexture" is called and the sketch
  // folder name is used.  
  /*
  spoutSenderMixed = new Spout(this);
   spoutSenderMixed.createSender("Spout-AllVidRec-Mixed");    
   
   spoutSenderA = new Spout(this);
   spoutSenderA.createSender("Spout-AllVidRec-A");   
   
   spoutSenderB = new Spout(this);
   spoutSenderB.createSender("Spout-AllVidRec-B");
   */

  //--------------------------------------------- Start DEBUG ---------------------------------------



  //--------------------------------------------- END DEBUG ---------------------------------------
  //--------------------------------------------- Final setup and file initliazation ---------------------------------------
  
  //It should load the media content file here, but creates dozens of java.lang.NullPointerException stemming from movie.read() in the event
  //	Doesn't stop the program or thread and recovers, but not sure how to prevent or fix it
  //One day it will load it from here, and 
  //LoadUserContentFile("/configs/"+software.configFilePath+"/"+matrix.contentFileName); //load content file
  OpenOverlayMenu(cOverlayMainMenu, 0); //will do this instead, user can load it at software startup
  //still will get a handuful of java.lang.NullPointerException errors, but can be ignored
  
  MainMixFunction(); //update right away to prevent errors

  println("Window scale is: "+SF);
  thread("OutputTransmissionThread"); //START TRANSMISSION THREAD
  thread("MainMixingThread"); //updates the media that is assigned to the layers
} //end setup()

//===============================================================================================================================


