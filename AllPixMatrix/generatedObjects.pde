
//To add generated content:
//Update loadSourceContent method switch and updateContent() method switch
//Declare and Define GUI elements
//Update overlaymenu initMenu() method to place and init the gui elements
//

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedTemplate()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentTemplate[i] == null)
      {
        genContentTemplate[i] = new generatedTemplate();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Template OBJECT");
  } //end catch

  println("createGeneratedTemplate() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedTemplate
{
  PGraphics localPGBuf;

  //parameters


  //local variables


  generatedTemplate()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB - used for generating content

    //local values

    //parameters

    //init code
  } //end declaration


  String saveParameters()
  {
    return "";
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[8];  
    WorkString = split(passedStr, ',');
  }

  void buildFrame()
  {

    localPGBuf.beginDraw();


    localPGBuf.endDraw();
  } //end buildFrame()
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedSineWave()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentSineWave[i] == null)
      {
        genContentSineWave[i] = new generatedSineWave();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED SineWave OBJECT");
  } //end catch

  println("createGeneratedSineWave() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedSineWave
{
  //A lot is taken from the processing example by Daniel Shiffman https://processing.org/examples/sinewave.html
  PGraphics localPGBuf;

  //parameters
  int mode; //0 = wave, 1 = full wave, 2 = sine wave
  int audioMode; //0 = random, 1 = audio
  int yOffset;
  int amplitude; //0 - 128 - multiplied to the get() value of -1 to 1
  int period;  // How many pixels before the wave repeat
  float decay;
  color fillColor;

  //local variables
  int xx;
  float dx;  // Value for incrementing X, a function of period
  float theta;  // Start angle at 0
  float[] yvalues;  // Using an array to store height values for the wave, has to be a float
  float thetaWork; //scratch

  generatedSineWave()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB - used for generating content

    //parameters
    mode = 0;
    audioMode = 0;   
    yOffset = 0;
    amplitude = 16;//was 16;
    period = 8;   
    decay = 0;//0.75; 
    fillColor = color(255, 255, 255, 255);

    //local values
    theta = 0.0; //clear

    //init code
    dx = (TWO_PI / period);
    yvalues = new float[matrix.width];
  } //end declaration


  String saveParameters()
  {
    return mode+cFileSep+audioMode+cFileSep+yOffset+cFileSep+amplitude+cFileSep+period+cFileSep+decay+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[10];  
    WorkString = split(passedStr, ',');
    
    mode = int(WorkString[0]);
    audioMode = int(WorkString[1]);
    yOffset = int(WorkString[2]);
    amplitude = int(WorkString[3]); 
    period = int(WorkString[4]);   
    decay = float(WorkString[5]);   
    fillColor = color(int(WorkString[6]), int(WorkString[7]), int(WorkString[8]), int(WorkString[9]));
  }

  void buildFrame()
  {
    localPGBuf.beginDraw();

    if (decay > 0) DecayBuffer(decay, localPGBuf); //run Decay Function
    else localPGBuf.background(0, 0, 0, 0);

    localPGBuf.noStroke();
    localPGBuf.fill(fillColor);

    if (mode == 0) //single dots for the wave
    {
      xx = cAudioBufferSize / matrix.width; //store for usage in loop

      for (int i = 0; i < matrix.width; i++)
      {  
        if (audioMode == 1 && AudioInputEnabled == true) localPGBuf.rect(i, (matrix.height/2)+round((AudioIn.left.get(i*xx)*amplitude))+yOffset, 1, 1);
        else  if (audioMode == 0) localPGBuf.rect(i, (matrix.height/2)+round((random(-1.0, 1.0)*amplitude))+yOffset, 1, 1);
      }
    } else if (mode == 1) //uses bars for the wave
    {
      xx = 0;
      for (int i = 0; i < cAudioBufferSize - 1; i=i+(cAudioBufferSize/matrix.width))
      {  

        if (audioMode == 1 && AudioInputEnabled == true)  localPGBuf.rect(xx, (matrix.height/2), 1, round(1+(AudioIn.left.get(i)*amplitude))+yOffset);
        else if (audioMode == 0)   localPGBuf.rect(xx, (matrix.height/2), 1, round(1+(random(-1.0, 1.0)*amplitude))+yOffset);

        xx++;
      }
    } else if (mode == 2)
    {
      // Increment theta (try different values for 'angular velocity' here
      theta += 0.5; //speed of wave scrolling - adjust FPS if your want slower or faster
      // For every x value, calculate a y value with sine function
      thetaWork = theta;

      for (int i = 0; i < yvalues.length; i++) {
        yvalues[i] = sin(thetaWork)*random(0, amplitude); //the random adds some variation
        // yvalues[i] = sin(thetaWork)*amplitude; /no variation
        thetaWork+=dx;

        //render wave
        //localPGBuf.noStroke();
        // localPGBuf.fill(fillColor);
        // A simple way to draw the wave with an ellipse at each location
        for (int x = 0; x < yvalues.length; x++) {
          localPGBuf.rect(x, matrix.height/2+yvalues[x]+yOffset, 1, 1); //why +2, no idea
        } //end for
      }//end for
    } //end elseif
    localPGBuf.endDraw();
  } //end buildFrame()
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedBars()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentBars[i] == null)
      {
        genContentBars[i] = new generatedBars();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Bars OBJECT");
  } //end catch

  println("createGeneratedBars() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedBars
{
  PGraphics localPGBuf;

  //parameters
  int mode; //0 = bottom bars, 1 = wave bars, 2 = mirror wave bars
  int audioMode;  //0 = random, 1 = audio
  int barWidth;
  int barSpacing;
  int barAmplitude;
  float decay;
  color fillColor;

  //local variables
  float[] AverageByte = new float[cAudioBufferSize]; //sine wave

  generatedBars()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB - used for generating content

    //local values

    //parameters
    mode = 0;
    audioMode = 0;    
    barWidth = 1; 
    barSpacing = 2; //can overlap bars by adjusting spacing
    barAmplitude = matrix.height;
    decay = 0;//0.75;
    fillColor  = color(255, 255, 255, 255); 

    //init code
  } //end declaration

  String saveParameters()
  {
    return mode+cFileSep+audioMode+cFileSep+barWidth+cFileSep+barSpacing+cFileSep+barAmplitude+cFileSep+decay+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[8];  
    WorkString = split(passedStr, ',');
    
    mode = int(WorkString[0]);
    audioMode = int(WorkString[1]);
    barWidth = int(WorkString[2]);
    barSpacing = int(WorkString[3]); 
    barAmplitude = int(WorkString[4]);   
    decay = float(WorkString[5]);   
    fillColor = color(int(WorkString[6]), int(WorkString[7]), int(WorkString[8]), int(WorkString[9])); 
  }

  void buildFrame()
  {
    localPGBuf.beginDraw();

    if (decay > 0) DecayBuffer(decay, localPGBuf); //run Decay Function
    else localPGBuf.background(0, 0, 0, 0);

    localPGBuf.noStroke();
    localPGBuf.fill(fillColor);    

    int xy = 0;
    for (int i = 0; i < cAudioBufferSize - 1; i=i+(cAudioBufferSize/matrix.width))
    {  
      if (audioMode == 1 && AudioInputEnabled == true) AverageByte[i] = ((AverageByte[i]) + AudioIn.left.get(i)) / 2; 
      else  if (audioMode == 0) AverageByte[i] = ((AverageByte[i]) + random(-1.0, 1.0)) / 2; 

      switch(mode)
      {
      case 0: //bottom bars
        localPGBuf.rect(0+(barSpacing*xy), matrix.height, barWidth, (AverageByte[i]*barAmplitude));     
        break;
      case 1: //bottom bars, full
        if (AverageByte[i] < 0) AverageByte[i] = AverageByte[i] * -1; //make positive only
        localPGBuf.rect(0+(barSpacing*xy), matrix.height, barWidth, -(AverageByte[i]*barAmplitude));       
        break;      
      case 2: //wave bars
        localPGBuf.rect(0+(barSpacing*xy), matrix.height/2, barWidth, (AverageByte[i]*barAmplitude));
        break;
      case 3: //mirror wave bars
        if (AverageByte[i] < 0) AverageByte[i] = AverageByte[i] * -1; //make positive only
        localPGBuf.rect(0+(barSpacing*xy), matrix.height/2, barWidth, -(AverageByte[i]*barAmplitude));
        localPGBuf.rect(0+(barSpacing*xy), matrix.height/2, barWidth, (AverageByte[i]*barAmplitude));      
        break;
      } //end switch
      xy++;
    } //end for()
    localPGBuf.endDraw();
  } //end buildFrame()
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedSolidColor()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentSolidColor[i] == null)
      {
        genContentSolidColor[i] = new generatedSolidColor();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED SolidColor OBJECT");
  } //end catch

  println("createGeneratedSolidColor() with "+i);
  return i;
}  //end func

