class guiColorSelector
{
  //relies on being opened by a guiColorSquare object click. Not great but works for now.
  int xpos; 
  int ypos; 
  int mWidth;
  int mHeight;

  int red, green, blue, white, alpha;

  color selColor;

  boolean menuOpen;

  //--------------------------------------------------------------------------

  guiColorSelector(int iWidth, int iHeight)
  {
    mWidth = iWidth;
    mHeight = iHeight;
    menuOpen = false;
  }

  //--------------------------------------------------------------------------

  void display()
  {
    fill(gui.menuBackground);
    stroke(0); //black
    strokeWeight(4);

    rect(xpos, ypos, mWidth, mHeight, 20); //draw menu background

    fill(0);
    textSize(18);
    text("Choose a Color:", xpos+20, ypos+30);
    textSize(20);
    textAlign(RIGHT);
    textLeading(40);
    text("Red:\nGreen:\nBlue:\nWhite:\nAlpha:", xpos+70, ypos+70);
    textAlign(LEFT);
    image(imgColorSelector, xpos+10, ypos+250);

    menuColorSelClose.display();  
    menuColorSelNIFRed.display();
    menuColorSelNIFGreen.display();
    menuColorSelNIFBlue.display();
    menuColorSelNIFWhite.display();
    menuColorSelNIFAlpha.display();

    menuColorSelSliderRed.display();
    menuColorSelSliderGreen.display();
    menuColorSelSliderBlue.display();
    menuColorSelSliderWhite.display();
    menuColorSelSliderAlpha.display();
  } //end display()

  //--------------------------------------------------------------------------

  void closeMenu()
  {
    menuOpen = false;
    colorSquarePtr.selColor = color(red,green,blue,alpha);
    method(colorSquarePtr.callBack);
  }

  //--------------------------------------------------------------------------

  void initMenu(guiColorSquare passedSq, color passedColor)
  {
    menuOpen = true;
    colorSquarePtr = passedSq;
    
    xpos = mouseXS; 
    ypos = mouseYS;

    //make sure window does not open off-screen
    if((xpos+mWidth) > width) xpos = width-mWidth;
    if((ypos+mHeight) > height) ypos = height-mHeight;

    menuColorSelClose.xpos = (xpos+mWidth) - (menuColorSelClose.bWidth+20);
    menuColorSelClose.ypos = ypos+15; 

    menuColorSelNIFRed.xpos = xpos+250;
    menuColorSelNIFRed.ypos = ypos+50;
    menuColorSelNIFGreen.xpos = xpos+250;
    menuColorSelNIFGreen.ypos = ypos+90;
    menuColorSelNIFBlue.xpos = xpos+250;
    menuColorSelNIFBlue.ypos = ypos+130;
    menuColorSelNIFWhite.xpos = xpos+250;
    menuColorSelNIFWhite.ypos = ypos+170;
    menuColorSelNIFAlpha.xpos = xpos+250;
    menuColorSelNIFAlpha.ypos = ypos+210;

    menuColorSelSliderRed.xpos = xpos+80;
    menuColorSelSliderRed.ypos = ypos+55;
    menuColorSelSliderGreen.xpos = xpos+80; 
    menuColorSelSliderGreen.ypos = ypos+95;
    menuColorSelSliderBlue.xpos = xpos+80;
    menuColorSelSliderBlue.ypos = ypos+135;
    menuColorSelSliderWhite.xpos = xpos+80;
    menuColorSelSliderWhite.ypos = ypos+175;
    menuColorSelSliderAlpha.xpos = xpos+80;  
    menuColorSelSliderAlpha.ypos = ypos+215;

    //fill with passed cvolor
    red = (int)red(passedColor);
    green = (int)green(passedColor);
    blue = (int)blue(passedColor);
    //white is not used yet - just in case for future
    alpha = (int)alpha(passedColor);
    updateColorGUIElements();

    println("Color Selector Intialized");
  }
  
  //--------------------------------------------------------------------------

  void updateColorGUIElements()
  {
    menuColorSelSliderRed.setValue(guiColorSelectorMenu.red);
    menuColorSelNIFRed.setValue(guiColorSelectorMenu.red);
    menuColorSelSliderGreen.setValue(guiColorSelectorMenu.green);
    menuColorSelNIFGreen.setValue(guiColorSelectorMenu.green);
    menuColorSelSliderBlue.setValue(guiColorSelectorMenu.blue);
    menuColorSelNIFBlue.setValue(guiColorSelectorMenu.blue);
    menuColorSelSliderWhite.setValue(guiColorSelectorMenu.white);
    menuColorSelNIFWhite.setValue(guiColorSelectorMenu.white);
    menuColorSelSliderAlpha.setValue(guiColorSelectorMenu.alpha);
    menuColorSelNIFAlpha.setValue(guiColorSelectorMenu.alpha);
  }

  //--------------------------------------------------------------------------
  
  boolean over()
  {
    if (mouseXS >= xpos && mouseXS <= xpos+mWidth && mouseYS >= ypos && mouseYS <= ypos+mHeight) 
    {      
      return true;
    } else {
      return false;
    }
  }

  //--------------------------------------------------------------------------
  
  boolean overPicker()
  {
    if (mouseXS >= (xpos+10) && mouseXS <= (xpos+10)+imgColorSelector.width && mouseYS >= (ypos+250) && mouseYS <= (ypos+250)+imgColorSelector.height) 
    {      
      return true;
    } else {
      return false;
    }
  }
} //end class

//=====================================================================================================

