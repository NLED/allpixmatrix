
//======================================================================================================================

void mousePressed() 
{
  mouseXS = round((float)mouseX / SF); //update scaled mouseX & Y, allows window resizing to work
  mouseYS = round((float)mouseY / SF);

  if (mouseButton == RIGHT) 
  {
    println("X: "+mouseX+"   Y: "+mouseY);

    //---------------------------------------------------------
    for (int i = 0; i != layerAtileButtons.length; i++)
    {
      if (layerAtileButtons[i].over())
      {
        println("Right clicked layer Tile Button A "+i);
        contentLayerA[i].contentIDNum = 0; //clear content from tile
        return;
      } //end over() if
    } //end for

    //---------------------------------------------------------
    for (int i = 0; i != layerBtileButtons.length; i++)
    {
      if (layerBtileButtons[i].over())
      {
        println("Right clicked layer Tile Button B "+i);
        contentLayerB[i].contentIDNum = 0; //clear content from tile
        return;
      } //end over() if
    } //end for 
    //---------------------------------------------------------

    SelectFeedID = 0; //else clear any layer selection if right click with no target
  } //end right click
  else     
  {
    //regular left click
    pressHoldTimer = millis(); //resets timer for mousePress button holding
    allowMousePressHold = true;

    //---------------------------------------------------------

    //If a drop down is open handle first, to prevent click-throughs to other elements
    if (GlobalDDOpen == true)   
    {
      //handle before anything
      if (DropDownPointer.overOpen())
      {
        println("Pressed Open DropDown "+DropDownPointer.getValue());
        method(DropDownPointer.callBack);
      } else
      {
        //else a click was detected that wasn't on the open drop down, close it and leave
        DropDownPointer.selected = false;  
        GlobalDDOpen = false;
      }
      return; //whether it was a click on the open drop down, or somewhere not on the drop down, leave now, no other clicks should be detected
    }
    //---------------------------------------------------------

    if ( mousePressLeftHandler()) return; //doesn't matter if it returns true or false

    //nothing detected a mouse press
    allowMousePressHold = false; //clear this

    //---------------------------------------------------------
  } //end left click else
} //end mousePressed

//======================================================================================================================