//======================================================================================================

class generatedSolidColor
{
  PGraphics localPGBuf;

  //parameters
  color bgColor;

  //local variables
  generatedSolidColor()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height, P2D); //ARGB - used for generating content

    //local values

    //parameters
    bgColor = color(255, 128, 0);

    //init code
  } //end declaration

  String saveParameters()
  {
    return int(red(bgColor))+cFileSep+int(green(bgColor))+cFileSep+int(blue(bgColor))+cFileSep+int(alpha(bgColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[8];  
    WorkString = split(passedStr, ',');

    bgColor = color(int(WorkString[0]), int(WorkString[1]), int(WorkString[2]), int(WorkString[3]));
  }

  void buildFrame()
  {

    localPGBuf.beginDraw();
    localPGBuf.background(bgColor);
    localPGBuf.endDraw();
  } //end buildFrame()
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGenerated3DShape()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContent3DShape[i] == null)
      {
        genContent3DShape[i] = new generated3DShape();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED 3DShape OBJECT");
  } //end catch

  println("createGenerated3DShape() with "+i);
  return i;
}  //end func


//======================================================================================================

class generated3DShape
{
  PGraphics localPGBuf;

  //parameters
  int size;
  int strokeWeight; //1 or more
  int rotationValX; //start at 0
  int rotationValY; //start at 0
  boolean enableSmoothing; //true = enabled
  color strokeColor;


  //local variables
  int rotationX; //360 degrees
  int rotationY;  //360 degrees

  generated3DShape()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height, P3D); //ARGB - used for generating content

    //local values

    //parameters
    size = 8;
    rotationValX = 1;
    rotationValY = 0;
    strokeWeight = 1;
    strokeColor = color(255); //white default
    //init code
  } //end declaration

  String saveParameters()
  {
    return size+cFileSep+strokeWeight+cFileSep+rotationValX+cFileSep+rotationValY+cFileSep+enableSmoothing+cFileSep+
      int(red(strokeColor))+cFileSep+int(green(strokeColor))+cFileSep+int(blue(strokeColor))+cFileSep+int(alpha(strokeColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[12];  
    WorkString = split(passedStr, ',');

    size = int(WorkString[0]);
    strokeWeight = int(WorkString[1]);
    rotationValX = int(WorkString[2]);
    rotationValY = int(WorkString[3]); 
    enableSmoothing = boolean(WorkString[4]);     
    strokeColor = color(int(WorkString[5]), int(WorkString[6]), int(WorkString[7]), int(WorkString[8]));
  }

  void buildFrame()
  {
    if (enableSmoothing == true) localPGBuf.smooth(); //do before begin draw
    localPGBuf.noSmooth(); //do before begin draw

    localPGBuf.beginDraw();
    localPGBuf.background(0, 0, 0, 0);
    localPGBuf.translate(matrix.width/2, matrix.height/2, 0); 
    localPGBuf.rotateY(radians(rotationY));
    localPGBuf.rotateX(radians(rotationX));
    localPGBuf.noFill(); //no fill color for now, just outline/stroke
    localPGBuf.strokeWeight(strokeWeight);
    localPGBuf.stroke(strokeColor);
    localPGBuf.box(size);
    //localPGBuf.sphereDetail(10);
    //localPGBuf.sphere(size);

    //rotate the 3D Shape
    if (rotationY < (360-rotationValY)) rotationY+=rotationValY;
    else rotationY = 0;

    if (rotationX < (360-rotationValX)) rotationX+=rotationValX;
    else rotationX = 0;

    localPGBuf.endDraw();
  } //end buildFrame()
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGenerated2DShape()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContent2DShape[i] == null)
      {
        genContent2DShape[i] = new generated2DShape();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED 2DShape OBJECT");
  } //end catch

  println("createGenerated2DShape() with "+i);
  return i;
}  //end func