class guiColorSquare
{
  int xpos; 
  int ypos; 
  int size;
  color selColor;
  int status; 
  boolean selected;

  String callBack;

  //--------------------------------------------------------------------------

  guiColorSquare(int ixpos, int iypos, int isize, String iCallBack)
  {
    xpos = ixpos;
    ypos = iypos;   
    size = isize;
    
    callBack = iCallBack;
    
    selColor = color(0, 0, 0, 0);
    status = 0;
    selected = false;
  }

  //--------------------------------------------------------------------------

  void display()
  {
    stroke(0); //black
    strokeWeight(5);
    fill(255); //fill white as transparency will see through the selected color
    rect(xpos, ypos, size, size);
    stroke(255); //white
    strokeWeight(2);      
    fill(selColor); //selected color
    rect(xpos, ypos, size, size);

    if (selected == true)
    {
      stroke(255, 0, 0); //red
      strokeWeight(3);
      fill(0, 0, 0, 0); //transparent fill
      rect(xpos-(size/8), ypos-(size/8), size+(size/4), size+(size/4));
      selected = false; //remove selected indicator for next display()
    }
  } //end display

  //--------------------------------------------------------------------------

  boolean over()
  {
    if (mouseXS >= xpos && mouseXS <= xpos+size && mouseYS >= ypos && mouseYS <= ypos+size && status == 0) 
    {      
      selected =! selected;  

      if (selected == true) 
      {
      guiColorSelectorMenu.initMenu(this, selColor);
      }
      
      return true;
    } else {
      return false;
    }
  }
} //end class

//=====================================================================================================

class guiNumberInputField
{
  int xpos; 
  int ypos; 
  int size;
  int fieldWidth;

  int minValue;
  int maxValue;

  int inputMethod; //0 = characters only, 1 = numbers only , 2 = numbers only with trailing %, 3 = floats

  String callBack;

  float value;
  String label;
  int status; //0=show, 1=grey out, 2=hide

  int action; //0 = enter, 1 = decrement, 2 = increment

  int selected; //0 = no selection, 1 = decrement, 2 = textfield, 3 = increment
  boolean MouseOverFlag;

  color colTxtBG;
  color colTxtHL;
  color colTxtStroke;
  color colButtonBG;
  color colButtonStroke;

  guiNumberInputField(int ixpos, int iypos, int isize, int ifieldWidth, int iminValue, int imaxValue, int iinputMethod, String icallBack)
  {
    xpos = ixpos;
    ypos = iypos;   
    size = isize;
    fieldWidth = ifieldWidth;
    minValue = iminValue;
    maxValue = imaxValue;
    inputMethod = iinputMethod;
    callBack = icallBack;

    selected = 0;
    MouseOverFlag = false;

    value = minValue;
    label = ""+value;

    colTxtBG = gui.textFieldBG;
    colTxtHL = gui.textFieldHighlight;
    colTxtStroke = gui.buttonColor;

    colButtonBG = gui.buttonColor;
    colButtonStroke = gui.textColor;
  } //end constructor

  //--------------------------------------------------------------------------

  void setValue(float passedVal)
  {
    value = passedVal;

    if (inputMethod == 1) label = ""+int(value); 
    else label = ""+value;
  }

  //--------------------------------------------------------------------------

  void handleStatus()
  {
    noStroke();

    if (status == 1) //grey out
    {
      strokeWeight(2);
      stroke(cBackgroundColor, 200); //grey out button
      fill(cBackgroundColor, 200); //grey out button
      //    rect(xpos, ypos, fieldWidth+(size/2)+(size*2), size);  

      rect(xpos+size+(size/4), ypos, fieldWidth, size);
      rect(xpos, ypos, size, size, size/4);  //rounded corners
      rect(xpos+(size*1.5)+fieldWidth, ypos, size, size, size/4);  

      noStroke();
    }
  }

  //--------------------------------------------------------------------------

  void selectField()
  {
    try {
      deselectTextField(); //handle deselecting previous field if applicable
    }
    catch(Exception e) {
    }

    numberInputFieldPtr = this;
    GlobalLabelStore = label;
    label = "";
    NumberInputFieldActive = true;
  }


  //--------------------------------------------------------------------------

  void display()
  {
    if (status == 2) return; //element is hidden, do not draw
    //   pushStyle();

    strokeWeight(1);
    stroke(colTxtStroke);

    /*
    if (selected == true) 
     {  
     fill(colHL);
     
     if (status == 0 && MouseOverFlag == true) 
     {
     fill(colHL, 128);
     }
     } else  
     {  
     fill(colBG);
     
     if (status == 0 && MouseOverFlag == true) 
     {
     fill(colBG, 64);
     }
     }
     */

    strokeWeight(2);
    fill(colTxtBG);

    if (selected == 3)
    {
      stroke(colTxtHL);
    } else       
    {
      stroke(gui.buttonColor);
      if (status == 0 && MouseOverFlag == true) 
      {
        stroke(colTxtHL, 128);
        fill(colTxtBG, 192);
      }
    }
    rect(xpos+size+(size/4), ypos, fieldWidth, size);

    //adjust stroke to on higligh and invert text color
    noStroke();
    fill(0);
    textSize((size/1.5));
    textAlign(CENTER);

    if (inputMethod == 0 || inputMethod == 3) text(label, xpos+(size*1.25), ypos+((size-(textAscent()+textDescent()))/1.5), fieldWidth, size);
    else if (inputMethod == 1) text(""+label, xpos+(size*1.25), ypos+((size-(textAscent()+textDescent()))/1.5), fieldWidth, size); 
    else  if (inputMethod == 2)  text(int(label)+"%", xpos+(size*1.25), ypos+((size-(textAscent()+textDescent()))/1.5), fieldWidth, size);

    strokeWeight(1);
    stroke(colButtonStroke);


    if (selected == 1) fill(colTxtHL);
    else fill(colButtonBG);
    rect(xpos, ypos, size, size, size/4);  //rounded corners

    if (selected == 2) fill(colTxtHL);
    else fill(colButtonBG);
    rect(xpos+(size*1.5)+fieldWidth, ypos, size, size, size/4);  

    //adjust stroke to on higlight and invert text color
    fill(colButtonStroke);

    textSize((size/1.5));
    text("-", xpos+(size/2), ypos+(size/1.5));
    text("+", xpos+(size*2)+fieldWidth, ypos+(size/1.5));

    handleStatus();

    if (selected !=3) selected = 0; //buttons do not stay highlighted but text field does
    //   popStyle();
  }