boolean mousePressLeftHandler() //this function is created so it can be called from places other than mousePressed() event
{
  //---------------------------------------------------------

  allowMousePressHold = false; //DEBUG - keep it for now

  //---------------------------------------------------------

  if (guiColorSelectorMenu.menuOpen == true)
  {
    if (menuColorSelSliderRed.over())  return true;

    if (menuColorSelSliderGreen.over()) return true;
    if (menuColorSelSliderBlue.over()) return true;
    if (menuColorSelSliderWhite.over()) return true;
    if (menuColorSelSliderAlpha.over()) return true;

    if (menuColorSelNIFRed.over())   return true;
    if (menuColorSelNIFGreen.over()) return true;
    if (menuColorSelNIFBlue.over())  return true;
    if (menuColorSelNIFWhite.over()) return true;
    if (menuColorSelNIFAlpha.over()) return true;

    if (menuColorSelClose.over())
    {
      guiColorSelectorMenu.closeMenu();
      return true;
    }

    deselectTextField(); //handle deselecting previous field if applicable();

    //check if selected from image
    if (guiColorSelectorMenu.overPicker())
    {
      println("Over Picker");
      loadPixels();

      color c = get(mouseXS, mouseYS);

      guiColorSelectorMenu.red = (int)red(c);
      guiColorSelectorMenu.green = (int)green(c);
      guiColorSelectorMenu.blue = (int)blue(c);
      //can't get white or alpha from color - manually enter
      guiColorSelectorMenu.updateColorGUIElements();
    }

    if (guiColorSelectorMenu.over() == false) guiColorSelectorMenu.closeMenu();

    return false;
  } else if (guiColorSelectorMenu.menuOpen == true && guiColorSelectorMenu.over() == false) return false;

  //---------------------------------------------------------

  if (OverlayMenuID > 0)
  {
    if (guiOverlayMenus[OverlayMenuID].mousePressed()) return true; //no need to check over()
    if (menuCloseButton.over())  CloseOverLayMenu(); //close the open menu
    deselectTextField(); //handle deselecting previous field if applicable();
    if (guiOverlayMenus[OverlayMenuID].forceOverride == 0) return false;
    return false;
  }

  //---------------------------------------------------------

  for (int i = 0; i != layerBblendModeDD.length; i++)
  {
    if (layerAblendModeDD[i].over())
    {
       contentLayerA[i].focusContentLayer(); 
      return true;
    }
  } //end for()

  //---------------------------------------------------------

  for (int i = 0; i != layerBblendModeDD.length; i++)
  {
    if (layerBblendModeDD[i].over()) 
    {
    contentLayerB[i].focusContentLayer();  
    return true;
  }
  } //end for()

  //---------------------------------------------------------

  for (int i = 0; i != layerAtileButtons.length; i++)
  {
    if (layerAtileButtons[i].over())
    {
      println("Over layer Tile Button A "+i);
      contentLayerA[i].selectContentLayer("A", i);
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != layerBtileButtons.length; i++)
  {
    if (layerBtileButtons[i].over())
    {
      println("Over layer Tile Button B "+i);
      contentLayerB[i].selectContentLayer("B", i);
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != layerAeffectButtons.length; i++)
  {
    if (layerAeffectButtons[i].over())
    {
      println("Over effects Button A "+i);
      contentLayerA[i].selectContentLayer("A", i);
      OpenOverlayMenu(cOverlayEffectsMenu, 0+i); //0 is for FeedA
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != layerBeffectButtons.length; i++)
  {
    if (layerBeffectButtons[i].over())
    {
      println("Over effects Button B "+i);
      contentLayerB[i].selectContentLayer("B", i);
      OpenOverlayMenu(cOverlayEffectsMenu, 100+i); //0 is for FeedA
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != layerAsourceOptionButtons.length; i++)
  {
    if (layerAsourceOptionButtons[i].over())
    {
      println("Over source option Button A "+i);
      contentLayerA[i].selectContentLayer("A", i);
      return true;
    } //end over() if
  } //end for


  //---------------------------------------------------------

  for (int i = 0; i != layerBsourceOptionButtons.length; i++)
  {
    if (layerBsourceOptionButtons[i].over())
    {
      println("Over source option Button B "+i);
      contentLayerB[i].selectContentLayer("B", i);
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != layerOpacitySlidersA.length; i++)
  {
    if (layerOpacitySlidersA[i].over()) 
    {
      contentLayerA[i].focusContentLayer(); 
      return true;
    }
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != layerOpacitySlidersB.length; i++)
  {
    if (layerOpacitySlidersB[i].over())  
    {
      contentLayerB[i].focusContentLayer(); 
      return true;
    }
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != feedLayersPlayPauseA.length; i++)
  {
    if (feedLayersPlayPauseA[i].over())
    {
      println("Over source play/pause - Feed A "+i);
      //action  
      if (feedLayersPlayPauseA[i].selected == true) sourceConentTile[contentLayerA[i].contentIDNum].setPlayMode(1); //pause
      else sourceConentTile[contentLayerA[i].contentIDNum].setPlayMode(0); //play     
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  for (int i = 0; i != feedLayersPlayPauseB.length; i++)
  {
    if (feedLayersPlayPauseB[i].over())
    {
      println("Over source play/pause - Feed B "+i);
      //action  
      if (feedLayersPlayPauseB[i].selected == true) sourceConentTile[contentLayerB[i].contentIDNum].setPlayMode(1); //pause
      else sourceConentTile[contentLayerB[i].contentIDNum].setPlayMode(0); //play
      return true;
    } //end over() if
  } //end for


  for (int i = 0; i != layerASpeedNIF.length; i++)
  {
    if (layerASpeedNIF[i].over()) 
    {
      contentLayerA[i].focusContentLayer(); 
      return true;
    }
  } //end for


  for (int i = 0; i != layerBSpeedNIF.length; i++)
  {
    if (layerBSpeedNIF[i].over()) 
    {
      contentLayerB[i].focusContentLayer(); 
      return true;
    }
  } //end for


  //------------------------ START COMMON ELEMENTS ---------------------------------

  for (int i = 0; i != contentSelectionButtons.length; i++)
  {
    if (contentSelectionButtons[i].over())
    {
      //  println("Over content selection Button "+i+" ScrollBar Offset: "+(sourceContentScrollBar.Value+i));
      if ((sourceContentScrollBar.value+i) == (DefinedContentSources))
      {
        //its a click on a tile one after the last one, indicating add source
        println("open content source menu. With "+(DefinedContentSources+1));
        OpenOverlayMenu(cOverlaySourceContent, DefinedContentSources+1);
      } else if ((sourceContentScrollBar.value+i) < DefinedContentSources)
      {
        println("Open menu to edit tile source content. Button "+i+" ScrollBar Offset: "+(sourceContentScrollBar.value+i));

        if (SelectFeedID > 0) 
        {
          FillContentLayer((sourceContentScrollBar.value+i+1));
          return true;
        }

        OpenOverlayMenu(cOverlaySourceContent, (sourceContentScrollBar.value+i+1));
      } else
      {
        println("Clicked content source button not available");
      }
      return true;
    } //end over() if
  } //end for

  //---------------------------------------------------------

  if (mainBlendModeDD.over()) return true;

  //---------------------------------------------------------

  if (crossHardCutA.over())
  {
    crossHardCutAcallBack();
    return true;
  }

  if (crossHardCutB.over())
  {
    crossHardCutBcallBack();
    return true;
  }

  if (crossAutoA.over())
  {
    //start timed cross fader fade
    return true;
  }

  if (crossAutoB.over())
  {
    //start timed cross fader fade
    return true;
  }
  
  //---------------------------------------------------------

  if (feedPlayPauseA.over())
  {
    //pause all Feed A layers
    println("Toggling Feed A play mode");
    if (feedPlayPauseA.selected == true) FeedPlayModeA = 1; //0 = play, 1 = pause
    else  FeedPlayModeA = 0; //0 = play, 1 = pause
  }

  if (feedPlayPauseB.over())
  {
    //pause all Feed B layers
    println("Toggling Feed B play mode");
    if (feedPlayPauseB.selected == true) FeedPlayModeB = 1; //0 = play, 1 = pause
    else  FeedPlayModeB = 0; //0 = play, 1 = pause
  }

  //---------------------------------------------------------

  if (recordToFileButton.over())
  {
    println("recordToFileButton()   Recording: "+recordToFileButton.selected);
    //toggling the .selected boolean is what starts/stops recording  

    if (recordToFileButton.selected == true)
    {
      //ensures it will always have a unique, easily traced file name
      //use any text editor to remove frames or combine multiple recorded files into a single file.
      RecorderFileName = "recorded-"+matrix.width+"x"+matrix.height+"-"+hour()+"-"+minute()+"-"+second()+"-date-"+day()+"-"+month()+"-"+year();
    }
  }

  //---------------------------------------------------------

  if (openMainMenuButton.over()) OpenOverlayMenu(cOverlayMainMenu, 0);

  //---------------------------------------------------------

  if (sourceContentScrollBar.over()) return true;

  //---------------------------------------------------------

  if (mainCrossFader.over()) return true;
  //---------------------------------------------------------

  if (mainIntensityFader.over()) return true;
  //---------------------------------------------------------

  if (intensitySliderA.over()) return true;

  //---------------------------------------------------------  

  if (intensitySliderB.over()) return true;

  //---------------------------------------------------------  

  return false;
}//end func


void mouseReleased()
{
  //Update scaled mouse everytime before the values are used
  mouseXS = round((float)mouseX / SF);
  mouseYS = round((float)mouseY / SF);

  pressHoldRollingTimer = cMousePressHoldBaseTime; //reset mousePressed hold down timer

  GlobalDragging = false; //incase a slider is being dragged
} //end mouseReleased

//======================================================================================================================

void mouseDragged()
{
  //The mouseDragged() function is called once every time the mouse moves while a mouse button is pressed. (If a button is not being pressed, mouseMoved() is called instead.) 
  //  println("MouseDragging");
  // allowMousePressHold = false;
  //  if(GlobalDragging == true) redraw();
}

//======================================================================================================================

void mouseMoved()
{
  mouseXS = round((float)mouseX / SF);
  mouseYS = round((float)mouseY / SF);

  //cursor(HAND); //think it caused misc errors

  //---------------------------------------------------------

  if (software.mouseOverEnabled == true)
  {
    //Mouse Over Functions
    // Fairly ineffiecent, it will detect any object, even those not shown, so it will always redraw on mouse moved

    for (int i = 0; i != DropDownList.size(); i++) 
    { 
      //   DropDownListPointer = DropDownList.get(i); // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      //  if (DropDownListPointer.mouseOver()) return; //no other way to highlight, have to redraw
      //  if (DropDownListPointer.mouseOverOpen()) return; //no other way to highlight, have to redraw

      if (DropDownList.get(i).mouseOver()) return; //no other way to highlight, have to redraw
      if (DropDownList.get(i).mouseOverOpen()) return; //no other way to highlight, have to redraw
    } //end for

    //---------------------------------------------------------

    if (GlobalDDOpen == true)   return; //if a drop down is open, don't bother mousing over any other elements, just leave

    //---------------------------------------------------------

    for (int i = 0; i != ButtonList.size(); i++) 
    { 
      // An ArrayList doesn't know what it is storing so we have to cast the object coming out
      //if(i == 0) println(ButtonList.size());
      PointerButton = ButtonList.get(i);  
      if (PointerButton.mouseOver()) return;
    } //end for

    //---------------------------------------------------------

    /*
    for (int i =0; i != TextFieldList.size(); i++) 
     {
     TextFieldListPointer = TextFieldList.get(i);  
     if(TextFieldListPointer.mouseOver()) redraw();  //no other way to highlight, have to redraw
     }
     
     for (int i =0; i != CheckBoxList.size(); i++) 
     {
     CheckBoxListPointer = CheckBoxList.get(i);  
     if(CheckBoxListPointer.mouseOver()) redraw();  //no other way to highlight, have to redraw
     }
     */
  } //end sEnableMouseOver if()

  // cursor(ARROW);
} //end mouseMoved

//======================================================================================================================

void mouseWheel(MouseEvent event)
{
  //println("mouseWheel()");
  mouseXS = round((float)mouseX / SF);
  mouseYS = round((float)mouseY / SF);

  if (OverlayMenuID == 0)
  {
    //no overlay menu is open
    if (mouseXS > 0 && mouseXS < cDefaultGUIWidth && mouseYS > 650 && mouseYS < cDefaultGUIHeight)
    {
      //println("mouseWheel() - Over source content menu area");
      if (event.getCount() > 0 && sourceContentScrollBar.value > 0) sourceContentScrollBar.value--;
      else if (event.getCount() < 0 && sourceContentScrollBar.value < sourceContentScrollBar.max) sourceContentScrollBar.value++;
    }
  }

  //also want to do the intensity and opacity sliders, along with main mixer
} //end mousewheel
