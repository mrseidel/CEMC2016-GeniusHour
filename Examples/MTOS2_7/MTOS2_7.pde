/**
*Programmers' names: K.D., R.E., P.L.
*Day last updated: January 10th 2014
* Requires Processing 2.0 and some libraries installed (see IMPORTS section below)
*/

/**
*Links used:
*http://www.lagers.org.uk/g4p/ref/index.html
*http://processing.org/discourse/beta/num_1140107049.html
*http://amnonp5.wordpress.com/2012/01/28/25-life-saving-tips-for-processing/
*http://forum.processing.org/one/topic/minim-know-when-a-song-is-done.html
*http://code.compartmental.net/minim/examples/
*http://processing.org/discourse/beta/num_1140107049.html
*https://discussions.zoho.com/processing/topic/g4p-some-problems-with-windows-closing-and-the-event-management
*/

///IMPORTS
import com.onformative.yahooweather.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import g4p_controls.*;
import javax.swing.*;
//////


//MTEXT
String filename = "";
String filecontents = "";
String filesave = "";
///

///MHELP
String helper = "";
///

///STARTUP
Minim startup;
AudioPlayer start;
///

///MSONG
String song;
Boolean songreloadercount = false;
Minim minimtest;
AudioPlayer player1;
///

///MAIN WINDOW
PImage background;
PShape taskbar;
String app = "";
int x = 400;
int y = 400;
boolean locked = false;
String back1 = "Background.png";
int winx = -3000;
int winy = 25;
///

///Time Stuff
String hours = "";
String minutes = "";
String seconds = "";
String ampm = "";
float timeX = 100;
float dateX = 100;
////

YahooWeather conditions;
int city;
///

///LOGIN
int passloopcount = 0;
///



////Click Game
int clickedCount = 0;
int clickedTimer = 0;
///



//Calculator
boolean symbolcount = false;
///

/**
*This function reads the "woeid.txt" file in order to determine location
*/
public void woeidget(){
  String cityarr[] = loadStrings("woeid.txt");
  city = Integer.parseInt(cityarr[0]);
}

/**
*This function reads the "background.txt" file in order to determine background
*/
public void backg(){
  String backs[] = loadStrings("background.txt");
  for (int i = 0 ; i < 1; i++) {
  }
  background = loadImage(backs[0]);
}

/**
*This function reads the "help.txt" file in order to load the help text
*/
public void helpfunc(){
  String[] help = loadStrings("help.txt");
for (int i = 0 ; i < help.length; i++) {
  helper = helper + help[i] + "\n";
  println("yahooo");
}
}

/**
*This function sets up the program
*/
public void setup(){
  size(1100, 700, P2D);
  woeidget();
  backg();
  helpfunc();
  conditions = new YahooWeather(this,city,"c",30000);
  background(0);
  try {
  UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
}
catch (Exception e) {
  e.printStackTrace();
}
  taskbar = createShape(RECT,0,0,width,height/30);
  taskbar.setFill(color(#2E2F55));
  mainLoc();
  createGUI();
  customGUI();
  // Place your setup code here

}

/**
*This function repositions the main window
*/
public void mainLoc(){
  frame.setLocation(winx,winy);
}

/**
*This function draws the OS on the screen
*/
public void draw(){
  conditions.update();
  image(background,0,height/30,width,height);
  shape(taskbar);

  time();

  timeOver();
  textSize(16);
  fill(#FFFFFF);
  text("City: " + conditions.getCityName(),100,1,200,200);
  text("Temperature: " + conditions.getTemperature() + " °C", 275,1,200,200);

}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}

/**
*This function creats the time feature on the OS
*/
void time(){
  textSize(16);
  if (hour() > 12){
    hours = str(hour() - 12);
  }else if (hour() == 0){
    hours = "12";
  }else{
    hours = str(hour());
  }

  if ((hours.equals("10")) || (hours.equals("11")) || (hours.equals("12"))){
    timeX = width - 110;
    dateX = width - 100;
  }else{
    timeX = width - 100;
    dateX = width - 97;
  }

  if (minute() < 10){
    minutes = "0" + str(minute());
  }else{
    minutes = str(minute());
  }

  if (second() < 10){
    seconds = "0" + str(second());
  }else{
    seconds = str(second());
  }

  if (hour() >= 12){
    ampm = "PM";
  }else{
    ampm = "AM";
  }
  text(hours+":"+minutes+":"+seconds+" "+ampm,timeX,17);
}

/**
*This function shows the user the date as soon as the user hovers over the time
*/
void timeOver(){
  if (mouseX > width-100 && mouseX < width && mouseY > 0 && mouseY < 17){
    textSize(16);
    text(day()+"/"+month()+"/"+year(),dateX,40);
  }
}


/**
*This function detects when the mouse id dragged
*/
public void mouseDragged(){
 if (locked == true){
   x = mouseX - 50;
   y = mouseY - 50;
 }
}