//======================================================================================================

class generated2DShape
{
  PGraphics localPGBuf;

  //parameters
  int strokeWeight; //0 to whatever
  int baseSize; //5 to whatever
  int rotationSpeed;
  int zoomSpeed;
  int zoomMax;
  int zoomMin;
  boolean enableSmoothing;
  color fillColor;
  color strokeColor;

  //local variables
  int currentRotation = 45; //rotation of the cube
  int scaleZ = 10; //Z position of the cube
  int zoomVal = 0;

  generated2DShape()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height, P2D); //ARGB - used for generating content

    //local values

    //parameters
    strokeWeight = 1;
    baseSize = 5;
    rotationSpeed = 10;
    zoomSpeed = 1;
    zoomMax = matrix.width*10;
    zoomMin = matrix.width*5;
    fillColor = color(255, 0, 0);
    strokeColor = color(0, 255, 0);  
    //init code
  } //end declaration


  String saveParameters()
  {
    return strokeWeight+cFileSep+baseSize+cFileSep+rotationSpeed+cFileSep+zoomSpeed+cFileSep+zoomMax+cFileSep+zoomMin+cFileSep+enableSmoothing+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor))+cFileSep+
      int(red(strokeColor))+cFileSep+int(green(strokeColor))+cFileSep+int(blue(strokeColor))+cFileSep+int(alpha(strokeColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    strokeWeight = int(WorkString[0]);
    baseSize = int(WorkString[1]);
    rotationSpeed = int(WorkString[2]);
    zoomSpeed = int(WorkString[3]); 
    zoomMax = int(WorkString[4]); 
    zoomMin = int(WorkString[5]);
    enableSmoothing = boolean(WorkString[6]);
    fillColor = color(int(WorkString[7]), int(WorkString[8]), int(WorkString[9]), int(WorkString[10]));        
    strokeColor = color(int(WorkString[11]), int(WorkString[12]), int(WorkString[13]), int(WorkString[14]));
  }

  void buildFrame()
  {
    if (enableSmoothing == true) localPGBuf.smooth(); //do before begin draw
    localPGBuf.noSmooth(); //do before begin draw

    localPGBuf.beginDraw();
    localPGBuf.background(0, 0, 0, 0);  

    localPGBuf.fill(fillColor);
    localPGBuf.stroke(strokeColor);
    localPGBuf.strokeWeight(strokeWeight);        


    localPGBuf.pushMatrix();
    localPGBuf.translate(matrix.width/2, matrix.height/2);
    localPGBuf.rotate(radians(currentRotation));
    localPGBuf.scale((float)scaleZ/100);

    localPGBuf.rectMode(CENTER);      //Mysteriously stopped working and would only do (CORNERS) so I calculate it below instead
    //  localPGBuf.rect(-(baseSize), -(baseSize), baseSize, baseSize);    //switch these two lines for the one below if it is fixed in future Processing Releases

    localPGBuf.rect(0, 0, baseSize, baseSize); //0,0 since it is already translated

    localPGBuf.popMatrix();

    //  if (ReverseFlag == true) TempRotation+=rotationSpeed;
    //    else 
    currentRotation+=rotationSpeed;

    //wraps rotation
    if (currentRotation >= 360) currentRotation = 0;
    else if (currentRotation < 0) currentRotation = 360 + currentRotation;

    if (scaleZ != zoomVal) 
    {
      if (zoomVal > scaleZ) scaleZ = scaleZ + zoomSpeed;
      else scaleZ = scaleZ -zoomSpeed;
    } else if (zoomVal >= scaleZ) 
    {
      zoomVal = int(random(zoomMin, zoomMax)); // not a great way
    } 
    localPGBuf.endDraw();
  } //end buildFrame()
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedPlasma()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentPlasma[i] == null)
      {
        genContentPlasma[i] = new generatedPlasma();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Plasma OBJECT");
  } //end catch

  println("createGeneratedPlasma() with "+i);
  return i;
}  //end func

//======================================================================================================

class generatedPlasma
{
  //doesn't work well on large matrices, also colors are not controllable. Would like to replace how this works.
  PGraphics localPGBuf;

  //parameters


  //local variables
  int[][] waves = new int[1000][3]; // sine waves
  int[] luma = new int[1024]; // brightness curve
  int[][][] pos = new int[3][2][3]; // positions RGB,XY,123
  float[][][] velocity = new float[3][2][3]; // velocity RGB,XY,123
  int[][][] wavesB = new int[300][3][2]; // pos,RGB,XY
  int ix;
  int iy;
  int iz;   
  int xOff;

  // int largestDimension;

