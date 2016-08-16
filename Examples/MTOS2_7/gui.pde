/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

/**
*This function loads up the start menu when the button is clicked
*
*@param GImageButton source the picture for the start button
*@param GEvent event mouse click event on the button
*/
public void startButton_click1(GImageButton source, GEvent event) { //_CODE_:startButton:719649:
  println("imgButton1 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  if (startMenu.isVisible() == false){
  startMenu.setVisible(true);
  }else{
    startMenu.setVisible(false);
  }
} //_CODE_:startButton:719649:

/**
*This function loads applications when a certain thing is clicked
*
*@param GDropList source the list of applications
*@param GEvent event mouse click event on the list
*/
public void startMenu_click1(GDropList source, GEvent event) { //_CODE_:startMenu:955860:
  println("startMenu - GDropList event occured " + System.currentTimeMillis()%10000000 );
  startMenu.setVisible(false);
  app = startMenu.getSelectedText();
  if (app.equals("MBACK")){
   background1 = new GWindow(this, "MBACK", 0, 0, 421, 375, false, JAVA2D);
  background1.setActionOnClose(G4P.CLOSE_WINDOW);
  background1.addDrawHandler(this, "background1_draw2");
  backTitle = new GLabel(background1.papplet, 109, 22, 197, 21);
  backTitle.setText("Please choose a background.");
  backTitle.setTextBold();
  backTitle.setOpaque(false);
  backpic1 = new GImageButton(background1.papplet, 17, 67, 110, 76, new String[] { "hgght.JPG", "hgght.JPG", "hgght.JPG" } );
  backpic1.addEventHandler(this, "backpic1_click1");
  backpic2 = new GImageButton(background1.papplet, 143, 67, 118, 75, new String[] { "Background.png", "Background.png", "Background.png" } );
  backpic2.addEventHandler(this, "backpic2_click1");
  backpic3 = new GImageButton(background1.papplet, 273, 69, 123, 73, new String[] { "stockback1.jpg", "stockback1.jpg", "stockback1.jpg" } );
  backpic3.addEventHandler(this, "backpic3_click1");
  backpic4 = new GImageButton(background1.papplet, 11, 165, 120, 76, new String[] { "stockback2.jpg", "stockback2.jpg", "stockback2.jpg" } );
  backpic4.addEventHandler(this, "backpic4_click1");
  backpic5 = new GImageButton(background1.papplet, 142, 166, 120, 75, new String[] { "stockback3.jpg", "stockback3.jpg", "stockback3.jpg" } );
  backpic5.addEventHandler(this, "backpic5_click1");
  backpic6 = new GImageButton(background1.papplet, 273, 167, 121, 76, new String[] { "stockback4.jpg", "stockback4.jpg", "stockback4.jpg" } );
  backpic6.addEventHandler(this, "backpic6_click1");
  backpic7 = new GImageButton(background1.papplet, 12, 256, 120, 72, new String[] { "stockback5.jpg", "stockback5.jpg", "stockback5.jpg" } );
  backpic7.addEventHandler(this, "backpic7_click1");
  backpic8 = new GImageButton(background1.papplet, 140, 258, 124, 69, new String[] { "stockback6.jpg", "stockback6.jpg", "stockback6.jpg" } );
  backpic8.addEventHandler(this, "backpic8_click1");
  backpic9 = new GImageButton(background1.papplet, 272, 257, 123, 70, new String[] { "stockback7.jpg", "stockback7.jpg", "stockback7.jpg" } );
  backpic9.addEventHandler(this, "backpic9_click1");
  
  }else if (app.equals("MCLICK")){
       clickGame = new GWindow(this, "MCLICK", 0, 0, 400, 270, false, JAVA2D);
  clickGame.setActionOnClose(G4P.CLOSE_WINDOW);
  clickGame.addDrawHandler(this, "clickGame_draw1");
  title = new GLabel(clickGame.papplet, 29, 24, 327, 38);
  title.setText("Welcome to MTOS Click! How fast can you click 100 times?");
  title.setOpaque(false);
  clicked = new GLabel(clickGame.papplet, 135, 98, 103, 29);
  clicked.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  clicked.setText("Clicked:");
  clicked.setOpaque(false);
  timer = new GLabel(clickGame.papplet, 134, 134, 105, 26);
  timer.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  timer.setText("Time:");
  timer.setOpaque(false);
  clickButton = new GButton(clickGame.papplet, 70, 183, 215, 44);
  clickButton.setText("Click to Begin!");
  clickButton.addEventHandler(this, "clickButton_click1");
  clickTimer = new GTimer(this, this, "clickTimer_Action1", 1000);
  }else if (app.equals("MSONG")){ 
    musicplayer = new GWindow(this, "MSONG", 0, 0, 535, 356, false, JAVA2D);
  musicplayer.addDrawHandler(this, "musicplayer_draw1");
  musicstopbutton = new GButton(musicplayer.papplet, 190, 250, 100, 40);
  musicstopbutton.setText("Stop");
  musicstopbutton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  musicstopbutton.addEventHandler(this, "musicstopbutton_click1");
  musicplaybutton = new GButton(musicplayer.papplet, 65, 250, 100, 40);
  musicplaybutton.setText("Play");
  musicplaybutton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  musicplaybutton.addEventHandler(this, "musicplaybutton_click1");
  musicchooser = new GButton(musicplayer.papplet, 360, 137, 130, 50);
  musicchooser.setText("Choose Song...");
  musicchooser.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  musicchooser.addEventHandler(this, "musicchooser_click1");
  reloadSong = new GButton(musicplayer.papplet, 360, 210, 130, 50);
  reloadSong.setText("Reload Player");
  reloadSong.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  reloadSong.addEventHandler(this, "reloadSong_click1");
  labelsong = new GLabel(musicplayer.papplet, 61, 42, 66, 50);
  labelsong.setText("Song:");
  labelsong.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  labelsong.setOpaque(true);
  songname = new GLabel(musicplayer.papplet, 24, 138, 291, 23);
  songname.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  songname.setOpaque(true);
  exitButton = new GButton(musicplayer.papplet, 405, 25, 80, 30);
  exitButton.setText("Exit");
  exitButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  exitButton.addEventHandler(this, "exitButton_click1");
  minimtest = new Minim(this);
  }else if (app.equals("MCALC")){
    calculator = new GWindow(this, "MCALC", 0, 0, 500, 430, false, JAVA2D);
  calculator.setActionOnClose(G4P.CLOSE_WINDOW);
  calculator.addDrawHandler(this, "calculator_draw1");
  button1 = new GButton(calculator.papplet, 30, 350, 50, 50);
  button1.setText("1");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(calculator.papplet, 90, 350, 50, 50);
  button2.setText("2");
  button2.addEventHandler(this, "button2_click1");
  button3 = new GButton(calculator.papplet, 150, 350, 50, 50);
  button3.setText("3");
  button3.addEventHandler(this, "button3_click1");
  button4 = new GButton(calculator.papplet, 30, 290, 50, 50);
  button4.setText("4");
  button4.addEventHandler(this, "button4_click1");
  button5 = new GButton(calculator.papplet, 90, 290, 50, 50);
  button5.setText("5");
  button5.addEventHandler(this, "button5_click1");
  button6 = new GButton(calculator.papplet, 150, 290, 50, 50);
  button6.setText("6");
  button6.addEventHandler(this, "button6_click1");
  button7 = new GButton(calculator.papplet, 30, 230, 50, 50);
  button7.setText("7");
  button7.addEventHandler(this, "button7_click1");
  button8 = new GButton(calculator.papplet, 90, 230, 50, 50);
  button8.setText("8");
  button8.addEventHandler(this, "button8_click1");
  button9 = new GButton(calculator.papplet, 150, 230, 50, 50);
  button9.setText("9");
  button9.addEventHandler(this, "button9_click1");
  button0 = new GButton(calculator.papplet, 210, 350, 50, 50);
  button0.setText("0");
  button0.addEventHandler(this, "button0_click1");
  buttonequals = new GButton(calculator.papplet, 400, 350, 50, 50);
  buttonequals.setText("=");
  buttonequals.addEventHandler(this, "buttonequals_click1");
  buttondivide = new GButton(calculator.papplet, 400, 290, 50, 50);
  buttondivide.setText("/");
  buttondivide.addEventHandler(this, "buttondivide_click1");
  buttontimes = new GButton(calculator.papplet, 340, 290, 50, 50);
  buttontimes.setText("*");
  buttontimes.addEventHandler(this, "buttontimes_click1");
  buttonminus = new GButton(calculator.papplet, 400, 230, 50, 50);
  buttonminus.setText("-");
  buttonminus.addEventHandler(this, "buttonminus_click1");
  buttonplus = new GButton(calculator.papplet, 340, 230, 50, 50);
  buttonplus.setText("+");
  buttonplus.addEventHandler(this, "buttonplus_click1");
  clear = new GButton(calculator.papplet, 340, 170, 110, 50);
  clear.setText("ON/C");
  clear.addEventHandler(this, "clear_click1");
  number1 = new GTextField(calculator.papplet, 30, 110, 160, 30, G4P.SCROLLBARS_NONE);
  number1.setLocalColorScheme(GCScheme.RED_SCHEME);
  number1.setOpaque(true);
  number1.addEventHandler(this, "number1_change1");
  symbol = new GTextField(calculator.papplet, 190, 110, 90, 30, G4P.SCROLLBARS_NONE);
  symbol.setLocalColorScheme(GCScheme.RED_SCHEME);
  symbol.setOpaque(true);
  symbol.addEventHandler(this, "symbol_change1");
  number2 = new GTextField(calculator.papplet, 280, 110, 180, 30, G4P.SCROLLBARS_NONE);
  number2.setLocalColorScheme(GCScheme.RED_SCHEME);
  number2.setOpaque(true);
  number2.addEventHandler(this, "number2_change1");
  result = new GTextField(calculator.papplet, 100, 60, 280, 30, G4P.SCROLLBARS_NONE);
  result.setLocalColorScheme(GCScheme.RED_SCHEME);
  result.setOpaque(true);
  result.addEventHandler(this, "result_change1");
  labelequals = new GLabel(calculator.papplet, 60, 60, 40, 30);
  labelequals.setText("=");
  labelequals.setLocalColorScheme(GCScheme.RED_SCHEME);
  labelequals.setOpaque(true);
  }else if (app.equals("MTEXT")){
 mtext = new GWindow(this, "MTEXT", 0, 0, 500, 432, false, JAVA2D);
  mtext.setActionOnClose(G4P.CLOSE_WINDOW);
  mtext.addDrawHandler(this, "mtext_draw1");
  mtextarea1 = new GTextArea(mtext.papplet, 0, 0, 500, 355, G4P.SCROLLBARS_VERTICAL_ONLY);
  mtextarea1.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextarea1.setOpaque(true);
  mtextarea1.addEventHandler(this, "mtextarea1_change1");
  mtextloadbutton = new GButton(mtext.papplet, 15, 375, 100, 30);
  mtextloadbutton.setText("Load");
  mtextloadbutton.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextloadbutton.addEventHandler(this, "mtextloadbutton_click1");
  saveasmtext = new GButton(mtext.papplet, 130, 375, 100, 30);
  saveasmtext.setText("Save As...");
  saveasmtext.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  saveasmtext.addEventHandler(this, "saveasmtext_click1");
  mtextname = new GTextField(mtext.papplet, 240, 375, 136, 30, G4P.SCROLLBARS_NONE);
  mtextname.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextname.setOpaque(true);
  mtextname.addEventHandler(this, "mtextname_change1");
  labelmtext = new GLabel(mtext.papplet, 380, 380, 33, 20);
  labelmtext.setText(".");
  labelmtext.setTextBold();
  labelmtext.setOpaque(false);
  mtextExt = new GTextField(mtext.papplet, 420, 375, 62, 30, G4P.SCROLLBARS_NONE);
  mtextExt.setText("mText");
  mtextExt.setDefaultText("mText");
  mtextExt.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextExt.setOpaque(true);
  mtextExt.addEventHandler(this, "mtextExt_change1");
  } else if (app.equals("MHELP")){
  mhelp = new GWindow(this, "MHELP", 0, 0, 500, 351, false, JAVA2D);
  mhelp.setActionOnClose(G4P.CLOSE_WINDOW);
  mhelp.addDrawHandler(this, "mhelp_draw1");
  mhelptext = new GTextArea(mhelp.papplet, 4, 6, 490, 285, G4P.SCROLLBARS_VERTICAL_ONLY);
  mhelptext.setOpaque(true);
  mhelptext.addEventHandler(this, "mhelptext_change1");
  helploader = new GButton(mhelp.papplet, 180, 300, 80, 30);
  helploader.setText("Load Help");
  helploader.addEventHandler(this, "helploader_click1");
  
  }else if (app.equals("Shut Down")){
    exit();
  }
  app = ""; 
  startMenu.setSelected(0);
  startMenu.setVisible(false);
} //_CODE_:startMenu:955860:

/**
*This function loads the gallery application upon double click
*
*@param GImageButton the picture for the application icon
*@param GEvent event mouse click event on the icon
*/
public void gallery1_click1(GImageButton source, GEvent event) { //_CODE_:gallery1:639563:
  println("imgButton1 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  if (mouseEvent.getClickCount()==2){
  background1 = new GWindow(this, "MBACK", 0, 0, 421, 375, false, JAVA2D);
  background1.setActionOnClose(G4P.CLOSE_WINDOW);
  background1.addDrawHandler(this, "background1_draw2");
  backTitle = new GLabel(background1.papplet, 109, 22, 197, 21);
  backTitle.setText("Please choose a background.");
  backTitle.setTextBold();
  backTitle.setOpaque(false);
  backpic1 = new GImageButton(background1.papplet, 17, 67, 110, 76, new String[] { "hgght.JPG", "hgght.JPG", "hgght.JPG" } );
  backpic1.addEventHandler(this, "backpic1_click1");
  backpic2 = new GImageButton(background1.papplet, 143, 67, 118, 75, new String[] { "Background.png", "Background.png", "Background.png" } );
  backpic2.addEventHandler(this, "backpic2_click1");
  backpic3 = new GImageButton(background1.papplet, 273, 69, 123, 73, new String[] { "stockback1.jpg", "stockback1.jpg", "stockback1.jpg" } );
  backpic3.addEventHandler(this, "backpic3_click1");
  backpic4 = new GImageButton(background1.papplet, 11, 165, 120, 76, new String[] { "stockback2.jpg", "stockback2.jpg", "stockback2.jpg" } );
  backpic4.addEventHandler(this, "backpic4_click1");
  backpic5 = new GImageButton(background1.papplet, 142, 166, 120, 75, new String[] { "stockback3.jpg", "stockback3.jpg", "stockback3.jpg" } );
  backpic5.addEventHandler(this, "backpic5_click1");
  backpic6 = new GImageButton(background1.papplet, 273, 167, 121, 76, new String[] { "stockback4.jpg", "stockback4.jpg", "stockback4.jpg" } );
  backpic6.addEventHandler(this, "backpic6_click1");
  backpic7 = new GImageButton(background1.papplet, 12, 256, 120, 72, new String[] { "stockback5.jpg", "stockback5.jpg", "stockback5.jpg" } );
  backpic7.addEventHandler(this, "backpic7_click1");
  backpic8 = new GImageButton(background1.papplet, 140, 258, 124, 69, new String[] { "stockback6.jpg", "stockback6.jpg", "stockback6.jpg" } );
  backpic8.addEventHandler(this, "backpic8_click1");
  backpic9 = new GImageButton(background1.papplet, 272, 257, 123, 70, new String[] { "stockback7.jpg", "stockback7.jpg", "stockback7.jpg" } );
  backpic9.addEventHandler(this, "backpic9_click1");
   
  }

} //_CODE_:gallery1:639563:

/**
*This function loads the click game application upon double click
*
*@param GImageButton the picture for the application icon
*@param GEvent event mouse click event on the icon
*/
public void clickGameButton1_click1(GImageButton source, GEvent event) { //_CODE_:clickGameButton1:975569:
  println("clickGameButton1 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  if (mouseEvent.getClickCount()==2){
   clickGame = new GWindow(this, "MCLICK", 0, 0, 400, 270, false, JAVA2D);
  clickGame.setActionOnClose(G4P.CLOSE_WINDOW);
  clickGame.addDrawHandler(this, "clickGame_draw1");
  title = new GLabel(clickGame.papplet, 29, 24, 327, 38);
  title.setText("Welcome to MTOS Click! How fast can you click 100 times?");
  title.setOpaque(false);
  clicked = new GLabel(clickGame.papplet, 135, 98, 103, 29);
  clicked.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  clicked.setText("Clicked:");
  clicked.setOpaque(false);
  timer = new GLabel(clickGame.papplet, 134, 134, 105, 26);
  timer.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  timer.setText("Time:");
  timer.setOpaque(false);
  clickButton = new GButton(clickGame.papplet, 70, 183, 215, 44);
  clickButton.setText("Click to Begin!");
  clickButton.addEventHandler(this, "clickButton_click1");
  clickTimer = new GTimer(this, this, "clickTimer_Action1", 1000);
  }
} //_CODE_:clickGameButton1:975569:

/**
*This function loads the music player application upon double click
*
*@param GImageButton the picture for the application icon
*@param GEvent event mouse click event on the icon
*/
public void musicplayerbutton_click1(GImageButton source, GEvent event) { //_CODE_:musicplayerbutton:395010:
  println("musicplayerbutton - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  if (mouseEvent.getClickCount()==2){
      musicplayer = new GWindow(this, "MSONG", 0, 0, 535, 356, false, JAVA2D);
  musicplayer.addDrawHandler(this, "musicplayer_draw1");
  musicstopbutton = new GButton(musicplayer.papplet, 190, 250, 100, 40);
  musicstopbutton.setText("Stop");
  musicstopbutton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  musicstopbutton.addEventHandler(this, "musicstopbutton_click1");
  musicplaybutton = new GButton(musicplayer.papplet, 65, 250, 100, 40);
  musicplaybutton.setText("Play");
  musicplaybutton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  musicplaybutton.addEventHandler(this, "musicplaybutton_click1");
  musicchooser = new GButton(musicplayer.papplet, 360, 137, 130, 50);
  musicchooser.setText("Choose Song...");
  musicchooser.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  musicchooser.addEventHandler(this, "musicchooser_click1");
  reloadSong = new GButton(musicplayer.papplet, 360, 210, 130, 50);
  reloadSong.setText("Reload Player");
  reloadSong.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  reloadSong.addEventHandler(this, "reloadSong_click1");
  labelsong = new GLabel(musicplayer.papplet, 61, 42, 66, 50);
  labelsong.setText("Song:");
  labelsong.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  labelsong.setOpaque(true);
  songname = new GLabel(musicplayer.papplet, 24, 138, 291, 23);
  songname.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  songname.setOpaque(true);
  exitButton = new GButton(musicplayer.papplet, 405, 25, 80, 30);
  exitButton.setText("Exit");
  exitButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  exitButton.addEventHandler(this, "exitButton_click1");
  minimtest = new Minim(this);
  }
} //_CODE_:musicplayerbutton:395010:

/**
*This function loads the calculator application upon double click
*
*@param GImageButton the picture for the application icon
*@param GEvent event mouse click event on the icon
*/
public void calcButton_click1(GImageButton source, GEvent event) { //_CODE_:calcButton:515516:
  println("calcButton - GImageButton event occured " + System.currentTimeMillis()%10000000 );
    if (mouseEvent.getClickCount()==2){
      calculator = new GWindow(this, "MCALC", 0, 0, 500, 430, false, JAVA2D);
  calculator.setActionOnClose(G4P.CLOSE_WINDOW);
  calculator.addDrawHandler(this, "calculator_draw1");
  button1 = new GButton(calculator.papplet, 30, 350, 50, 50);
  button1.setText("1");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(calculator.papplet, 90, 350, 50, 50);
  button2.setText("2");
  button2.addEventHandler(this, "button2_click1");
  button3 = new GButton(calculator.papplet, 150, 350, 50, 50);
  button3.setText("3");
  button3.addEventHandler(this, "button3_click1");
  button4 = new GButton(calculator.papplet, 30, 290, 50, 50);
  button4.setText("4");
  button4.addEventHandler(this, "button4_click1");
  button5 = new GButton(calculator.papplet, 90, 290, 50, 50);
  button5.setText("5");
  button5.addEventHandler(this, "button5_click1");
  button6 = new GButton(calculator.papplet, 150, 290, 50, 50);
  button6.setText("6");
  button6.addEventHandler(this, "button6_click1");
  button7 = new GButton(calculator.papplet, 30, 230, 50, 50);
  button7.setText("7");
  button7.addEventHandler(this, "button7_click1");
  button8 = new GButton(calculator.papplet, 90, 230, 50, 50);
  button8.setText("8");
  button8.addEventHandler(this, "button8_click1");
  button9 = new GButton(calculator.papplet, 150, 230, 50, 50);
  button9.setText("9");
  button9.addEventHandler(this, "button9_click1");
  button0 = new GButton(calculator.papplet, 210, 350, 50, 50);
  button0.setText("0");
  button0.addEventHandler(this, "button0_click1");
  buttonequals = new GButton(calculator.papplet, 400, 350, 50, 50);
  buttonequals.setText("=");
  buttonequals.addEventHandler(this, "buttonequals_click1");
  buttondivide = new GButton(calculator.papplet, 400, 290, 50, 50);
  buttondivide.setText("/");
  buttondivide.addEventHandler(this, "buttondivide_click1");
  buttontimes = new GButton(calculator.papplet, 340, 290, 50, 50);
  buttontimes.setText("*");
  buttontimes.addEventHandler(this, "buttontimes_click1");
  buttonminus = new GButton(calculator.papplet, 400, 230, 50, 50);
  buttonminus.setText("-");
  buttonminus.addEventHandler(this, "buttonminus_click1");
  buttonplus = new GButton(calculator.papplet, 340, 230, 50, 50);
  buttonplus.setText("+");
  buttonplus.addEventHandler(this, "buttonplus_click1");
  clear = new GButton(calculator.papplet, 340, 170, 110, 50);
  clear.setText("ON/C");
  clear.addEventHandler(this, "clear_click1");
  number1 = new GTextField(calculator.papplet, 30, 110, 160, 30, G4P.SCROLLBARS_NONE);
  number1.setLocalColorScheme(GCScheme.RED_SCHEME);
  number1.setOpaque(true);
  number1.addEventHandler(this, "number1_change1");
  symbol = new GTextField(calculator.papplet, 190, 110, 90, 30, G4P.SCROLLBARS_NONE);
  symbol.setLocalColorScheme(GCScheme.RED_SCHEME);
  symbol.setOpaque(true);
  symbol.addEventHandler(this, "symbol_change1");
  number2 = new GTextField(calculator.papplet, 280, 110, 180, 30, G4P.SCROLLBARS_NONE);
  number2.setLocalColorScheme(GCScheme.RED_SCHEME);
  number2.setOpaque(true);
  number2.addEventHandler(this, "number2_change1");
  result = new GTextField(calculator.papplet, 100, 60, 280, 30, G4P.SCROLLBARS_NONE);
  result.setLocalColorScheme(GCScheme.RED_SCHEME);
  result.setOpaque(true);
  result.addEventHandler(this, "result_change1");
  labelequals = new GLabel(calculator.papplet, 60, 60, 40, 30);
  labelequals.setText("=");
  labelequals.setLocalColorScheme(GCScheme.RED_SCHEME);
  labelequals.setOpaque(true);
    }
} //_CODE_:calcButton:515516:

/**
*This function loads the text application upon double click
*
*@param GImageButton the picture for the application icon
*@param GEvent event mouse click event on the icon
*/
public void mtextbutton1_click1(GImageButton source, GEvent event) { //_CODE_:mtextbutton1:282062:
  println("mtextbutton1 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  if (mouseEvent.getClickCount()==2){
    mtext = new GWindow(this, "MTEXT", 0, 0, 500, 432, false, JAVA2D);
  mtext.setActionOnClose(G4P.CLOSE_WINDOW);
  mtext.addDrawHandler(this, "mtext_draw1");
  mtextarea1 = new GTextArea(mtext.papplet, 0, 0, 500, 355, G4P.SCROLLBARS_VERTICAL_ONLY);
  mtextarea1.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextarea1.setOpaque(true);
  mtextarea1.addEventHandler(this, "mtextarea1_change1");
  mtextloadbutton = new GButton(mtext.papplet, 15, 375, 100, 30);
  mtextloadbutton.setText("Load");
  mtextloadbutton.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextloadbutton.addEventHandler(this, "mtextloadbutton_click1");
  saveasmtext = new GButton(mtext.papplet, 130, 375, 100, 30);
  saveasmtext.setText("Save As...");
  saveasmtext.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  saveasmtext.addEventHandler(this, "saveasmtext_click1");
  mtextname = new GTextField(mtext.papplet, 240, 375, 136, 30, G4P.SCROLLBARS_NONE);
  mtextname.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextname.setOpaque(true);
  mtextname.addEventHandler(this, "mtextname_change1");
  labelmtext = new GLabel(mtext.papplet, 380, 380, 33, 20);
  labelmtext.setText(".");
  labelmtext.setTextBold();
  labelmtext.setOpaque(false);
  mtextExt = new GTextField(mtext.papplet, 420, 375, 62, 30, G4P.SCROLLBARS_NONE);
  mtextExt.setText("mText");
  mtextExt.setDefaultText("mText");
  mtextExt.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  mtextExt.setOpaque(true);
  mtextExt.addEventHandler(this, "mtextExt_change1");
  }
} //_CODE_:mtextbutton1:282062:

/**
*This function loads the help application upon double click
*
*@param GImageButton the picture for the application icon
*@param GEvent event mouse click event on the icon
*/
public void helpbutton_click1(GImageButton source, GEvent event) { //_CODE_:helpbutton:334896:
  println("helpbutton - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  if (mouseEvent.getClickCount()==2){
  mhelp = new GWindow(this, "MHELP", 0, 0, 500, 351, false, JAVA2D);
  mhelp.setActionOnClose(G4P.CLOSE_WINDOW);
  mhelp.addDrawHandler(this, "mhelp_draw1");
  mhelptext = new GTextArea(mhelp.papplet, 4, 6, 490, 285, G4P.SCROLLBARS_VERTICAL_ONLY);
  mhelptext.setOpaque(true);
  mhelptext.addEventHandler(this, "mhelptext_change1");
  helploader = new GButton(mhelp.papplet, 180, 300, 80, 30);
  helploader.setText("Load Help");
  helploader.addEventHandler(this, "helploader_click1");


  }
} //_CODE_:helpbutton:334896:

/**
*This function draws the background changer
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void background1_draw2(GWinApplet appc, GWinData data) { //_CODE_:background1:489899:
appc.background(#F51427);
} //_CODE_:background1:489899:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic1_click1(GImageButton source, GEvent event) { //_CODE_:backpic1:932231:
  println("backpic1 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
    println("fdshf");
    back1 = "hgght.JPG";;
    String[] list = split(back1, ' ');
    saveStrings("background.txt", list);
    backg();
  
} //_CODE_:backpic1:932231:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic2_click1(GImageButton source, GEvent event) { //_CODE_:backpic2:680599:
  println("backpic2 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
      back1 = "Background.png";
      String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
      backg();
} //_CODE_:backpic2:680599:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic3_click1(GImageButton source, GEvent event) { //_CODE_:backpic3:448602:
  println("backpic3 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback1.jpg";
      String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic3:448602:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic4_click1(GImageButton source, GEvent event) { //_CODE_:backpic4:963414:
  println("backpic4 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback2.jpg";
        String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic4:963414:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic5_click1(GImageButton source, GEvent event) { //_CODE_:backpic5:959043:
  println("backpic5 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback3.jpg";
        String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic5:959043:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic6_click1(GImageButton source, GEvent event) { //_CODE_:backpic6:347137:
  println("backpic6 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback4.jpg";
        String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic6:347137:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic7_click1(GImageButton source, GEvent event) { //_CODE_:backpic7:558619:
  println("backpic7 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback5.jpg";
        String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic7:558619:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic8_click1(GImageButton source, GEvent event) { //_CODE_:backpic8:383974:
  println("backpic8 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback6.jpg";
        String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic8:383974:

/**
*This function changes the background to the specified name of the picture
*
*@param GImageButton the picture for the background preview
*@param GEvent event mouse click event on the picture
*/
public void backpic9_click1(GImageButton source, GEvent event) { //_CODE_:backpic9:663800:
  println("backpic9 - GImageButton event occured " + System.currentTimeMillis()%10000000 );
  back1 = "stockback7.jpg";
        String[] list = split(back1, ' ');
      saveStrings("background.txt", list);
  backg();
} //_CODE_:backpic9:663800:

/**
*This function draws the login window
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void loginWindow_draw1(GWinApplet appc, GWinData data) { //_CODE_:loginWindow:497151:
  appc.background(#5070EA);
} //_CODE_:loginWindow:497151:

/**
*This function allows for typing in the login username textbox
*
*@param GTextField source the textbox
*@param GEvent event any typing or clicking that occurs on it
*/
public void userInput_change1(GTextField source, GEvent event) { //_CODE_:userInput:269400:
  println("userInput - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:userInput:269400:

/**
*This function allows for typing in the login password textbox
*
*@param GTextField source the textbox
*@param GEvent event any typing or clicking that occurs on it
*/
public void passInput_change1(GTextField source, GEvent event) { //_CODE_:passInput:471913:
  println("passInput - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:passInput:471913:

/**
*This function atempts to log the user into the OS
*
*@param GButton source the specific button that is clicked
*@param GEvent event mouse click event on the button
*/
public void loginbutton1_click1(GButton source, GEvent event) { //_CODE_:loginbutton1:597405:
  println("button1 - GButton event occured " + System.currentTimeMillis()%10000000 );
  /////////
    String usernamelines[] = loadStrings("username.txt");
  int user_i = usernamelines.length + 1;
  for (int i = 0 ; i < usernamelines.length; i++) {
    println(usernamelines[i]);
  }

  String passwordlines[] = loadStrings("password.txt");
  int pass_i = passwordlines.length;
  for (int i = 0 ; i < passwordlines.length; i++) {
    println(passwordlines[i]);
  }

  for (int i = 0 ; i < user_i-1; i++) {
    if ((userInput.getText().equals(usernamelines[i])) && (passInput.getText().equals(passwordlines[i])) && (passloopcount == 0)) {
      passloopcount = 1;
      winx = 100;
      startup = new Minim(this);
      start = startup.loadFile("Microsoft Windows 95 Startup Sound.mp3", 2048);
      start.play();
      while (true){
        if (start.isPlaying() == false){
              start.close();
              startup.stop();
              mainLoc();
             loginWindow.forceClose();
             break;
        }
    }
  }
  }
  ////////
} //_CODE_:loginbutton1:597405:

/**
*This function draws the click game
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void clickGame_draw1(GWinApplet appc, GWinData data) { //_CODE_:clickGame:975604:
  appc.background(#C1A8EA);
} //_CODE_:clickGame:975604:

/**
*This function displays the user's time in the click game
*
*@param GButton source the specific button that is clicked
*@param GEvent event mouse click event on the button
*/
public void clickButton_click1(GButton source, GEvent event) { //_CODE_:clickButton:390218:
  println("clickButton - GButton event occured " + System.currentTimeMillis()%10000000 );
    clickButton.setText("Click Click Click!!!");
  if (clickTimer.isRunning() == false){
  clickTimer.start();
  }
  clickedCount += 1;
  clicked.setText("Clicked: " + clickedCount );
  if (clickedCount == 100){
    clickTimer.stop();
    title.setText("Wow! It took you " + clickedTimer + " seconds to click 100 times!");
    clickButton.setEnabled(false);
    clickedTimer = 0;
    clickedCount = 0;
  }
} //_CODE_:clickButton:390218:

/**
*This function creats a timer for the cick game
*
*@param Gtimersource the specific button that is clicked
*/
public void clickTimer_Action1(GTimer source) { //_CODE_:clickTimer:755201:
  println("timer1 - GTimer event occured " + System.currentTimeMillis()%10000000 );
  clickedTimer += 1;
  timer.setText("Time: " + clickedTimer + " seconds");
} //_CODE_:clickTimer:755201:

/**
*This function draws the music player
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void musicplayer_draw1(GWinApplet appc, GWinData data) { //_CODE_:musicplayer:345049:
  appc.background(#14F53B);
} //_CODE_:musicplayer:345049:

/**
*This function stops the music from playing 
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void musicstopbutton_click1(GButton source, GEvent event) { //_CODE_:musicstopbutton:415436:
  println("musicstopbutton - GButton event occured " + System.currentTimeMillis()%10000000 );
  player1.pause();
} //_CODE_:musicstopbutton:415436:

/**
*This function plays the music from playing 
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void musicplaybutton_click1(GButton source, GEvent event) { //_CODE_:musicplaybutton:525120:
  println("musicplaybutton - GButton event occured " + System.currentTimeMillis()%10000000 );
  player1.loop();
  player1.play();
} //_CODE_:musicplaybutton:525120:

/**
*This function allows you to chose music to play
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void musicchooser_click1(GButton source, GEvent event) { //_CODE_:musicchooser:258232:
  println("musicchooser - GButton event occured " + System.currentTimeMillis()%10000000 );
  File directory = new File(sketchPath(""));
  final JFileChooser filebrowse = new JFileChooser();
 filebrowse.setCurrentDirectory(directory);
  int returnVal = filebrowse.showOpenDialog(musicplayer);
  if (returnVal == JFileChooser.APPROVE_OPTION){
    File selectfile = filebrowse.getSelectedFile();
    song = selectfile.getPath();
    songname.setText(selectfile.getName());
  }

} //_CODE_:musicchooser:258232:

/**
*This function loads the song to the music player
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void reloadSong_click1(GButton source, GEvent event) { //_CODE_:reloadSong:317738:
  println("reloadSong - GButton event occured " + System.currentTimeMillis()%10000000 );
  if (songreloadercount == false){
  player1 = minimtest.loadFile(song, 2048);
  songreloadercount = true;
  }else{
    player1.close();
    player1 = minimtest.loadFile(song, 2048);
  }
} //_CODE_:reloadSong:317738:

/**
*This function allows you to exit the music player
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void exitButton_click1(GButton source, GEvent event) { //_CODE_:exitButton:852116:
  println("exitButton - GButton event occured " + System.currentTimeMillis()%10000000 );
    try{
    player1.close();
    minimtest.stop();
    musicplayer.forceClose();
    }finally{
    musicplayer.forceClose();
    }
} //_CODE_:exitButton:852116:

/**
*This function draws the calculator
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void calculator_draw1(GWinApplet appc, GWinData data) { //_CODE_:calculator:761339:
  appc.background(#3776B7);
} //_CODE_:calculator:761339:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:446083:
  println("button1 - GButton event occured " + System.currentTimeMillis()%10000000 );
  if (symbolcount == false){
  number1.appendText("1");
  }else{
   number2.appendText("1");
  }
} //_CODE_:button1:446083:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:697809:
  println("button2 - GButton event occured " + System.currentTimeMillis()%10000000 );
  if (symbolcount == false){
  number1.appendText("2");
  }else{
   number2.appendText("2");
  }
} //_CODE_:button2:697809:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:539627:
  println("button3 - GButton event occured " + System.currentTimeMillis()%10000000 );
   if (symbolcount == false){
  number1.appendText("3");
  }else{
   number2.appendText("3");
  }
} //_CODE_:button3:539627:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button4_click1(GButton source, GEvent event) { //_CODE_:button4:210301:
  println("button4 - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  number1.appendText("4");
  }else{
   number2.appendText("4");
  }
} //_CODE_:button4:210301:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button5_click1(GButton source, GEvent event) { //_CODE_:button5:714462:
  println("button5 - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  number1.appendText("5");
  }else{
   number2.appendText("5");
  }
} //_CODE_:button5:714462:

public void button6_click1(GButton source, GEvent event) { //_CODE_:button6:424989:
  println("button6 - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  number1.appendText("6");
  }else{
   number2.appendText("6");
  }
} //_CODE_:button6:424989:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button7_click1(GButton source, GEvent event) { //_CODE_:button7:304948:
  println("button7 - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  number1.appendText("7");
  }else{
   number2.appendText("7");
  }
} //_CODE_:button7:304948:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button8_click1(GButton source, GEvent event) { //_CODE_:button8:511392:
  println("button8 - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  number1.appendText("8");
  }else{
   number2.appendText("8");
  }
} //_CODE_:button8:511392:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button9_click1(GButton source, GEvent event) { //_CODE_:button9:384146:
  println("button9 - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  number1.appendText("9");
  }else{
   number2.appendText("9");
  }
} //_CODE_:button9:384146:

/**
*This function adds the number in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void button0_click1(GButton source, GEvent event) { //_CODE_:button0:563376:
  println("button0 - GButton event occured " + System.currentTimeMillis()%10000000 );
  if (symbolcount == false){
    if ((number1.getText()).equals("")){
  number1.appendText("");
    }else{
      number1.appendText("0");
    }
  }else{
       if ((number2.getText()).equals("")){
  number2.appendText("");
    }else{
      number2.appendText("0");
    }
  }
} //_CODE_:button0:563376:

/**
*This function shows the user what the math function equals
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void buttonequals_click1(GButton source, GEvent event) { //_CODE_:buttonequals:642109:
  println("buttonequals - GButton event occured " + System.currentTimeMillis()%10000000 );
    if (symbol.getText().equals("+")){
    result.setText(String.valueOf(Float.parseFloat(number1.getText()) + Float.parseFloat(number2.getText())));
  } else if (symbol.getText().equals("-")){
    result.setText(String.valueOf(Float.parseFloat(number1.getText()) - Float.parseFloat(number2.getText())));
  } else if (symbol.getText().equals("*")){
    result.setText(String.valueOf(Float.parseFloat(number1.getText()) * Float.parseFloat(number2.getText())));
  }  else if (symbol.getText().equals("/")){
    if (Float.parseFloat(number2.getText()) != 0){
    result.setText(String.valueOf(Float.parseFloat(number1.getText()) / Float.parseFloat(number2.getText())));
  }else{
    result.setText("Error");
  }
  }
} //_CODE_:buttonequals:642109:

/**
*This function adds the symbol in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void buttondivide_click1(GButton source, GEvent event) { //_CODE_:buttondivide:483716:
  println("buttondivide - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  symbol.setText("/");
  symbolcount = true;
  }
} //_CODE_:buttondivide:483716:

/**
*This function adds the symbol in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void buttontimes_click1(GButton source, GEvent event) { //_CODE_:buttontimes:397068:
  println("buttontimes - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  symbol.setText("*");
  symbolcount = true;
  }
} //_CODE_:buttontimes:397068:

/**
*This function adds the symbol in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void buttonminus_click1(GButton source, GEvent event) { //_CODE_:buttonminus:277115:
  println("buttonminus - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  symbol.setText("-");
  symbolcount = true;
  }
} //_CODE_:buttonminus:277115:

/**
*This function adds the symbol in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void buttonplus_click1(GButton source, GEvent event) { //_CODE_:buttonplus:960808:
  println("buttonplus - GButton event occured " + System.currentTimeMillis()%10000000 );
      if (symbolcount == false){
  symbol.setText("+");
  symbolcount = true;
  }
} //_CODE_:buttonplus:960808:

/**
*This function adds the symbol in the calculator
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void clear_click1(GButton source, GEvent event) { //_CODE_:clear:330397:
  println("button10 - GButton event occured " + System.currentTimeMillis()%10000000 );
    number1.setText("");
  number2.setText("");
  symbol.setText("");
  result.setText("");
  symbolcount = false;
} //_CODE_:clear:330397:

/**
*This function makes the first textbox
*
*@param GTextField source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void number1_change1(GTextField source, GEvent event) { //_CODE_:number1:726589:
  println("textfield1 - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:number1:726589:

/**
*This function makes the second textbox
*
*@param GTextField source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void symbol_change1(GTextField source, GEvent event) { //_CODE_:symbol:276640:
  println("symbol - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:symbol:276640:

/**
*This function makes the third textbox
*
*@param GTextField source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void number2_change1(GTextField source, GEvent event) { //_CODE_:number2:898807:
  println("number2 - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:number2:898807:

/**
*This function makes the answer textbox
*
*@param GTextField source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void result_change1(GTextField source, GEvent event) { //_CODE_:result:918381:
  println("result - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:result:918381:

/**
*This function draws the text application
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void mtext_draw1(GWinApplet appc, GWinData data) { //_CODE_:mtext:290660:
  appc.background(#F0F568);
} //_CODE_:mtext:290660:

/**
*This function adds a textbox
*
*@param GTextArea source this is the button
*@param GEvent event this gets the event of mouse click
*/
public void mtextarea1_change1(GTextArea source, GEvent event) { //_CODE_:mtextarea1:402375:
  println("textarea1 - GTextArea event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:mtextarea1:402375:

/**
*This function loads the textfile selected by the user
*
*@param GButton source this is the button
*@param  GEvent event this gets the event of mouse click
*/
public void mtextloadbutton_click1(GButton source, GEvent event) { //_CODE_:mtextloadbutton:642919:
  println("mtextloadbutton - GButton event occured " + System.currentTimeMillis()%10000000 );
  mtextarea1.setText("");
  filecontents = "";
  File directory = new File(sketchPath(""));
  final JFileChooser filebrowse = new JFileChooser();
 filebrowse.setCurrentDirectory(directory); 
   int returnVal = filebrowse.showOpenDialog(mtext); 
 if (returnVal == JFileChooser.APPROVE_OPTION) { 
  File selectfile = filebrowse.getSelectedFile();
   filename = selectfile.getPath(); 
 }
 String lines[] = loadStrings(filename);
for (int i = 0 ; i < lines.length; i++) {
  filecontents = filecontents + lines[i] + "\n";
}
mtextarea1.setText(filecontents);
} //_CODE_:mtextloadbutton:642919:

/**
*This function saves the text that the user has typed in the text application
*
*@param GButton source this is the button
*@param GEvent event this gets the event of mouse click
*/
public void saveasmtext_click1(GButton source, GEvent event) { //_CODE_:saveasmtext:615554:
  println("button10 - GButton event occured " + System.currentTimeMillis()%10000000 );
    if ((mtextname.getText().equals("")) || (mtextExt.getText().equals(""))){
    println("Error");
  }else{
    filesave = mtextname.getText() + "." + mtextExt.getText() ;
    String[] filecontent =  split(mtextarea1.getText(),ENTER);
    saveStrings(filesave, filecontent);
  }
} //_CODE_:saveasmtext:615554:

/**
*This function adds the symbol in the calculator
*
*@param GButton source this is the button
*@param GEvent event this gets the event of mouse click
*/
public void mtextname_change1(GTextField source, GEvent event) { //_CODE_:mtextname:671995:
  println("mtextname - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:mtextname:671995:

public void mtextExt_change1(GTextField source, GEvent event) { //_CODE_:mtextExt:695392:
  println("mtextExt - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:mtextExt:695392:

/**
*This function draws the help application
*
*@param GWinApplet appc the application to draw
*@param GWinData data the wwindow's data
*/
synchronized public void mhelp_draw1(GWinApplet appc, GWinData data) { //_CODE_:mhelp:435494:
  appc.background(230);
} //_CODE_:mhelp:435494:

/**
*This function adds a text box
*
*@param GTextArea source this is the button
*@param GEvent event this gets the event of mouse click
*/
public void mhelptext_change1(GTextArea source, GEvent event) { //_CODE_:mhelptext:468684:
  println("mhelptext - GTextArea event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:mhelptext:468684:

/**
*This function adds the help button
*
*@param GButton source this is the button
*@param GEvent event this gets the event of mouse click
*/
public void helploader_click1(GButton source, GEvent event) { //_CODE_:helploader:633880:
  println("helploader - GButton event occured " + System.currentTimeMillis()%10000000 );
  mhelptext.setText(helper);
} //_CODE_:helploader:633880:



// Create all the GUI controls. 
// autogenerated do not edit

/**
*This function creats and loads backgrounds, pictures, buttons, etc... needed for startup
*/
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("MTOS");
  startButton = new GImageButton(this, 5, 0, 20, 20, new String[] { "MT_transparent_Logo.png", "MT_transparent_Logo.png", "MT_transparent_Logo.png" } );
  startButton.addEventHandler(this, "startButton_click1");
  startMenu = new GDropList(this, 1, 20, 222, 165, 3);
  startMenu.setItems(loadStrings("list_955860"), 0);
  startMenu.addEventHandler(this, "startMenu_click1");
  startMenu.setVisible(false);
  
  gallery1 = new GImageButton(this, 951, 86, 100, 100, new String[] { "Gallery1.png", "Gallery1.png", "Gallery1.png" } );
  gallery1.addEventHandler(this, "gallery1_click1");
  clickGameButton1 = new GImageButton(this, 827, 88, 100, 90, new String[] { "clickingimage.png", "clickingimage.png", "clickingimage.png" } );
  clickGameButton1.addEventHandler(this, "clickGameButton1_click1");
  musicplayerbutton = new GImageButton(this, 692, 78, 119, 108, new String[] { "musicplayericon.png", "musicplayericon.png", "musicplayericon.png" } );
  musicplayerbutton.addEventHandler(this, "musicplayerbutton_click1");
  calcButton = new GImageButton(this, 569, 83, 100, 90, new String[] { "calcicon.png", "calcicon.png", "calcicon.png" } );
  calcButton.addEventHandler(this, "calcButton_click1");
  mtextbutton1 = new GImageButton(this, 451, 86, 100, 93, new String[] { "mtexticon.png", "mtexticon.png", "mtexticon.png" } );
  mtextbutton1.addEventHandler(this, "mtextbutton1_click1");
  helpbutton = new GImageButton(this, 899, 544, 100, 94, new String[] { "questionamrk2.png", "questionamrk2.png", "questionamrk2.png" } );
  helpbutton.addEventHandler(this, "helpbutton_click1");
  
  loginWindow = new GWindow(this, "Login", 0, 0, 350, 150, false, JAVA2D);
  loginWindow.addDrawHandler(this, "loginWindow_draw1");
  label3 = new GLabel(loginWindow.papplet, 127, 9, 80, 28);
  label3.setText("Login");
  label3.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label3.setOpaque(false);
  label1 = new GLabel(loginWindow.papplet, 26, 51, 80, 21);
  label1.setText("Username:");
  label1.setOpaque(false);
  label2 = new GLabel(loginWindow.papplet, 25, 86, 80, 21);
  label2.setText("Password:");
  label2.setOpaque(false);
  userInput = new GTextField(loginWindow.papplet, 130, 51, 160, 20, G4P.SCROLLBARS_NONE);
  userInput.setOpaque(true);
  userInput.addEventHandler(this, "userInput_change1");
  passInput = new GTextField(loginWindow.papplet, 130, 87, 160, 20, G4P.SCROLLBARS_NONE);
  passInput.setOpaque(true);
  passInput.addEventHandler(this, "passInput_change1");
  loginbutton1 = new GButton(loginWindow.papplet, 256, 118, 80, 26);
  loginbutton1.setText("Login");
  loginbutton1.addEventHandler(this, "loginbutton1_click1");
 

}

// Variable declarations 
// autogenerated do not edit

// ICONS ON THE SCREEN
GImageButton startButton; 
GDropList startMenu; 
GImageButton gallery1; 
GImageButton clickGameButton1; 
GImageButton musicplayerbutton; 
GImageButton calcButton; 
GImageButton mtextbutton1; 
GImageButton helpbutton; 
///

///MBACK VARIABLES
GWindow background1;
GLabel backTitle; 
GImageButton backpic1; 
GImageButton backpic2; 
GImageButton backpic3; 
GImageButton backpic4; 
GImageButton backpic5; 
GImageButton backpic6; 
GImageButton backpic7; 
GImageButton backpic8; 
GImageButton backpic9; 
///

//LOGIN WINDOW
GWindow loginWindow;
GLabel label3; 
GLabel label1; 
GLabel label2; 
GTextField userInput; 
GTextField passInput; 
GButton loginbutton1; 
///

///CLICKGAME VARIABLES
GWindow clickGame;
GLabel title; 
GLabel clicked; 
GLabel timer; 
GButton clickButton; 
GTimer clickTimer; 
GWindow musicplayer;
GButton musicstopbutton; 
GButton musicplaybutton; 
GButton musicchooser; 
GButton reloadSong; 
GLabel labelsong; 
GLabel songname; 
GButton exitButton; 
///

//CALCULATOR BUTTONS AND TEXTBOXES
GWindow calculator;
GButton button1; 
GButton button2; 
GButton button3; 
GButton button4; 
GButton button5; 
GButton button6; 
GButton button7; 
GButton button8; 
GButton button9; 
GButton button0; 
GButton buttonequals; 
GButton buttondivide; 
GButton buttontimes; 
GButton buttonminus; 
GButton buttonplus; 
GButton clear; 
GTextField number1; 
GTextField symbol; 
GTextField number2; 
GTextField result; 
GLabel labelequals;
///

//TEXT APPLICATION
GWindow mtext;
GTextArea mtextarea1; 
GButton mtextloadbutton; 
GButton saveasmtext; 
GTextField mtextname; 
GLabel labelmtext; 
GTextField mtextExt; 
///

///MHELP
GWindow mhelp;
GTextArea mhelptext; 
GButton helploader; 
///