  boolean over() 
  {
    if (status != 0) return false;

    //check decrement button    
    if (mouseXS >= xpos && mouseXS <= xpos+size && mouseYS >= ypos && mouseYS <= ypos+size)
    {     

      selectField();
      selected = 1; //decrement
      method(callBack);
      return true;
    } 

    //check decrement button    
    if (mouseXS >= xpos+(size*1.5)+fieldWidth && mouseXS <= xpos+(size*2.5)+fieldWidth && mouseYS >= ypos && mouseYS <= ypos+size)
    {     

      selectField();
      selected = 2; //increment
      method(callBack);
      return true;
    } 

    //check text field    
    if (mouseXS >= xpos+(size*1.25) && mouseXS <= xpos+(size*1.25)+fieldWidth && mouseYS >= ypos && mouseYS <= ypos+size)
    {     
      selectField();
      selected = 3; //text field
      return true;
    } 

    return false;
  } //end 0ver()
} //end class

//=====================================================================================================

class guiCheckBox
{
  int xpos; // rect xposition  
  int ypos; // rect yposition
  int size;
  color colBG;
  color colHL;
  color colOut;  
  boolean selected;
  int status = 0; //0=show, 1=grey out, 2=hide
  String callBack;

  boolean MouseOverFlag;

  guiCheckBox(int ixpos, int iypos, int isize, color iColBG, color iColHL, color iColOut, boolean iSelected, String icallBack)
  {
    xpos = ixpos;
    ypos = iypos;  
    size = isize;
    colBG = iColBG;
    colHL = iColHL;
    colOut = iColOut;
    selected = iSelected;
    callBack = icallBack;

    CheckBoxList.add(this);
    MouseOverFlag = false;
  }

  void display()
  {
    strokeWeight(1);
    stroke(colOut);
    fill(colBG);

    if (selected==true) 
    {  
      fill(colBG);

      if (status == 0 && MouseOverFlag == true) 
      {
        fill(colBG, 128);
      }
    } else  
    {  
      fill(colBG);

      if (status == 0 && MouseOverFlag == true) 
      {
        fill(colBG, 64);
      }
    }    
    rect(xpos, ypos, size, size);  


    if (selected==true)
    {
      line(xpos, ypos, xpos+size, ypos+size);
      line(xpos+size, ypos, xpos, ypos+size);
    }

    handleStatus();
  }//end display()


  void handleStatus()
  {
    noStroke();

    if (status == 1) 
    {
      strokeWeight(2);
      stroke(cBackgroundColor, 200); //grey out button
      fill(cBackgroundColor, 200); //grey out button
      rect(xpos, ypos, size, size);  
      noStroke();
    }
  }

  boolean over() 
  {
    if ( mouseXS >= xpos && mouseXS <= xpos+size && mouseYS >= ypos && mouseYS <= ypos+size && status == 0)
    {     
      selected =! selected;  
      method(callBack);
      return true;
    } else 
    {
      return false;
    }
  }


  boolean mouseOver() 
  {
    if ( mouseXS >= xpos && mouseXS <= xpos+size && mouseYS >= ypos && mouseYS <= ypos+size && status == 0)
    {     
      MouseOverFlag = true;  
      return true;
    } else {
      MouseOverFlag = false;
      return false;
    }
  }
}//end class

//======================================================================================

class guiDropDown
{
  //use one over() for detecting the button click and if it is open, then use a different over() with the full tab page size
  String[] labels;
  int numStrs;
  int selStr;
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int bWidth;
  int bHeight;
  color colBG;
  color colHL;
  color colOut;  
  boolean dirMode; //false = down, true = up
  String callBack;

  boolean selected;
  int status;

  boolean MouseOverFlag;

  //--------------------------------------------------------------------------

  guiDropDown(String[] iLabels, int iSelStr, int ixpos, int iypos, int ibWidth, int ibHeight, color iColBG, color iColHL, color iColOut, boolean iDirMode, String icallBack)
  {
    labels = iLabels; 
    numStrs = labels.length;
    selStr = iSelStr;
    xpos = ixpos;
    ypos = iypos;  
    bWidth = ibWidth;
    bHeight = ibHeight;
    colBG = iColBG;
    colHL = iColHL;
    colOut = iColOut;
    dirMode = iDirMode;
    callBack = icallBack;

    selected = false;
    status = 0; //normal display

    DropDownList.add(this);
  }

  //--------------------------------------------------------------------------

  int getValue()
  {
    return selStr;
  }

  //--------------------------------------------------------------------------