  generatedPlasma()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height, P2D); //ARGB - used for generating content

    //parameters

    //local values
    /* OpenProcessing variation of *@*http://www.openprocessing.org/sketch/7035*@* */
    /* !do not delete the line above, required for linking your modification if you re-upload */
    // PLASMA - Will Birtchnel 2010

    // randomize positions
    for (ix=0; ix<3; ix++) {
      for (iy=0; iy<2; iy++) {
        for (iz=0; iz<3; iz++) {
          pos[iz][iy][ix]=int(random(512));
          velocity[iz][iy][ix]=random(-3, 3);
        }
      }
    }

    // make sine waves
    // largestDimension = max(matrix.width, matrix.height); //was just MatrixWidth, not sure if this is best

    for (ix=0; ix<100; ix++) {
      waves[ix][0]= (int)(100+ (sin(ix*TWO_PI/matrix.width)*100));
      waves[ix][1]= (int)(50+  (sin(ix*2*TWO_PI/matrix.width)*50));
      waves[ix][2]= (int)(25+  (sin(ix*3*TWO_PI/matrix.width)*25));
    }

    // make luma wave
    for (ix=0; ix<1024; ix++) {
      iy=ix;
      while ( (iy>255)||(iy<0)) {
        if (iy>255) iy=511-iy;
        if (iy<0) iy=abs(iy);
      }
      if (iy>201) iy=((iy*4)-(201*3));
      iy=(int)((iy*255)/((255*4)-(201*3)));
      luma[ix]=iy;
    }     

    //init code
  } //end declaration


  String saveParameters()
  {
    //none
    return "NONE";
  }

  void loadParameters(String passedStr)
  {
    //none
  }

  void buildFrame()
  {

    localPGBuf.beginDraw();
   // localPGBuf.colorMode(ARGB, 255); //required or wierd things happen

    // PLASMA - Will Birtchnel 2010
    //From http://www.openprocessing.org/sketch/7035
    // update velocity
    for (ix=0; ix<3; ix++) {
      for (iy=0; iy<2; iy++) {
        for (iz=0; iz<3; iz++) {
          velocity[iz][iy][ix]+=random(-0.1, 0.1); 
          if (velocity[iz][iy][ix]>(3-ix)) velocity[iz][iy][ix]=(3-ix);
          if (velocity[iz][iy][ix]<(-3+ix)) velocity[iz][iy][ix]=(-3+ix);
        }
      }
    } 
    // update positions
    for (ix=0; ix<3; ix++) {
      for (iy=0; iy<2; iy++) {
        for (iz=0; iz<3; iz++) {
          pos[iz][iy][ix]+=int(velocity[iz][iy][ix]); 
          if (pos[iz][iy][ix]>=matrix.width) pos[iz][iy][ix]-=matrix.width*2;
          if (pos[iz][iy][ix]<0) pos[iz][iy][ix]+=matrix.width*2;
        }
      }
    }   
    // make composite waves
    for (ix=0; ix<matrix.width; ix++) {  
      for (iy=0; iy<3; iy++) {
        for (iz=0; iz<2; iz++) {
          wavesB[ix][iy][iz]= waves[ix+pos[iy][iz][0]][0]  + waves[ix+pos[iy][iz][1]][1] + waves[ix+pos[iy][iz][2]][2];
        }
      }
    }

    //draw pixels
    localPGBuf.loadPixels();

    for (iy = 0; iy < matrix.height; iy++) 
    {
      xOff = iy*matrix.width;
      for (ix = 0; ix < matrix.width; ix++) 
      {       
        localPGBuf.pixels[xOff+ix]= ((luma[wavesB[ix][0][0]+wavesB[iy][0][1]]<<16)+(luma[wavesB[ix][1][0]+wavesB[iy][1][1]]<<8)+luma[wavesB[ix][2][0]+wavesB[iy][2][1]]) | 0xFF000000;
      }
    }   
    localPGBuf.updatePixels();

    localPGBuf.endDraw();
  }
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedSpiral()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentSpiral[i] == null)
      {
        genContentSpiral[i] = new generatedSpiral();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Spiral OBJECT");
  } //end catch

  println("createGeneratSpiral() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedSpiral
{
  PGraphics localPGBuf;

  //parameters
  int coils;
  float decay;// 0(no decay) to 1.0(no decay)
  int colorMode; //0 - 3
  int modeVariable; //0 - 4 ??
  color strokeColor;

  //local variables
  float rotation; //for spiral
  float hue; //for spiral coloring

  generatedSpiral()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB - used for generating content

    //local values

    //parameters
    coils = 1;
    decay = 0.5;
    colorMode = 0;
    modeVariable = 0;
    strokeColor = color(255, 255, 255, 255); //white

    //init code
    localPGBuf.beginDraw();
    localPGBuf.background(0, 0, 0, 0);
    localPGBuf.endDraw();
  }

  String saveParameters()
  {
    return coils+cFileSep+decay+cFileSep+colorMode+cFileSep+modeVariable+cFileSep+
      int(red(strokeColor))+cFileSep+int(green(strokeColor))+cFileSep+int(blue(strokeColor))+cFileSep+int(alpha(strokeColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[8];  
    WorkString = split(passedStr, ',');

    coils = int(WorkString[0]);
    decay = float(WorkString[1]);
    colorMode = int(WorkString[2]);
    modeVariable = int(WorkString[3]);
    strokeColor = color(int(WorkString[4]), int(WorkString[5]), int(WorkString[6]), int(WorkString[7]));
  }

  void buildFrame()
  {
    localPGBuf.beginDraw();
    localPGBuf.colorMode(HSB, 100);
    localPGBuf.rectMode(CORNER);       
    localPGBuf.noStroke();

    // Learning Processing - Daniel Shiffman
    // http://www.learningprocessing.com
    // Exercise 13-5: Using Example 13-5, draw a spiral path.   
    int chord = 1;  //spacing between LEDs
    float thetaMax = (coils * 2 * PI); //up to 10 coils
    float awayStep = 0; 

    if (decay > 0) DecayBuffer(decay, localPGBuf); //run Decay Function
    else localPGBuf.background(0, 0, 0, 0);

    awayStep = (max(matrix.width, matrix.height)/2) / thetaMax;

    for (float theta = chord / awayStep; theta <= thetaMax; ) 
    {
      float away = awayStep * theta;    // How far away from center
      float around = theta + rotation;    // How far around the center.
      // Convert 'around' and 'away' to X and Y.
      int xpos = (int)round((matrix.width/2) + cos( around ) * away);
      int ypos = (int)round((matrix.height/2) + sin( around ) * away);

      switch(colorMode) 
      {
      default:
      case 0: //Color Select
        localPGBuf.fill(strokeColor);
        break;
      case 1: //Color Cycle
        localPGBuf.fill(hue, 100, 100);  //use hue    
        break;
      case 2: //Rainbow
        hue+= modeVariable;
        if (hue>=100) {
          hue=hue-100;
        }    
        localPGBuf.fill(hue, 100, 100);  //use hue    
        break;
      } //end switch
      localPGBuf.rect(xpos, ypos, 1, 1); //use rect instead of point, was having issues with points
      theta += chord / away;
    }//end for()

    if (colorMode == 1)
    {
      hue+=modeVariable; //cycle through
      if (hue>=100) {
        hue=hue-100;
      }
    } else if (colorMode == 2)  hue = 0; //reset if in colormode offset

    rotation += 0.5; //rotate spiral
    //  if (ReverseFlag == true) rotation += 0.5; //rotate spiral
    //   else rotation -= 0.5; //rotate spiral

    localPGBuf.endDraw();
  }
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedRipples()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentRipples[i] == null)
      {
        genContentRipples[i] = new generatedRipples();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Ripples OBJECT");
  } //end catch

  println("createGeneratedRipples) with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedRipples
{
  PGraphics localPGBuf;

  //parameters
  int shape; //0 - circle, 1 - square, 2 - ??
  int audioMode; //0 = random, 1 = audio
  int amplitude;
  int fillMethod; //0- stroke only, 1- fill only, 2- fill and stroke  
  int strokeWeight;
  color fillColor;
  color strokeColor;

  //local variables
  float genCircleX1 = 0; //circle ripple generation
  float genCircleX2 = 0;
  float genCircleX3 = 0;

  generatedRipples()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height);

    //parameters
    audioMode = 0;
    strokeWeight = 1;
    amplitude = matrix.width; //set it to a good value
    fillMethod = 0;
    fillColor = color(0, 0, 0, 0);
    strokeColor = color(255);

    //local values
    genCircleX1 = 0.0;
    genCircleX2 = 0.45;
    genCircleX3 = 0.95;

    //init code
  }

  String saveParameters()
  {
    return shape+cFileSep+audioMode+cFileSep+amplitude+cFileSep+fillMethod+cFileSep+strokeWeight+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor))+cFileSep+
      int(red(strokeColor))+cFileSep+int(green(strokeColor))+cFileSep+int(blue(strokeColor))+cFileSep+int(alpha(strokeColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    shape = int(WorkString[0]);
    audioMode = int(WorkString[1]);
    amplitude = int(WorkString[2]);
    fillMethod = int(WorkString[3]);
    strokeWeight = int(WorkString[4]);
    fillColor = color(int(WorkString[5]), int(WorkString[6]), int(WorkString[7]), int(WorkString[8]));
    strokeColor = color(int(WorkString[9]), int(WorkString[10]), int(WorkString[11]), int(WorkString[12]));
  }

  void buildFrame()
  {
    localPGBuf.beginDraw();
    localPGBuf.background(0, 0, 0, 0);  //clear drawing area

    localPGBuf.rectMode(CENTER); //have to do it everytime, the init statement doesn't hold
    localPGBuf.ellipseMode(CENTER);   

    //0- stroke only, 1- fill only, 2- fill and stroke
    if (fillMethod == 0 || fillMethod == 2) 
    {
      localPGBuf.stroke(strokeColor);  
      localPGBuf.strokeWeight(strokeWeight);
    } 
    else localPGBuf.noStroke();

    if (fillMethod == 1 || fillMethod == 2) 
    {
      localPGBuf.fill(fillColor);
    } 
    else localPGBuf.noFill();


    if (audioMode == 0)
    {
      switch(shape)
      {
      case 0: //round
        localPGBuf.ellipse(round(matrix.width/2), round(matrix.height/2), amplitude*genCircleX1, amplitude*genCircleX1);      
        localPGBuf.ellipse(round(matrix.width/2), round(matrix.height/2), amplitude*genCircleX2, amplitude*genCircleX2);           
        localPGBuf.ellipse(round(matrix.width/2), round(matrix.height/2), amplitude*genCircleX3, amplitude*genCircleX3);
        break;
      case 1: //square
        localPGBuf.rect(round(matrix.width/2), round(matrix.height/2), amplitude*genCircleX1, amplitude*genCircleX1);      
        localPGBuf.rect(round(matrix.width/2), round(matrix.height/2), amplitude*genCircleX2, amplitude*genCircleX2);           
        localPGBuf.rect(round(matrix.width/2), round(matrix.height/2), amplitude*genCircleX3, amplitude*genCircleX3);
        break;
      }
    } 
    else
    {
      if(AudioInputEnabled == true)
      {
        //use audio input
        for (int i = 0; i < cAudioBufferSize - 1; i=i+(cAudioBufferSize/matrix.height))
        {  
          if(shape == 0)
          localPGBuf.ellipse(round(matrix.width/2), round(matrix.height/2), 1+(AudioIn.left.get(i)*amplitude), 1+(AudioIn.right.get(i)*amplitude));
          else
           localPGBuf.rect(round(matrix.width/2), round(matrix.height/2), 1+(AudioIn.left.get(i)*amplitude), 1+(AudioIn.right.get(i)*amplitude));
        }
      }
    }

    //  if (ReverseFlag == false)    
    //  {
    genCircleX1 +=0.05;
    genCircleX2 +=0.05;
    genCircleX3 +=0.05;

    if (genCircleX1 >= 1) genCircleX1 = 0;
    if (genCircleX2 >= 1) genCircleX2 = 0;
    if (genCircleX3 >= 1) genCircleX3 = 0;
    /*
     }
     else
     {
     genCircleX1 -=0.05;
     genCircleX2 -=0.05;
     genCircleX3 -=0.05;
     if (genCircleX1 <= 0) genCircleX1 = 1 + genCircleX1;
     if (genCircleX2 <= 0) genCircleX2 = 1 + genCircleX2;
     if (genCircleX3 <= 0) genCircleX3 = 1 + genCircleX3;
     */
    //  }


    localPGBuf.endDraw();
  }
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedMetaBalls()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentMetaBalls[i] == null)
      {
        genContentMetaBalls[i] = new generatedMetaBalls();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Meta Balls OBJECT");
  } //end catch

  println("createGeneratedMetaBalls() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedMetaBalls
{
  PGraphics localPGBuf;

  //parameters
  int colorMode; //keep this?
  int ballAmount;
  int ballSize;
  float colorFrequency;
  color fillColor;

  //local variables
  int TempMetalBalls; //metaballs temp
  Blob ballObj[] = new Blob[50];//metaballs

  generatedMetaBalls()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB - used for generating content


    //local values
    ballObj = new Blob[50];//metaballs
    TempMetalBalls = 0; //metaballs temp

    //initial parameters
    colorFrequency = 0.1;
    ballAmount = 20;
    ballSize = 20;
    colorMode = 0;
    fillColor = color(255, 255, 255, 255); //default white

    //init code
    for (int i=0; i < ballObj.length; i++) { //create blob objects
      ballObj[i] = new Blob(random(matrix.width), random(matrix.height), random(-1, 1), random(-1, 1));
    }
  }


  String saveParameters()
  {
    return colorMode+cFileSep+ballAmount+cFileSep+ballSize+cFileSep+colorFrequency+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    colorMode = int(WorkString[0]);
    ballAmount = int(WorkString[1]);
    ballSize = int(WorkString[2]);
    colorFrequency = float(WorkString[3]);
    fillColor = color(int(WorkString[4]), int(WorkString[5]), int(WorkString[6]), int(WorkString[7]));
  }


  void buildFrame()
  {
    localPGBuf.beginDraw();
    // localPGBuf.colorMode(ARGB, 255); //required or wierd things happen

    /* Taken from OpenProcessing.org and modified to suit    
    /* Modified OpenProcessing of *@*http://www.openprocessing.org/sketch/10275*@* */
    /* !do not delete the line above, required for linking your modificiations if you re-upload */
    /**
     * Rick Companje's version of the Metaball demo
     * Heavily insprired by Metaball Demo Effect by luis2048. 
     */

    TempMetalBalls++; //variable for the color cycling
    if (TempMetalBalls > 127) TempMetalBalls = 0;

    for (int q=0; q < ballAmount; q++) {
      ballObj[q].update();
    }


    //colorMode, 0 is color cycle, 1 is white, 2 is red, 3 green, 4 blue, 5 yellow, 6 purple, 7 turquoise,
    int red = 255;
    int green = 255;
    int blue = 255;


    //reduntant other than switching between color cycle and white since all the colors could be done with the color effects
    switch(colorMode)
    {
    case 0: //color cycle
      red = round(sin(colorFrequency*TempMetalBalls+ 0) * 255);
      green = round(sin(colorFrequency*TempMetalBalls + 2) * 255);
      blue = round(sin(colorFrequency*TempMetalBalls + 4) * 255);   
      break;
    case 1: //color select
      red = (int)red(fillColor);
      green = (int)green(fillColor);
      blue = (int)blue(fillColor);  
      break;
    }

    int m;
    int i;

    localPGBuf.loadPixels();    
    for (int y=0; y< matrix.height; y++) {
      for (int x=0; x< matrix.width; x++) {
        m = 1;
        for (i=0; i < ballAmount; i++) {
          // Increase this number to make your blobs bigger
          m += (ballSize*10)/(ballObj[i].bx[x] + ballObj[i].by[y] + 1);
        }
        localPGBuf.pixels[x+y*matrix.width] = color(round((((float)red/255)*(m-x))/2), round((((float)green/255)*(m-x))/2), round((((float)blue/255)*(m-x))/2));
      }
    }
    localPGBuf.updatePixels();

    localPGBuf.endDraw();
  }
} //end class


//Copied From:
/* Modified code from OpenProcessing of *@*http://www.openprocessing.org/sketch/10275*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/**
 * Rick Companje's version of the Metaball demo
 * Heavily insprired by Metaball Demo Effect by luis2048. 
 */

class Blob {
  float x, y;
  float vx, vy; 
  int[] bx, by;

  Blob(float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.bx = new int[matrix.width];
    this.by = new int[matrix.height];
  }

  void update() {
    x+=vx;
    y+=vy;

    if (x<0 || x>matrix.width) vx=-vx;
    if (y<0 || y>matrix.height) vy=-vy;

    for (int i=0; i<matrix.width; i++) bx[i] = int(sq(x-i));
    for (int i=0; i<matrix.height; i++) by[i] = int(sq(y-i));
  }
}

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedFallingBlocks()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentFallingBlocks[i] == null)
      {
        genContentFallingBlocks[i] = new generatedFallingBlocks();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED Falling Blocks OBJECT");
  } //end catch

  println("createGeneratedFallingBlocks() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedFallingBlocks
{
  PGraphics localPGBuf;

  //parameters
  int size;
  int frequency; //lower is faster
  float decay;
  int direction; //0- fall down, 1 - fall up, 2 - fall right, 3 - fall left
  color fillColor;
  //might be cool to be able to time change direction for zig-zags and such

  //local variables
  int[] fallingBlocksArray;
  int largestDimension;

  generatedFallingBlocks()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB - used for generating content

    //local values

    //initial parameters
    size = 1;
    frequency = 5;
    decay = 0.75;
    direction = 0;
    fillColor = color(255, 255, 255, 255); //default white

    //init code

    //do it this way or do it the right way of selecting width or height based on direction
    largestDimension = max(matrix.width, matrix.height);

    //randomly fill stating up to largestDimension
    fallingBlocksArray = new int[largestDimension];
    for (int i = 0; i != largestDimension; i++)   fallingBlocksArray[i] = (int)random(0, largestDimension*2);
  }

  String saveParameters()
  {
    return size+cFileSep+frequency+cFileSep+decay+cFileSep+direction+cFileSep+int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[8];  
    WorkString = split(passedStr, ',');

    size = int(WorkString[0]);
    frequency = int(WorkString[1]);
    decay = int(WorkString[2]);
    direction = int(WorkString[3]);
    fillColor = color(int(WorkString[4]), int(WorkString[5]), int(WorkString[6]), int(WorkString[7]));
  }

  void buildFrame()
  {
    localPGBuf.beginDraw();
    localPGBuf.rectMode(CORNER);       
    localPGBuf.noStroke();

    DecayBuffer(decay, localPGBuf); //do this here and not earlier apparently, maybe colorMode? not sure 

    localPGBuf.fill(fillColor);
    //could find a way to make the trails and the blocks different colors

    switch(direction)
    {
    case 0: //falling down
      for (int i = 0; i != matrix.width; i++) 
      {
        fallingBlocksArray[i]++;
        if (fallingBlocksArray[i] > matrix.height) fallingBlocksArray[i] =  (int)random(-frequency, -1);
        localPGBuf.rect(i, fallingBlocksArray[i], size, size);
      } //for()
      break;
    case 1: //falling up
      for (int i = 0; i != matrix.width; i++)   
      {
        fallingBlocksArray[i]--;
        if (fallingBlocksArray[i] < 0) fallingBlocksArray[i] =  (int)random(frequency+matrix.height, matrix.height+1);
        localPGBuf.rect(i, fallingBlocksArray[i], size, size);
      } //end for()
      break;
    case 2: //falling right
      for (int i = 0; i != matrix.height; i++) 
      {
        fallingBlocksArray[i]++;
        if (fallingBlocksArray[i] > matrix.width) fallingBlocksArray[i] =  (int)random(-frequency, -1);
        localPGBuf.rect(fallingBlocksArray[i], i, size, size);
      } //for()
      break;   
    case 3: //falling left
      for (int i = 0; i != matrix.height; i++) 
      {
        fallingBlocksArray[i]--;
        if (fallingBlocksArray[i] < 0) fallingBlocksArray[i] =  (int)random(frequency, matrix.width-1); //if off screen, re-randomize
        localPGBuf.rect(fallingBlocksArray[i], i, size, size);
      } //end for()
      break;
    } //end switch

    localPGBuf.endDraw();
    //println("finished");
  }
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedStarField()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentStarField[i] == null)
      {
        genContentStarField[i] = new generatedStarField();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED STAR FIELD OBJECT");
  } //end catch

  println("createGeneratedStarField() with "+i);
  return i;
}  //end func


