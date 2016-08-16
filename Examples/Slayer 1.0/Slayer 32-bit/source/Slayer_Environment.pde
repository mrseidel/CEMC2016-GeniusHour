/*
Title: "Slayer" RPG, Environment
Version: 1.0
Authors: A.Z, A.L, C.Z., G.L.
*/
PImage charImg;
PImage backImg;
PImage house1;
PImage house2Stat;
PImage house2Pass;
int x = 100;
int y = 100;
int[] envX = new int[2];
int[] envY = new int[2];
int[] hei = new int[2];
int[] wid = new int[2];
int charHei = 50;
int charWid = 50;
int backX;
int backY;
int backX2;
int backY2;
int backLength;
int backXNew = 0;
int backYNew = 0;
int inc = 5;
boolean moveAllowed;
boolean envMoveAllowed;
int addImage = 0;
void setup(){
  size(displayWidth,displayHeight);
  charImg = loadImage("Pac_Right.png");
  backImg = loadImage("grass.png");
  house1 = loadImage("house.png");
  house2Stat = loadImage("stationary_House.png");
  house2Pass = loadImage("passable_House.png");
  String[] inputStr = loadStrings("testSave.txt");  //Saved position of PacMan from last game
  x = int(inputStr[0]);
  y = int(inputStr[1]);
  backX = x-1000;
  backY = y-1000;
  backX2 = x-1000;
  backY2 = y-1000 + 2000;
  backLength = 2000;
  envX[0] = int(inputStr[2]);
  envY[0] = int(inputStr[3]);
  envX[1] = envX[0] + 500;
  envY[1] = envY[0];
  hei[0] = 200;
  hei[1] = 150;
  wid[0] = 150;
  wid[1] = 150;
}

void draw(){
  background(255,255,255);
  image(backImg, backX, backY, backLength, backLength);
  image(backImg, backX2, backY2, backLength, backLength);
  image(house1, envX[0], envY[0], wid[0], hei[0]);
  image(house2Stat, envX[1], envY[1], wid[1], hei[1]);
  image(charImg, x, y, charWid, charHei);  //Draw PacMan
  image(house2Pass, envX[1], envY[1]-50, wid[1], 50);
}

void keyPressed(){
   moveAllowed = true;
   envMoveAllowed = true;
   if (key == 'w') {  //Up movement
     moveUp();
     charImg = loadImage("Pac_Up.png");
   }
   if (key == 's') {  //Down movement
     moveDown();
     charImg = loadImage("Pac_Down.png");
   }
   if (key == 'a') {  //Left movement
     moveLeft();
     charImg = loadImage("Pac_Left.png");
   }
   if (key == 'd') {  //Right movement
     moveRight();
     charImg = loadImage("Pac_Right.png");
   }
}

void moveUp(){
  if (y - inc <= 50){ //Environment movement case
    moveAllowed = false;  //If environment moves, automatic constraint on character movement
    for (int i = 0; i<envY.length; i++){
      if ((y-inc < envY[i] + hei[i]) && (y-inc>envY[i]) && (x +charWid > envX[i]) && (x < envX[i] + wid[i])) {  //Object Collision Testing
         envMoveAllowed = false;  //Environment movement collides with character, constrain movement
      }
    }
  } else if (y - inc > 50){   //Character movement case
    envMoveAllowed = false;  //If character moves, automatic constraint on environment movement
    for (int i = 0; i<envY.length; i++){
       if ((y-inc < envY[i] + hei[i]) && (y-inc>envY[i]) && (x +charWid > envX[i]) && (x < envX[i] + wid[i])) {  //Object Collision Testing
         moveAllowed = false;    //Character movement collides with environment, constrain movement
       }
     }
  }
  if (moveAllowed == true) {  //Character movement clear
    y -= inc;

  }
  if (envMoveAllowed == true) {  //Environment movement clear
    for (int i = 0; i<envY.length; i++){
      envY[i] += inc;
    }
    backY += inc;
    backY2 += inc;

  }
  moveBackgroundUp();
}