  void setValue(int passedVal)
  {
    if (passedVal < 0) selStr = 0; //set min
    else if (passedVal > numStrs) selStr = numStrs; //set max
    else selStr = passedVal; //else set to passed
  }

  //--------------------------------------------------------------------------

  void handleStatus()
  {
    noStroke();

    if (status == 1) 
    {
      strokeWeight(2);
      stroke(cBackgroundColor, 200); //grey out button
      fill(cBackgroundColor, 200); //grey out button
      rect(xpos, ypos, bWidth, bHeight);  
      noStroke();
    }
  }  

  //--------------------------------------------------------------------------

  void displayNormal()
  {
    strokeWeight(1);
    stroke(colOut);

    //    if (Selected==true) fill(ColHL);
    //    else fill(ColBG);

    if (selected==true) 
    {  
      fill(colHL);

      if (status == 0 && MouseOverFlag == true) 
      {
        fill(colHL, 128);
      }
    } else  
    {  
      fill(colBG);

      if (status == 0 && MouseOverFlag == true) 
      {
        fill(colBG, 64);
      }
    }

    rect(xpos, ypos, bWidth, bHeight);  
    //adjust stroke to on higlight and invert text color
    textAlign(LEFT);
    fill(colOut);
    textSize((bHeight/1.75));
    text(labels[selStr], xpos+(bWidth/20), ypos+((bHeight-(textAscent()+textDescent()))/1.5), bWidth, bHeight);

    fill(255);
    int tempSize = (bWidth/4);
    if (tempSize >  (bHeight/4)) tempSize = (bHeight);

    //   triangle(xpos+(bWidth-(bWidth/4)), ypos+(bHeight/4), xpos+(bWidth-(bWidth/4))+(bHeight/2), ypos+(bHeight/4), xpos+(bWidth-(bWidth/4))+(bHeight/4), ypos+(bHeight/4)+(bHeight/2));
    triangle(xpos+(bWidth-tempSize), ypos+(bHeight/4), xpos+(bWidth-tempSize)+(bHeight/2), ypos+(bHeight/4), xpos+(bWidth-tempSize)+(bHeight/4), ypos+(bHeight/4)+(bHeight/2));
    noStroke();
  }

  //--------------------------------------------------------------------------

  void selectDD()
  {
    selected =! selected;  //toggle selected state

    if (selected == true)
    {  
      DropDownPointer = this;
      GlobalDDOpen = true;
      DropDownMouseOverID = selStr;
    } else
    {
      GlobalDDOpen = false; //clear in case
    }
  }

  //--------------------------------------------------------------------------

  void display()
  {
    if (status == 2) return; //do not display if status = 2 = hide

    // pushStyle();

    if (selected == false)
    {
      displayNormal();
    } else
    {
      if (dirMode == false)  
      {  
        //down mode
        fill(colBG);
        displayNormal();
        strokeWeight(1);
        stroke(colOut);  

        for (int i = 0; i != numStrs; i++)
        {
          fill(colBG);
          rect(5+xpos, ypos+(bHeight*(i+1)), bWidth-5, bHeight);
          if (i == selStr) fill(colHL);
          else fill(colBG);
          //drop down drawn

          if (DropDownMouseOverID > 0 && DropDownMouseOverID == (i+1) && MouseOverFlag == true)
          {
            if (i == selStr) fill(colHL, 128);
            else fill(0, 0, 0, 64);//fill(ColBG,64);
          }

          rect(5+xpos, ypos+(bHeight*(i+1)), bWidth-5, bHeight);

          fill(colOut);
          textSize((bHeight/1.75));
          text(labels[i], 5+xpos+((bWidth - textWidth(labels[i]))/2), ypos+((bHeight-(textAscent()+textDescent()))/1.5)+(bHeight*(i+1)), bWidth, bHeight);
        }   //end for 
        noStroke();
      } else
      {            
        //Menu upwards
        displayNormal(); //display the button part
        strokeWeight(1);
        stroke(colOut);  

        for (int i = 0; i != numStrs; i++)
        {
          fill(colBG);
          rect(5+xpos, ypos+(bHeight*(i-numStrs)), bWidth-5, bHeight); //draw background first
          if (((numStrs-1)-i) == selStr) fill(colHL);
          else fill(colBG);
          //drop down drawn

          if (DropDownMouseOverID > 0 && DropDownMouseOverID == (i+1) && MouseOverFlag == true)
          {
            if (((numStrs-1)-i) == selStr) fill(colHL, 128);
            else fill(0, 0, 0, 64);//fill(ColBG,64);
          }
          rect(5+xpos, ypos+(bHeight*(i-numStrs)), bWidth-5, bHeight);
        } //end for

        for (int i = 0; i != numStrs; i++)
        {
          fill(colOut);
          textSize((bHeight/1.75));
          text(labels[i], 5+xpos+((bWidth - textWidth(labels[i]))/2), ypos+((bHeight-(textAscent()+textDescent()))/1.5)-(bHeight*(i+1)), bWidth, bHeight);
        }   //end for 
        noStroke();
      }
    }

    handleStatus();
    //   popStyle();
  } //end display()

  //--------------------------------------------------------------------------