//======================================================================================================

class generatedStarField
{
  PGraphics localPGBuf;

  //parameters
  int starShape;
  int starSize;
  int starQuantity;
  int starStrokeWidth;
  float decay;
  boolean starTwinkle; 
  color fillColor;
  color strokeColor;

  //local variables
  int reps; //starfield
  int instance; //starfield
  int refreshPoint; //starfield
  float [] ypos;
  float [] xpos;
  float twinkleValue;

  generatedStarField()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //ARGB

    //local values
    reps = 255; //starfield
    instance = 0; //starfield
    refreshPoint = 100; //starfield

    ypos = new float[reps]; //starfield
    xpos = new float[reps]; //starfield 

    //parameters

    starShape = 0;
    starQuantity = 200;
    starSize = 1;
    fillColor = color(255, 255, 255, 255); //default white
    starStrokeWidth = 0;
    starTwinkle = false;

    //randomize intial positions
    for (instance = 0; instance < reps; instance ++) 
    {
      xpos[instance] = int(random(-(matrix.width/2), (matrix.width/2)));
      ypos[instance] = int(random(-(matrix.height/2), (matrix.height/2)));
    }    //end for()
  }


  String saveParameters()
  {
    return starShape+cFileSep+starSize+cFileSep+starQuantity+cFileSep+starStrokeWidth+cFileSep+decay+cFileSep+starTwinkle+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor))+cFileSep+
      int(red(strokeColor))+cFileSep+int(green(strokeColor))+cFileSep+int(blue(strokeColor))+cFileSep+int(alpha(strokeColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    starShape = int(WorkString[0]);
    starSize = int(WorkString[1]);
    starQuantity = int(WorkString[2]);
    starStrokeWidth = int(WorkString[3]);
    decay = float(WorkString[4]);   
    starTwinkle = boolean(WorkString[5]);  
    fillColor = color(int(WorkString[6]), int(WorkString[7]), int(WorkString[8]), int(WorkString[9]));
    strokeColor = color(int(WorkString[10]), int(WorkString[11]), int(WorkString[12]), int(WorkString[13]));
  }

  void buildFrame()
  {
    //some defaults
    localPGBuf.beginDraw();
    // localPGBuf.colorMode(ARGB, 255); //required or wierd things happen - or rather does if it is enabled - still has alpha

    localPGBuf.rectMode(CORNER);  
    localPGBuf.ellipseMode(CENTER);     

    //localPGBuf.background(0, 0, 0, 0);
    DecayBuffer(decay, localPGBuf); //run Decay Function

    localPGBuf.stroke(strokeColor);

    if (starStrokeWidth > 0) localPGBuf.strokeWeight(starStrokeWidth);  //would like to control this as well but its not worth additional effort
    else localPGBuf.noStroke();

    twinkleValue = (255/starQuantity); //create float

    for (instance = 0; instance < starQuantity; instance ++) 
    {
      if (starTwinkle == true) localPGBuf.fill(fillColor, (twinkleValue*instance));
      else localPGBuf.fill(fillColor, 255); //fill white

      if (starShape == 0 || starShape == 1) localPGBuf.rect(int(xpos[instance])+(matrix.width/2), int(ypos[instance])+(matrix.height/2), starSize, starSize);
      else if (starShape == 2)  localPGBuf.ellipse(int(xpos[instance])+(matrix.width/2), int(ypos[instance])+(matrix.height/2), starSize, starSize);

      //now update position
      xpos[instance]= xpos[instance]+(xpos[instance]/100); //100 = speed of movement
      ypos[instance]= ypos[instance]+(ypos[instance]/100);

      if ((xpos[instance] < -matrix.width) || (xpos[instance] > matrix.width) || (ypos[instance] < -matrix.height) || ( ypos[instance] > matrix.height)) 
      {
        xpos[instance] = random(-refreshPoint, refreshPoint);
        ypos[instance] = random(-refreshPoint, refreshPoint);
      }
    } //end for 
    localPGBuf.endDraw();
  } //end func
} //end class