void moveDown(){
  if (y + 100 + inc > displayHeight - 50){ //Environment movement case
    moveAllowed = false;  //If environment moves, automatic constraint on character movement
    for (int i = 0; i<envY.length; i++){
      if  ((y+charHei+inc > envY[i]) && (y + charHei +inc < envY[i] + hei[i]) && (x +charWid > envX[i]) && (x < envX[i] + wid[i])){   //Object Collision Testing
         envMoveAllowed = false;  //Environment movement collides with character, constrain movement
      }
    }
  } else if (y + 100 + inc <= displayHeight - 50){   //Character movement case
    envMoveAllowed = false;  //If character moves, automatic constraint on environment movement
    for (int i = 0; i<envY.length; i++){
       if  ((y+charHei+inc > envY[i]) && (y + charHei +inc < envY[i] + hei[i]) && (x + charWid> envX[i]) && (x < envX[i] + wid[i])){ //Object Collision Testing
         moveAllowed = false;    //Character movement collides with environment, constrain movement
       }
     }
  }
  if (moveAllowed == true) {  //Character movement clear
    y += inc;

  }
  if (envMoveAllowed == true) {  //Environment movement clear
    for (int i = 0; i<envY.length; i++){
      envY[i] -= inc;
    }
    backY -= inc;
    backY2 -= inc;
  }
  moveBackgroundDown();
}
void moveLeft(){
  if (x - inc < 50){ //Environment movement case
    moveAllowed = false;  //If environment moves, automatic constraint on character movement
    for (int i = 0; i<envX.length; i++){
      if  ((x-inc < envX[i]+wid[i]) && (x-inc > envX[i])&& (y + charHei> envY[i]) && (y < envY[i]+hei[i])){   //Object Collision Testing
         envMoveAllowed = false;  //Environment movement collides with character, constrain movement
      }
    }
  } else if (x - inc >= 50){   //Character movement case
    envMoveAllowed = false;  //If character moves, automatic constraint on environment movement
    for (int i = 0; i<envX.length; i++){
       if  ((x-inc < envX[i]+wid[i]) && (x-inc > envX[i])&& (y + charHei> envY[i]) && (y < envY[i]+hei[i])){ //Object Collision Testing
         moveAllowed = false;    //Character movement collides with environment, constrain movement
       }
     }
  }
  if (moveAllowed == true) {  //Character movement clear
    x -= inc;
  }
  if (envMoveAllowed == true) {  //Environment movement clear
    for (int i = 0; i<envX.length; i++){
      envX[i] += inc;
    }
    backX += inc;
    backX2 += inc;
  }
  moveBackgroundLeft();
}
void moveRight(){
  if (x + 100 + inc > displayWidth - 50){ //Environment movement case
    moveAllowed = false;  //If environment moves, automatic constraint on character movement
    for (int i = 0; i<envX.length; i++){
      if ((x+charWid+inc>envX[i]) && (x +charWid+inc<envX[i] + wid[i]) && (y + charHei> envY[i]) && (y<envY[i]+hei[i])){   //Object Collision Testing
         envMoveAllowed = false;  //Environment movement collides with character, constrain movement
      }
    }
  } else if (x + 100 + inc <= displayWidth - 50){   //Character movement case
    envMoveAllowed = false;  //If character moves, automatic constraint on environment movement
    for (int i = 0; i<envX.length; i++){
       if ((x+charWid+inc>envX[i]) && (x +charWid+inc<envX[i] + wid[i]) && (y + charHei> envY[i]) && (y<envY[i]+hei[i])){ //Object Collision Testing
         moveAllowed = false;    //Character movement collides with environment, constrain movement
       }
     }
  }
  if (moveAllowed == true) {  //Character movement clear
    x += inc;
  }
  if (envMoveAllowed == true) {  //Environment movement clear
    for (int i = 0; i<envX.length; i++){
      envX[i] -= inc;
    }
    backX -= inc;
    backX2 -= inc;
  }
  moveBackgroundRight();
}

void moveBackgroundUp(){
    if (y +charHei <= backY){
      backY2 = backY;
      backY = backY2 - backLength;
    } else if (y +charHei <= backY + 100){
      backX2 = backX;
      backY2 = backY - backLength;
    }

}
void moveBackgroundDown(){
    if (y  >= backY+backLength){
      backY2 = backY;
      backY = backY2 + backLength;
    } else if (y >= backY+backLength-100){
      backX2 = backX;
      backY2 = backY + backLength;
    }

}
void moveBackgroundLeft(){
    if (x + charWid <= backX){
      backX2 = backX;
      backX = backX2 - backLength;
    } else if (x +charWid <= backX+100){
      backY2 = backY;
      backX2 = backX - backLength;
    }

}
void moveBackgroundRight(){
    if (x >= backX+backLength){
      backX2 = backX;
      backX = backX2 + backLength;
    } else if (x >= backX+backLength-100){
      backY2 = backY;
      backX2 = backX + backLength;
    }

}

void exit(){
  String[] save = {str(x), str(y), str(envX[0]), str(envY[0])};  //Save position of PacMan and Environment
  saveStrings("testSave.txt", save);
  super.exit();
}