  boolean overOpen()
  {
    if (dirMode == false)  
    {    
      //Down Mode
      if (selected == false)
      {
        return false;
      } else
      {
        for (int i = 0; i != numStrs; i++)
        {
          if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos+(bHeight*(i+1)) && mouseYS <= ypos+bHeight+(bHeight*(i+1)) && status == 0)
          {    
            selected = false;
            selStr = i;  
            GlobalDDOpen = false;        
            return true;
          }
        }
        selected = false;
        return false;
      }
    } else
    {  
      if (selected == false)
      {
        return false;
      } else
      {
        for (int i = 0; i != numStrs; i++)
        {
          if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos-(bHeight*(i+1)) && mouseYS <= ypos+bHeight-(bHeight*(i-1)) && status == 0)
          {    
            selected = false;
            selStr = i;  
            GlobalDDOpen = false;        
            return true;
          }
        }
        selected = false;
        return false;
      }
    }
  } //end overNew()

  //--------------------------------------------------------------------------

  boolean over() ///over the icon to open
  {
    if ( mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos && mouseYS <= ypos+bHeight  && status == 0) 
    {    
      if (GlobalDDOpen == true) return false; //if drop down already open, don't let it open another

      selectDD();
      return true;
    } else {
      return false;
    }
  }

  //--------------------------------------------------------------------------

  boolean mouseOver() ///over the icon to open
  {
    if ( mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos && mouseYS <= ypos+bHeight  && status == 0)   
    {      
      MouseOverFlag = true;  
      return true;
    } else {
      MouseOverFlag = false;
      return false;
    }
  }

  //--------------------------------------------------------------------------

  boolean mouseOverOpen()
  {
    if (dirMode == false)  
    {    
      //Down Mode
      if (selected == false)
      {
        return false;
      } else
      {
        for (int i = 0; i != numStrs; i++)
        {
          if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos+(bHeight*(i+1)) && mouseYS <= ypos+bHeight+(bHeight*(i+1)) && status == 0)
          {    
            MouseOverFlag = true;
            DropDownMouseOverID = i+1;        
            return true;
          }
        }
        DropDownMouseOverID = 0;
        MouseOverFlag = false;
        return false;
      }
    } else
    {  
      if (selected == false)
      {
        return false;
      } else
      {
        for (int i = 0; i != numStrs; i++)
        {
          if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos-(bHeight*(i+1)) && mouseYS <= ypos+bHeight-(bHeight*(i-1)) && status == 0)
          {    
            MouseOverFlag = true;
            DropDownMouseOverID = (numStrs-i);        
            return true;
          }
        }
        DropDownMouseOverID = 0;
        MouseOverFlag = false;
        return false;
      }
    }
  } //end overNew()
} //end dropdown class

//======================================================================================

class guiButton
{
  String Label;
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int bWidth;
  int bHeight;
  color colBG;
  color colHL;
  color colOut;  
  boolean toggle;
  boolean selected;
  int status; //0=show, 1=grey out, 2=hide

  boolean MouseOverFlag;

  //--------------------------------------------------------------------------

  guiButton(String iLabel, int ixpos, int iypos, int ibWidth, int ibHeight, color iColBG, color iColHL, color iColOut, boolean iToggle, boolean iSelected, boolean iAllowMouseOver)
  {
    Label = iLabel; 
    xpos = ixpos;
    ypos = iypos;  
    bWidth = ibWidth;
    bHeight = ibHeight;
    colBG = iColBG;
    colHL = iColHL;
    colOut = iColOut;
    toggle = iToggle;
    selected = iSelected;
    status = 0; //init at 0

    //Setup mouse over list
    if (iAllowMouseOver == true) ButtonList.add(this);
    MouseOverFlag = false;
  }

  //--------------------------------------------------------------------------

  void handleStatus()
  {
    noStroke();

    if (status == 1) 
    {
      strokeWeight(2);
      stroke(cBackgroundColor, 200); //grey out button
      fill(cBackgroundColor, 200); //grey out button
      rect(xpos, ypos, bWidth, bHeight);  
      noStroke();
    }
  }

  //--------------------------------------------------------------------------

  void displayOutline()
  {
    strokeWeight(3);
    stroke(colOut);

    fill(255, 255, 255, 0); //transparent fill
    rect(xpos, ypos, bWidth, bHeight, bHeight/4);
  }

  //--------------------------------------------------------------------------

  void display()
  {
    if (status == 2) return; //element is hidden, do not draw

    strokeWeight(1);
    stroke(colOut);

    if (selected==true) 
    {  
      fill(colHL);

      if (status == 0 && MouseOverFlag == true) 
      {
        fill(colHL, 128);
      }
    } else  
    {  
      fill(colBG);

      if (status == 0 && MouseOverFlag == true) 
      {
        fill(colBG, 64);
      }
    }

    textAlign(LEFT);
    rect(xpos, ypos, bWidth, bHeight, bHeight/4);  
    //adjust stroke to on higlight and invert text color
    fill(colOut);
    textSize((bHeight/1.75));
    text(Label, xpos+((bWidth - textWidth(Label))/2), ypos+((bHeight-(textAscent()+textDescent()))/1.5), bWidth, bHeight);

    handleStatus();

    if (toggle==false) selected = false;
  }

  //--------------------------------------------------------------------------

  boolean over() 
  {
    if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos && mouseYS <= ypos+bHeight && status == 0) 
    {      
      selected =! selected;  
      return true;
    } else {
      return false;
    }
  } //end over()

  //--------------------------------------------------------------------------

  boolean mouseOver() //does not toggle selected
  {
    if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos && mouseYS <= ypos+bHeight && status == 0) 
    {      
      MouseOverFlag = true;  
      return true;
    } else {
      MouseOverFlag = false;
      return false;
    }
  } //end over()
} //end class

//======================================================================================