//======================================================================================================

//Scans the objects and creates a new one in a null slot
int createGeneratedText()
{
  int i = 0;

  try {
    for (i = 0; i < cMaxGeneratedObjects; i++)   
    {
      if (genContentText[i] == null)
      {
        genContentText[i] = new generatedText();
        break;
      }
    }
  }
  catch(Exception e)
  {
    println("NO OPEN SLOT FOUND FOR NEW GENERATED TEXT OBJECT");
  } //end catch

  println("createGeneratedText() with "+i);
  return i;
}  //end func

//======================================================================================================

class generatedText
{
  PGraphics localPGBuf;

  //parameters
  String textLabel;
  int textSize;
  int xOffset;
  int yOffset;
  int scrollingType;
  color fillColor;
  color bgColor;

  //local variables
  int scrollVal;

  generatedText()
  {
    localPGBuf = createGraphics(matrix.width, matrix.height); //Do not use P2D, that causes smoothing issues

    //parameters
    textLabel = "Your Text";
    textSize = 16; //set it in the number input field for now, or set to a static
    xOffset = yOffset = 0;
    scrollingType = 0; //Stationary
    fillColor = color(255);
    bgColor = color(1, 0, 0, 0); //start transparent - had to make one color a 1 or it wouldn't init transparent, had to reapply bg color

    //local variables
    scrollVal = 0;

    //init code
  }