class guiSliderBar
{
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int slWidth; // single bar slWidthth
  int slHeight; // rect height
  int value; 
  int min; 
  int max;
  color bgColor;
  color slHandleColor;
  color slSelectColor; 
  color slStrokeColor;
  boolean circleHandle;  //ture circle, false rectangle
  boolean HorizVertToggle;
  boolean ScrollBarToggle;
  boolean GraphicDisplay;

  String callBackStr;

  int status;

  //gotta move the int variables into float variables
  float temp1=slWidth;
  float temp2=max;
  float temp3=value;
  float temp4=min;
  float MathVar=0;
  
  //--------------------------------------------------------------------------

  guiSliderBar(int ixp, int iyp, int iw, int ih, int iValue, int iMin, int iMax, color iBgColor, color islHandleColor, color islSelectColor, color islStrokeColor, boolean iCircleHandle, boolean iHorizVertToggle, boolean iScrollBarToggle, boolean iGraphicDisplay, String imethodStr) 
  {   
    xpos = ixp;
    ypos = iyp;  
    slWidth = iw;
    slHeight = ih;
    value=iValue;
    max=iMax;
    min=iMin;
    bgColor=iBgColor;
    slHandleColor=islHandleColor;
    slSelectColor=islSelectColor;
    slStrokeColor=islStrokeColor;
    circleHandle=iCircleHandle;      //false is rectangle, true is circle
    HorizVertToggle=iHorizVertToggle; //false is horiz, true is vert
    ScrollBarToggle=iScrollBarToggle; //false is normal, true is scrollbar style
    GraphicDisplay = iGraphicDisplay;
    callBackStr =imethodStr;

    status = 0;  //0=show, 1=grey out, 2=hide
  }
  
  //--------------------------------------------------------------------------

  void setValue(int passedVal)
  {
    if (passedVal > max) { //check so it doesn't drag off the end
      passedVal = max;
    }
    if (passedVal < min) { //check so it doesn't drag off the end
      passedVal = min;
    }
    value = passedVal;
  }//end setValue() 

  //--------------------------------------------------------------------------

  short getUnsignedChar() //no byte sized data type, use short(16-bit, signed)
  {
    //returns 8 bit unsigned number 0 - 255, based on float 
    return (short)(255*getFloat());
  }

  //--------------------------------------------------------------------------

  float getFloat()
  {
    return ((float)value / (float)max);
  }
  
  //--------------------------------------------------------------------------

  short getValue()
  {
    if (value > max) { //check so it doesn't drag off the end
      value = max;
    }
    if (value < min) { //check so it doesn't drag off the end
      value = min;
    }  

    return (short)value;
  }
  
  //--------------------------------------------------------------------------

  void runCallBack()
  {
    move(mouseXS, mouseYS);
    try {
      method(callBackStr); //run function that is called everytime the slider is adjusted
    }
    catch(Exception e) { 
      println("Slider Method not found");
    }
  }

  //--------------------------------------------------------------------------

  void move(int uX, int uY) 
  {
    //uX = round((float)uX / SF);
    //uY = round((float)uY / SF);    
    if (ScrollBarToggle == true)
    {
      //scrollbar mode
      if (HorizVertToggle == false) //horizontal
      {
        //this function handles position of the slider's handle for Verticle
        temp1 = slWidth - (slHeight * 2);   
        temp3 = value;

        MathVar = ((((uX-xpos)-slHeight) / temp1)-1) *-1; //creates a scale factor based on mouse position 
        MathVar = max - (MathVar*(max-min));   

        if (MathVar > max) { //check so it doesn't drag off the end
          MathVar=max;
        }
        if (MathVar < min) { //check so it doesn't drag off the end
          MathVar=min;
        }    

        value=int(MathVar); //set the value based on mouse movement
      }//end if
      else
      {
        //this function handles position of the slider's handle for Verticle
        temp1 = slHeight - (slWidth * 2);   
        temp3 = value;

        MathVar = ((((uY-ypos)-slWidth) / temp1)-1) *-1; //creates a scale factor based on mouse position  
        MathVar = max - (MathVar*(max-min));   

        if (MathVar > max) { //check so it doesn't drag off the end
          MathVar=max;
        }
        if (MathVar < min) { //check so it doesn't drag off the end
          MathVar=min;
        }  
        value=int(MathVar); //set the value based on mouse movement
      }
    } 
    else
    {
      //regular usage
      if (HorizVertToggle == false) //horizontal
      {
        //this function handles position of the slider's handle
        temp1 = slWidth;   
        temp3 = value;
        temp4 = min;

        MathVar = (((uX-xpos) / temp1)-1) *-1; //creates a scale factor based on mouse position 
        //relative to slider position
        MathVar = max - (MathVar*(max-min));   

        if (MathVar > max) { //check so it doesn't drag off the end
          MathVar=max;
        }

        if (MathVar < min) { //check so it doesn't drag off the end
          MathVar=min;
        }  

        value = int(MathVar); //set the value based on mouse movement
      }//end if
      else
      {
        println("NO SLIDER MOVE() HANDLER");
      }
    }
  } //end move()
  
  //--------------------------------------------------------------------------


  void handleStatus()
  {
    noStroke();

    if (status == 1) 
    {
      strokeWeight(2);
      stroke(cBackgroundColor, 200); //grey out button
      fill(cBackgroundColor, 200); //grey out button
      rect(xpos, ypos, slWidth, slHeight);  
      noStroke();
    }
  }

  //--------------------------------------------------------------------------

  void display() 
  {   
    if (status == 2) return; //element is hidden, do not draw

    if (GraphicDisplay == true)
    {
      if (HorizVertToggle == false) //horizontal
      { 
        temp1 = slWidth-(slWidth/20);
        temp2 = max;  //move variables into float
        temp3 = value;    //or do they don't compute correctly
        temp4 = min;
        MathVar = temp1 / (temp2 - temp4) * (temp3-temp4); 

        image(imgSliderBarHoriz, xpos-(slWidth/20), ypos, slWidth+(slWidth/10), slHeight);    
        image(imgMixerHandleHoriz, (xpos+MathVar), ypos-(slHeight/4), imgMixerHandleHoriz.width, slHeight*1.5);  
        return; //if return is removed, the normal style of slider will overlay
      } 
      else
      {
        //HorizVertToggle = true, vertical
        temp1 = slHeight-(slHeight/20);
        temp2 = max;  //move variables into float
        temp3 = value;    //or do they don't compute correctly
        temp4 = min;
        MathVar = temp1 / (temp2 - temp4) * (temp3-temp4);         
        
         image(imgSliderBarVert, xpos, ypos-(slHeight/20), slWidth, slHeight+(slHeight/10)); 
         image(imgMixerHandleVert,xpos-(slWidth/4), (ypos+MathVar),  slWidth*1.5, imgMixerHandleVert.height);  
         return;
      }
    } 

    if (ScrollBarToggle == true)//ScrollBarToggle places buttons at either end, if false it has no end space
    {
      if (HorizVertToggle == false) //horizontal
      { 
        stroke(slStrokeColor);
        strokeWeight(1);

        //circle handles are displayed differently so there are if/else statements to set it correctly
        fill(bgColor); //covers up the old slider with a blank rectangle, BgColor set in declaration
        rect(xpos, ypos, slWidth, slHeight);   //main rect

        fill(200); 
        rect(xpos+(slHeight/10)+slHeight, ypos+(slHeight/10), slWidth-(slHeight/5)-(slHeight*2), (slHeight-(slHeight/5)));   //middle    
        rect(xpos+(slHeight/10), ypos+(slHeight/10), slHeight-(slHeight/5), slHeight-(slHeight/5)); //left rect  
        rect(xpos+(slHeight/10)+(slWidth-slHeight), ypos+(slHeight/10), slHeight-(slHeight/5), slHeight-(slHeight/5));  //right rect 

        stroke(slStrokeColor);
        fill(slHandleColor);
        strokeWeight(1);
        //top
        triangle(xpos+slHeight-(slHeight/5), ypos+(slHeight/5), xpos+slHeight-(slHeight/5), ypos+(slHeight-(slHeight/5)), xpos+(slHeight/5), ypos+(slHeight/2));  
        //right
        triangle(xpos+slWidth-slHeight+(slHeight/5), ypos+(slHeight/5), xpos+slWidth-slHeight+(slHeight/5), ypos+(slHeight-(slHeight/5)), xpos+slWidth-slHeight+slHeight-(slHeight/5), ypos+(slHeight/2));
        //Handle

        temp1 = (slWidth - (slHeight*3));
        temp2 = max;  //move variables into float
        temp3 = value;    //or do they don't compute correctly
        temp4 = min;      
        float MathVar;

        MathVar = temp1 / (temp2 - temp4) * (temp3-temp4) + slHeight/2+slHeight;

        fill(slHandleColor); //places the slider handle
        ellipse(xpos+MathVar, ypos+(slHeight/2), slHeight-2, slHeight-2); //Circle instead of rectangle
      } 
      else
      {
        //HorizVertToggle = true
        stroke(slStrokeColor);
        strokeWeight(1);

        //circle handles are displayed differently so there are if/else statements to set it correctly
        fill(bgColor); //covers up the old slider with a blank rectangle, BgColor set in declaration
     //   rect(xpos, ypos, slWidth, slHeight);  

        fill(200); 
    //    rect(xpos+(slWidth/10), ypos+(slWidth/10)+slWidth, slWidth-(slWidth/5), (slHeight-(slWidth/5))-(slWidth*2));   
    //    rect(xpos+(slWidth/10), ypos+(slWidth/10), slWidth-(slWidth/5), slWidth-(slWidth/5));   
    //    rect(xpos+(slWidth/10), ypos+(slWidth/10)+slHeight-slWidth, slWidth-(slWidth/5), slWidth-(slWidth/5));   

        stroke(slStrokeColor);
        fill(slHandleColor);
        strokeWeight(1);
        //top
        triangle(xpos+(slWidth/5), ypos+(slWidth/4)+(slWidth/2), xpos+(slWidth/2), ypos+(slWidth/5), (xpos+slWidth) - (slWidth/5), ypos+(slWidth/4)+(slWidth/2));
        //bottom
        triangle(xpos+(slWidth/5), ypos+(slWidth/4)+slHeight-slWidth, xpos+(slWidth/2), ypos+slHeight-(slWidth/5), (xpos+slWidth) - (slWidth/5), ypos+(slWidth/4)+slHeight-slWidth);

        temp1 = (slHeight - (slWidth*3));
        temp2 = max;  //move variables into float
        temp3 = value;    //or do they don't compute correctly
        temp4 = min;

        //println(temp1+" : "+temp2+" : "+temp3+" : "+temp4);

        //Handle
        float MathVar;
        MathVar = temp1 / (temp2 - temp4) * (temp3-temp4) + slWidth/2+slWidth;
        fill(slHandleColor); //places the slider handle
        ellipse(xpos+(slWidth/2), ypos+MathVar, slWidth-2, slWidth-2); //Circle instead of rectangle

        // rect(xpos, ypos+MathVar, slWidth, slWidth); //and comment this line for circle
        noStroke();
      }
    } 
    else
    {
      //not a graphic or a scroll bar, draw a normal scroll bar with circle or square handle
      stroke(slStrokeColor);
      strokeWeight(1);

      //circle handles are displayed differently so there are if/else statements to set it correctly
      fill(bgColor); //covers up the old slider with a blank rectangle, BgColor set in declaration
      rect(xpos, ypos, slWidth, slHeight);   

      if (circleHandle==true) temp1 = slWidth - slHeight;
      else temp1=slWidth-(slWidth/20);

      temp2=max;  //move variables into float
      temp3=value;    //or do they don't compute correctly
      temp4 = min;

      float MathVar;

      if (circleHandle==true)
        MathVar = temp1 / (temp2 - temp4) * (temp3-temp4) + slHeight/2;
      else  
      MathVar = temp1 / (temp2 - temp4) * (temp3-temp4); 

      fill(color(slSelectColor)); //draws the Selcolor over the selected area
      rect(xpos, ypos, MathVar, slHeight);

      fill(slHandleColor); //places the slider handle
      if (circleHandle==true)   ellipse(xpos+MathVar, ypos+(slHeight/2), slHeight-1, slHeight-1); //Circle instead of rectangle
      else   rect((xpos+MathVar), ypos, slWidth/20, slHeight); //and comment this line for circle
    }
    
    handleStatus();
  }//end display()
  