  String saveParameters()
  {
    return textLabel+cFileSep+textSize+cFileSep+xOffset+cFileSep+yOffset+cFileSep+scrollingType+cFileSep+
      int(red(fillColor))+cFileSep+int(green(fillColor))+cFileSep+int(blue(fillColor))+cFileSep+int(alpha(fillColor))+cFileSep+
      int(red(bgColor))+cFileSep+int(green(bgColor))+cFileSep+int(blue(bgColor))+cFileSep+int(alpha(bgColor));
  }

  void loadParameters(String passedStr)
  {
    String[] WorkString = new String[16];  
    WorkString = split(passedStr, ',');

    textLabel = WorkString[0];
    textSize = int(WorkString[1]);
    xOffset = int(WorkString[2]);
    yOffset = int(WorkString[3]); 
    scrollingType = int(WorkString[4]);     
    fillColor = color(int(WorkString[5]), int(WorkString[6]), int(WorkString[7]), int(WorkString[8]));
    bgColor = color(int(WorkString[9]), int(WorkString[10]), int(WorkString[11]), int(WorkString[12]));
  }

  void buildFrame()
  {
    //localPGBuf.noSmooth();
    localPGBuf.beginDraw();
    localPGBuf.background(bgColor);
    localPGBuf.textAlign(LEFT, TOP);
    localPGBuf.textFont(generatedFont); //if not decalared, it uses a font that is sized for the initial value of genNIFTextSize, which makes it blurry
    localPGBuf.textSize(textSize);
    localPGBuf.fill(fillColor); //colors it white for now

    switch(scrollingType)
    {
    case 0: //stationary
      localPGBuf.text(textLabel, xOffset, yOffset);
      break;
    case 1: //left
      scrollVal++;
      if (scrollVal > (textWidth(textLabel))) scrollVal = -matrix.width;
      localPGBuf.text(textLabel, xOffset-scrollVal, yOffset);
      break;     
    case 2: //right
      scrollVal++;
      if (scrollVal > matrix.width) scrollVal = -int(textWidth(textLabel)+matrix.width);   
      localPGBuf.text(textLabel, xOffset+scrollVal, yOffset);
      break;      
    case 3: //up
      scrollVal++;
      if (scrollVal > (textSize+yOffset)) scrollVal = -matrix.height;   
      localPGBuf.text(textLabel, xOffset, yOffset-scrollVal);
      break; 
    case 4: //down
      scrollVal++;
      if (scrollVal > (matrix.height)) scrollVal = -textSize;   
      localPGBuf.text(textLabel, xOffset, yOffset+scrollVal);
      break;
    }

    localPGBuf.endDraw();
  }
} //end class