  //--------------------------------------------------------------------------
  
  void selectSlider()
  {
    SliderPointer = this;
    GlobalDragging = true;
  }//end selectSlider
  
  //--------------------------------------------------------------------------
  
  boolean over() 
  {
    if (mouseXS >= xpos && mouseXS <= xpos+slWidth && mouseYS >= ypos && mouseYS <= ypos+slHeight && status == 0) 
    {  
      selectSlider();
      return true;
    } else {
      return false;
    }
  }
} //end class

//=====================================================================================

class guiTextField
{
  String label;
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int bWidth;
  int bHeight;
  color colBG;
  color colHL;

  int inputMethod; //0 = characters only, 1 = numbers only , 2 = numbers only with trailing %, 3 = floats
  int minValue; //either min number, or minim characters
  int maxValue; //either max number, or maximum characters
  boolean toggle;
  boolean selected;
  String callBack;

  int status; //0=show, 1=grey out, 2=hide

  boolean MouseOverFlag;

  guiTextField(String iLabel, int ixpos, int iypos, int ibWidth, int ibHeight, color iColBG, color iColHL, int iInputMethod, int iminValue, int imaxValue, boolean iToggle, boolean iSelected, String itxtfCallback)
  {
    label = iLabel; 
    xpos = ixpos;
    ypos = iypos;  
    bWidth = ibWidth;
    bHeight = ibHeight;
    colBG = iColBG;
    colHL = iColHL;
    toggle = iToggle;
    selected = iSelected;
    inputMethod = iInputMethod;
    minValue = iminValue; 
    maxValue = imaxValue; 
    callBack = itxtfCallback;
    status = 0; //init at show

    //if(sEnableMouseOver == 1) 
    TextFieldList.add(this);
    MouseOverFlag = false;
  }

  void handleStatus()
  {
    noStroke();

    if (status == 1) 
    {
      strokeWeight(2);
      stroke(cBackgroundColor, 200); //grey out button
      fill(cBackgroundColor, 200); //grey out button
      rect(xpos, ypos, bWidth, bHeight);  
      noStroke();
    }
  }  

  void display()
  {
    if (status == 2) return; //element is hidden, do not draw

    //translate(0, 0);
    strokeWeight(2);
    fill(colBG);

    if (selected==true)
    {
      stroke(colHL);
    } else       
    {
      stroke(gui.buttonColor);
      if (status == 0 && MouseOverFlag == true) 
      {
        stroke(colHL, 128);
        fill(colBG, 192);
      }
    }
    rect(xpos, ypos, bWidth, bHeight);

    //adjust stroke to on higligh and invert text color
    noStroke();
    fill(0);
    textSize((bHeight/1.75));

    textAlign(LEFT);
    if (inputMethod != 2) text(label, xpos+((bWidth - textWidth(label))/2), ypos+((bHeight-(textAscent()+textDescent()))/1.5), bWidth, bHeight);
    else  text(label+"%", xpos+((bWidth - textWidth(label+1))/2), ypos+((bHeight-(textAscent()+textDescent()))/1.5), bWidth, bHeight);

    handleStatus();

    if (toggle==false) selected = false;
  }


  void selectField()
  {
    try {
      //textFieldPtr.selected = false; //was commented out
      deselectTextField(); //handle deselecting previous field if applicable
    }
    catch(Exception e) {
    }

    textFieldPtr = this;
    GlobalLabelStore = label;
    label = "";
    selected = true; 

    TextFieldActive = true;
  }


  boolean over() 
  {
    if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos && mouseYS <= ypos+bHeight && status == 0) 
    {     
      selected =! selected;   
      
      if(selected == true) selectField(); 
      return true;
    } else {
      return false;
    }
  }

  boolean mouseOver() //does not toggle selected
  {
    if (mouseXS >= xpos && mouseXS <= xpos+bWidth && mouseYS >= ypos && mouseYS <= ypos+bHeight && status == 0) 
    {     
      MouseOverFlag = true;    
      return true;
    } else {
      MouseOverFlag = false;
      return false;
    }
  } //end over()
} 

//============================================================================================