//======================================================================================================

void DecayBuffer(float passedValue, PGraphics buf)
{
  //println("DecayBuffer() with "+passedValue);
  //multi use function for decay/trail effect
  //really don't like how this works, but is fine for now - any ideas?

  color myColor;
  int myRed, myGreen, myBlue;

  if (passedValue == 1) return; //leave if no decay is too be applied

  buf.loadPixels();

  for (int i = 0; i != buf.pixels.length; i++) //decay/ fade out entire pixel[] array
  {
    myColor = buf.pixels[i];

    myRed = myColor >> 16 & 0xFF; //convert colors to 8-bit
    myGreen = myColor >> 8 & 0xFF;
    myBlue = myColor & 0xFF;

    //if almost black, just make it black and transparent
    if (floor(myRed*passedValue) < 2 && floor(myGreen*passedValue) < 2 && floor(myBlue*passedValue) < 2)  //buf.pixels[i] &= 0x00FFFFFF;
      buf.pixels[i] = color(0, 0, 0, 0);
    else  
    buf.pixels[i] = color(floor(myRed*passedValue), floor(myGreen*passedValue), floor(myBlue*passedValue), floor(255*passedValue));
  }
  buf.updatePixels();
}

//======================================================================================================

//in case it was a generated that was changed, this gets rid of the object and opens the slot
void DisposeGeneratedObjects()
{
  try {
    switch(sourceConentTile[workingTileID].generatedType)   //add additional generated types/objects here
    {
    case 0: //null

      break;
    case 1: //Text
      genContentText[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 2: //Star Field
      genContentStarField[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 3: //Falling Blocks
      genContentFallingBlocks[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 4: //"Meta Balls"
      genContentMetaBalls[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 5: //"Ripples"
      genContentRipples[sourceConentTile[workingTileID].instanceID] = null;
      break;       
    case 6: //"Spiral"
      genContentSpiral[sourceConentTile[workingTileID].instanceID] = null;
      break;    
    case 7: //"Solid Color"
      genContentSolidColor[sourceConentTile[workingTileID].instanceID] = null;
      break;        
    case 8: //"Plasma"
      genContentPlasma[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 9: //"2D Shape"
      genContent2DShape[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 10:  //"3D Shape"
      genContent3DShape[sourceConentTile[workingTileID].instanceID] = null;
      break;
    case 11:  //"Sine Wave"
      genContentSineWave[sourceConentTile[workingTileID].instanceID] = null;
      break;       
    case 12:  //"Dancing Bars"
      genContentBars[sourceConentTile[workingTileID].instanceID] = null;
      break;      
    case 13:  //"Template"    

      break;
    } //end switch
    println("Successfully disposed a generated object with ID: "+sourceConentTile[workingTileID].generatedType);
  }
  catch(Exception e) {
    println("Unable to dispose of previous generated object");
  }

  //might not yet be constructed
  try { 
    sourceConentTile[workingTileID].generatedType = 0;   //reset this so it calls the 0/"null" generated object, preventing calls to the null/non-existent object
  }
  catch(Exception e) {
  }
} //end func

//======================================================================================================
