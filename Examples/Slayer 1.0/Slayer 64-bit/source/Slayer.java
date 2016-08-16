import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Slayer extends PApplet {

/*
Title: Slayer Main Frame
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: A.Z, A.L, C.Z., G.L.
*/

//Declaring image object identifiers
PImage charImg;
PImage[] charRunLeft = new PImage[6];
PImage[] charRunRight = new PImage[6];
PImage[] charAttackLeft = new PImage[6];
PImage[] charAttackRight = new PImage[6];
PImage charStand[] = new PImage[2];  // 1 = true, 0 = false
PImage charAttack;
PImage backImg;
PImage house;
PImage ground;
PImage tree;
PImage platform;
PImage finishLine;

//Declaring character positioning identifiers
int x,y = 100;
int t = -15;
int inc = 20;
int charHei = 150;
int charWid = 100;
boolean attackRight = false;
boolean attackLeft = false;
int attackTimeCounter = 0;
boolean jump = false;
boolean fall = false;
boolean fallMovementDisabled = false;
boolean moveAllowed;
boolean envMoveAllowed;
int xvelL, xvelR, vel = 20; // Change Vel to change speed
timer Tanim = new timer();
timer Tjump = new timer();
gravity Gjump = new gravity(-9.8f, 3, 100); // change value for jump height
gravity Gfall = new gravity(0.1f, 0, 0);
boolean charLeft = true;
boolean run[] = {false, false};
boolean upCollision = false;
int yvel = 0;
int jumpHeight = 30;
int i = 0;
box MC = new box(x,y, charHei, charWid);
box MCCC[] = new box[4]; //MC collision Check
int j = 0;
int side = -1;

//Declaring game variables
int progress = 0;
String gameOverText;
boolean gameOver = false;
boolean gameMenu = true;
static int score = 0;

//Declaring environment identifiers
//Environment x and y's are for PLATFORMS
//Environment wid and height are for ENVIRONMENT OBJECTS
int platforms = 9;
int[] envX = new int[platforms];
int[] envY = new int[platforms];
int[] hei = new int[platforms];
int[] wid = new int[platforms];
int frame = 0;
int envVel;
boolean screenCollision[] = {false, false};
boolean tileCollision[] = {false, false};
int plats[][] = new int[8][4];
int tileWid = 54;
int tileHig = 54;
box tile = new box(0, 600, tileHig, tileWid);
box floor;
int numTiles = 10*(platforms-1);
box tiles[] = new box[numTiles + platforms];
boolean collision[] = {false, false, false, false}; // right, left, up, down

//Declaring enemy and combat variables
enemy[] newPacMan= new enemy[platforms];
box[] pacManBox = new box[platforms];
box attackBox = new box(MC.x, MC.y, MC.h, MC.w);
int MCHealth = 100;
int addH =0;
int addW=0;
int addX=0;
int addY=0;
int charDamage = 40;
int enemyDamage = (int)200/(platforms-1);
boolean MCFlash = false;
boolean attackAnimation = false;
boolean enemyAlreadyDamaged = false;
boolean[] enemyOnPlatform = new boolean[platforms];
timer tFlash = new timer();
timer tHitResist = new timer();
timer tAttackAnimation = new timer();

/*The setup method is responsible for prearranging and initializing all variables and objects to be used during the game.
  This method runs once, at the beginning of launch, and whenever it is called.
*/
public void setup(){
  size(displayWidth, displayHeight);

  //Initializing character image identifiers.
  charStand[0] = loadImage("Character/RightStand.png");
  charStand[1] = loadImage("Character/LeftStand.png");
  charImg = charStand[0];
  for (int i = 1; i<=6; i++){
    charRunLeft[i-1] = loadImage("Character/Left" +i+".png");
    charRunRight[i-1] = loadImage("Character/Right" +i+".png");
    charAttackLeft[i-1] = loadImage("Character/swingLeft" +(i-1)+".png");
    charAttackRight[i-1] = loadImage("Character/swing" +(i-1)+".png");
  }

  //Initializing environment image identifiers.
  backImg = loadImage("Environment/Background.png");
  tree = loadImage("Environment/Tree.png");
  house =  loadImage("Environment/House.png");
  ground = loadImage("Environment/Ground.png");
  platform = loadImage("Environment/Tile.png");
  finishLine = loadImage("Environment/FinishLine.png");

  //Initializing environment positioning
  for (int i = 0; i<platforms;i++){
    envX[i] = 100 + i*(displayWidth+(int)displayWidth/7);
    envY[i] = displayHeight-(int)displayHeight/6;
    enemyOnPlatform[i] = false;
  }

  //Initializing character positioning.
  MC.y = displayHeight - (int)displayHeight/6 -charHei;
  MC.x = envX[0]+100;
  hei[0] = 400;
  hei[1] = 700;
  wid[0] = 300;
  wid[1] = 700;

  //4 collision boxes for MC, used for efficiency through loops
  MCCC[0] = new box(0,0, charHei/2, charWid/2);
  MCCC[1] = new box(0,0, charHei/2, charWid/2);
  MCCC[2] = new box(0,0, charHei/4, charWid/2);
  MCCC[3] = new box(0,0, charHei/4, charWid/2);
  MCCollisionInit();

  //Creating instance of enemy on first platform
  createNewEnemy(0);

  //Initializing ground and float platforms.
  //First numTiles of tiles[] are for the floaters, rest are for the ground
  for(i = 0; i < numTiles; i++)tiles[i] = new box ((int)random(envX[0],envX[platforms-2]+displayWidth), (int)random(charHei,envY[0]+tileHig), tileHig, tileWid);
  for(i = numTiles; i<platforms+numTiles; i++)tiles[i] = new box(envX[i-numTiles], displayHeight - (int)displayHeight/6, (int)displayHeight/6, displayWidth); //FLOOR

  //Initializing game variables.
  gameOverText = "GAME OVER.";
  textAlign(TOP, RIGHT);
  gameMenu = true;
  //Start animation timers.
  frameRate(100);
  Tanim.start();
  tHitResist.start();
}

/*The draw method serves as the main method of the software, and calls all other functions for calculations and displaying of data.
  This method runs as a natural loop.
*/
public void draw(){
  if (gameMenu == true){
    //Screen to load startup menu.
    image(backImg, 0,0,displayWidth,displayHeight);
    textAlign(CENTER,CENTER);
    textSize(100);
    fill(0,0,0);
    String instructions = "Press a/w/d to move, and click the left/right mouse button to attack. \nTry to reach the goal at the right end of the game map without falling off platforms or taking too much damage.";
    text("SLAYER",displayWidth/2,(int)displayHeight/3);
    textSize(40);
    text("Press 'v' to begin.", displayWidth/2, displayHeight/2);
    textSize(20);
    fill(255,255,255);
    text(instructions, displayWidth/2, (int)5*displayHeight/6);

    //Credits
    textSize(14);
    fill(0,0,0);
    textAlign(LEFT,TOP);
    String credits = "Completed for Mr.Seidel's ICS4U0 course.\n\nCreated by:\nAmy Zeng\nAllen Ly\nClarice Zhu\nGary Lin";
    text(credits,0,0);

    //Check for game start command.
    if (key== 'v' || key == 'V')gameMenu=false;

  } else {
    //Game is in progress.
    if (gameOver == false){
      background(0, 255, 255);
      setGradient(color(0,0,100), color(0,255,255));

      //Updates the box coordinates of all enemies
      enemyBoxUpdate();
      move(); //movements and changes made
      collision(); //new position checked for collision, changes made if collisions detected
      animate(); //frames shown
      for (int i = 0; i<platforms;i++){
        if (enemyOnPlatform[i] == true)newPacMan[i].animate(envX[i], envX[i]+displayWidth);
      }

    //Game over screen is displayed.
    } else{
      image(backImg, 0,0,displayWidth,displayHeight);
      textSize(40);
      textAlign(CENTER, CENTER);
      text("Score: " + score,displayWidth/2, (int)displayHeight/3);
      textSize(54);
      text(gameOverText,displayWidth/2, displayHeight/2);
      text("Press 'v' to restart.",displayWidth/2, displayHeight/2+50);
      //Request to restart obtained.
      if (key=='v' || key =='V'){
        gameOver = false;
        MCHealth = 100;
        progress =0;
        score=0;
        setup();
      }
    }
  }
}

/*This method updates the collision box of the enemy to match the randomly moving object of the enemy.
*/
public void enemyBoxUpdate(){
  for (int i = 0; i<platforms;i++){
    if (enemyOnPlatform[i] == true)pacManBox[i].x = newPacMan[i].x;
    if (enemyOnPlatform[i] == true)pacManBox[i].y = newPacMan[i].y;
  }
}

/*This method creates a new enemy object and box on the new platform, as it is called only when player reaches a new platform.
  @param i as the ith platform and therefore ith enemy.
*/
public void createNewEnemy(int i){
  newPacMan[i] = new enemy(envX[i]+500, envY[i] - 100, 100,100);
  pacManBox[i] = new box(envX[i]+500, envY[i] - 100, 100, 100);
  newPacMan[i].enemyLeft = loadImage("Character/Pac_Left.png");
  newPacMan[i].enemyRight = loadImage("Character/Pac_Right.png");
  newPacMan[i].enemyImg = newPacMan[i].enemyRight;
  enemyOnPlatform[i] = true;
}

/*This method checks for collision of the main character with any environment box.
  @param tile is the box of which collision must be checked.
  @return side of collision
*/
public int MCCollisionCheck(box tile){
  for(j = 3; j >=0; j--)if(MCCC[j].cc(tile) == true)return j;
  return -1;
}

/*This method initializes the collision box set for the main character.
*/
public void MCCollisionInit(){
 MCCC[0].y = MC.y + MC.h/4;
 MCCC[0].x = MC.x;
 MCCC[1].x = MC.x + MC.w/2;
 MCCC[1].y = MC.y + MC.h/4;
 MCCC[2].x = MC.x + MC.w/4;
 MCCC[2].y = MC.y;
 MCCC[3].x = MC.x + MC.w/4;
 MCCC[3].y = (MC.y + MC.h) - (MC.h/4);
}

/*This method is the main collision control.
*/
public void collision(){

   for(int i = 0; i < 4; i++)collision[i] = false;
   MC.h-=2;
   //Collision check for each ground and float platform
   for(int i = 0; i < numTiles + platforms; i++){
     if(MC.cc(tiles[i]) == true){
      MCCollisionInit();
      side = MCCollisionCheck(tiles[i]);
      if(side != -1)collision[side] = true;
      if(side == 3)MC.y = tiles[i].y - MC.h;
     }
   }
   MC.h+=2;
   //Enemy Collision
   //After getting hit by enemy, player has 2 seconds of invincibility from hits
   if (tHitResist.getTime() >=2000){
     tHitResist.stop();
     tFlash.stop();
     MCFlash = false;
     for (int i = 0; i<platforms;i++){
       if (enemyOnPlatform[i] == true){
         if (MC.cc(pacManBox[i]) == true){
           //Damage from enemy contact
           MCHealth -=enemyDamage;
           score-=10;
           tHitResist.start();
           tFlash.start();
           MCFlash = true;
           if (MCHealth <=0)gameOver = true;
         }
       }
     }
   }
   //Screen collision, which moves environment instead of character.
   if(MC.x <= (int)displayWidth/6){
      MC.x -= xvelL;
      screenCollision[1] = true;
   }else screenCollision[1] = false;
   if(MC.x >= (displayWidth - (int)displayWidth/6)){
      MC.x -= xvelR;
      screenCollision[0] = true;
   }else screenCollision[0] = false;

   if(collision[0] == true)MC.x += vel;
   if(collision[1] == true)MC.x += -vel;
   if(collision[2] == true){
     MC.y -= yvel;
     yvel=0;
   }
   if(collision[3] == true){
     Gfall.reset();
     fall = false;
     jump = false;
     yvel=0;
   }else if(collision[3] == false ||fall == true){ // FALL IS TRUE
     yvel += Gfall.getVel();
     Gfall.increment();
   }
   if(jump == true)fall = true;
   jump = false;
}

/*This method updates the position variables of all objects involved with movement.
*/
public void move(){
  MC.x += xvelL;
  MC.x += xvelR;
  MC.y += yvel;
  //Screen collision with right side
  if((screenCollision[1] == true) && (run[1] == true) && (collision[1] == false)){
    for(i = 0; i < platforms+numTiles; i++)tiles[i].x += vel; //LEFT
    for (int i = 0; i<platforms;i++){
      if (enemyOnPlatform[i] == true)newPacMan[i].x +=vel;
      envX[i] += vel;
    }
  }
  //Screen collision with left side
  if((screenCollision[0] == true) && (run[0] == true) && (collision[0] == false)){
    for(i = 0; i < platforms+numTiles; i++)tiles[i].x += -vel; //LEFT
    for (int i = 0; i<platforms;i++){
      if (enemyOnPlatform[i] == true)newPacMan[i].x +=-vel;
      envX[i] += -vel;
    }
  }
}

/*This method serves as the background code for animating and calibrating the attack.
*/
public void animateAttack(){
   if (attackAnimation == true){
     if (charLeft == true){
        //moved most of code to mousepressed
       if(tAttackAnimation.getTime() >=600){
         enemyAlreadyDamaged = false;
         charImg = charStand[PApplet.parseInt(charLeft)];
         tAttackAnimation.stop();
         attackAnimation = false;
       }else{
         charImg = charAttackLeft[(int)tAttackAnimation.getTime()/100];
       }
     } else {
       if(tAttackAnimation.getTime() >=600){
         charAttack = charStand[PApplet.parseInt(!charLeft)];
         enemyAlreadyDamaged = false;
         tAttackAnimation.stop();
         attackAnimation = false;
       }else{
         charImg = charAttackRight[(int)tAttackAnimation.getTime()/100];
       }
     }
   }
}

/*This method does the literal redraw of objects on the screen
*/
public void animate(){
  //Running
   if(run[0] == true)charLeft = false;
   else if (run[1] == true)charLeft = true;
   //Standing
   if(run[0] == false && run[1] == false)charImg = charStand[PApplet.parseInt(charLeft)];
   else if(fall == false)
   {
     if(Tanim.getTime() >959)Tanim.start();
     frame = Tanim.getTime()/160;
     if(jump == false){
       if(charLeft == true){
           charImg = charRunLeft[frame];
       }else if (charLeft == false){
         charImg = charRunRight[frame];
       }
     }
   }

   //Checking to spawn new enemy, update progress bar and add score
   for (int i = 0; i<platforms;i++){
     if (MC.x >= envX[i]){
       if (enemyOnPlatform[i] == false){
          createNewEnemy(i);
          score+=20;
          progress +=1;
       }
     }
   }

   //Call for the attack animation.
   animateAttack();

   //Environment drawing
   for (int i=0; i<platforms-1;i++)image(house,envX[i] + 200, displayHeight - (int)displayHeight/6 - hei[1] +10, wid[1], hei[1]);
   for (int i = 0; i<platforms-1; i++){
     for(int j =0; j<4;j++)image(tree,envX[i] + 100 + j*500, displayHeight - (int)displayHeight/6 - hei[0] +10, wid[0], hei[0]);
   }
   for( int i = 0; i < numTiles; i++)image(platform, tiles[i].x,tiles[i].y,tiles[i].w, tiles[i].h);
   for (int i = numTiles; i < platforms+numTiles;i++) image(ground, tiles[i].x, tiles[i].y-30, displayWidth, (int)displayHeight/6+30);
   image(finishLine, envX[platforms-1]+10,envY[platforms-1]-190,100,200);

   //Character drawing, along with possible flashing after being attacked
   if(MCFlash == true && ((tFlash.getTime()/100) % 2 == 0)){
   }else{
       if(attackAnimation == true){
         if (charLeft ==true)image(charImg, MC.x - 210, MC.y- 170, MC.w + 210, MC.h + 170);
         else image(charImg, MC.x, MC.y- 170, MC.w + 210 , MC.h + 170);
       }else{
           image(charImg, MC.x, MC.y, MC.w, MC.h);
       }
  }

   //Drawing and color coding for the health bar
   fill(0,0,0);
   stroke(255);
   rect(MC.x, MC.y -20,100,15);
   fill(0,255,0);
   if (MCHealth <50)fill(255,255,0);
   if (MCHealth <30)fill(255,150,0);
   if (MCHealth <10)fill(255,0,0);
   rect(MC.x, MC.y -20,MCHealth,15);

   //Displaying GUI for progress and score
   fill(255,255,255);
   textSize(32);
   textAlign(LEFT,CENTER);
   text("Progress Bar",50,50);
   fill(0,0,0);
   rect(50,80,(platforms-1)*50,20);
   fill(0,255,0);
   rect(50,80,progress*50,20);
   fill(255,255,255);
   textAlign(RIGHT,TOP);
   if (score<0)score=0;
   text("Score: " + score, displayWidth -50, 50);

   //Game won.
   if ((platforms-1)*50==progress*50){
     gameOver=true;
     gameOverText = "YOU WIN!";
     fill(0,255,0);
   }
   //Game lost.
   if (MC.y>displayHeight){
     gameOver = true;
     fill(255,0,0);
   }

}

/*This function serves to stop the character's run function.
*/
public void keyReleased(){
    if(key == 'a' || key == 'A'){
        run[1] = false;
        xvelL = 0;
    }else if(key == 'd' || key == 'D'){
        run[0] = false;
        xvelR = 0;
    }
}

/*This function serves to grab input from the user, which allows running and jumping
*/
public void keyPressed(){
  if (attackAnimation == false){
    if(key == 'a' || key == 'A'){
        run[1] = true;
        xvelL = -vel;
    }else if(key == 'd' || key == 'D'){
        run[0] = true;
        xvelR = vel;
    }
    if(key == 'w' || key == 'W'){
       if(Tjump.getTime() >=800){ // can only activate jump after one second
       Tjump.start();
       jump = true;
       yvel = -jumpHeight;
      }
    }
  }
}

/*This method that handles the initiation for attack mechanics and animations
*/
public void mousePressed(){
  if (attackAnimation ==false){
    attackTimeCounter = 0;
    attackAnimation = true;
    tAttackAnimation.start();

    if (charLeft == true){ // left
      attackLeft = true;
      attackBox.x = MC.x - MC.w-(int)1.3f*MC.w;
      attackBox.w = MC.w + (int)1.3f*MC.w;
      attackBox.y = MC.y;
    } else { // right
      attackRight = true;
      attackBox.x = MC.x + MC.w;
      attackBox.w = MC.w + (int)1.3f*MC.w;
      attackBox.y = MC.y;

    }
    if (enemyAlreadyDamaged == false){
      for (int i = 0; i<platforms;i++){
        if (enemyOnPlatform[i] == true){
          if (attackBox.cc(pacManBox[i]) == true){
            newPacMan[i].health -=charDamage;
            score+=10;
            enemyAlreadyDamaged = true;
          }
        }
      }
    }
  }
}

/*This method creates a linear, vertical color gradient.
  @param c1 as the first color.
  @param c2 as the second color.
*/
public void setGradient(int c1, int c2) {
  noFill();
    for (int i = 0; i <= displayHeight - (int)displayHeight/6; i++) {
      float inter = map(i, 0, displayHeight +- (int)displayHeight/6, 0, 1);
      int c = lerpColor(c1, c2, inter);
      stroke(c);
      line(0, i, displayWidth, i);
    }
}
/*
Title: Box Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: Amy Zeng, Allen Ly, Clarice Zhu, Gary Lin
*/

/*This class serves to create a box to detect collision.
*/
class box{
  int x,y,h,w;
  /*The constructor of the class.
    @param x as the x coordinate of the top left corner of the box.
    @param y as the y coordinate of the top left corner of the box.
    @param h as the height of the box.
    @param w as the width of the box.
  */
  box(int x, int y, int h, int w){
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }

  /*Collision checking with this box and any input box.
    @param box as the input box to check collision with.
    @returns true or false as the collision status.
  */
  public boolean cc(box box){
    if(((box.y + box.h) >= this.y && (box.y + box.h) <= (this.y + this.h)) ||
    (box.y <= this.y && (box.y + box.h) >= (this.y + this.h)) ||
    (box.y >= (this.y) && (box.y + box.h) <= (this.y + this.h)) ||
    (box.y >= this.y && box.y <= (this.y +this.h))
    ){
       if(((box.x + box.w) >= this.x && (box.x + box.w) <= (this.x + this.w)) ||
       (box.x <= (this.x + this.w) && box.x >= this.x) ||
       (this.x <= box.x && (this.x + this.w) >= (box.x + box.w)) ||
       (this.x >= box.x && (this.x + this.w) <= (box.x + box.w))

       )return true;
    }
    return false;
  }
}
/*
Title: Enemy Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: Amy Zeng, Allen Ly, Clarice Zhu, Gary Lin
*/

/*This class initializes an enemy, also know as pac man.
*/
class enemy{
  PImage enemyLeft; //Declaring enemy object and position identifiers
  PImage enemyRight;
  PImage enemyImg;
  int x, y, w, h;
  int inc = 10;
  int directionDelay = 100;
  int health = 100;
  boolean dead = false;
  /*The constructor of the class.
    @param x as the x coordinate of the top left corner of the enemy.
    @param y as the y coordinate of the top left corner of the enemy.
    @param w as the width of the enemy.
    @param h as the height of the enemy.
  */
  enemy(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  /*This method updates the positions and redraws the enemy.
  */
  public void animate(int lowerX, int higherX){
    if (health<=0){
      this.dead =true;
      Slayer.score+=15;
      //Brings the dead enemy off screen so that contact cannot be made between the invisible enemy and the MC
      this.x = -100;
      this.y = -100;
      //Done solely for efficiency of not having to run the inside of this if statement every loop
      this.health = 1;
    }
    if (dead == false){
      this.directionDelay -=1;
      //Two situations to change direction, either object reaches one of the ends of the platform, or the randomly generated length of travel in one direction has run out.
      if (this.directionDelay<=0){
        directionChange();
      }
      if (( this.x+this.w+this.inc > higherX) || (this.x + this.inc < lowerX)){
        directionChange();
      }
      this.x+=this.inc;
      //Drawing enemy health bars
      fill(0,0,0);
      stroke(255);
      rect(this.x, this.y -20,100,15);
      fill(0,255,0);
      if (health <50)fill(255,255,0);
      if (health <30)fill(255,150,0);
      if (health <10)fill(255,0,0);
      rect(this.x, this.y -20,health,15);
      //Drawing the enemy
      image(enemyImg,this.x,this.y,this.w,this.h);

    }
  }

  /*This method changes the direction of the enemy movement.
  */
  public void directionChange(){
    //Changing direction is random.
    directionDelay = (int)random(20,displayWidth);
    this.inc = -this.inc;
    if (inc<0){
      enemyImg = enemyLeft;
    } else {
      enemyImg = enemyRight;
    }
  }


}
/*
Title: Gravity Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: Amy Zeng, Allen Ly, Clarice Zhu, Gary Lin
*/

/*This class serves to apply gravity to the main character.
*/
class gravity{
 float gravity, x;
 float xStart = 1;
 float temp;
 float h, k;

/*The constructor of the class.
  @param acceleration as the d/s^2 value.
  @param h as the horizontal displacement.
  @param k as the vertical displacement.
*/
 gravity(float acceleration, float h, float k){
    this.gravity = acceleration; // 9.8 m/s^2
    x = xStart;
    this.h = h;
    this.k = k;
  }
  public void reset(){
    x = xStart;
  }
  public void increment(){
    x++;
  }

  /*This method serves to give the current velocity of fall.
    @returns velocity of current character.
  */
  public float getVel(){
      //temp = (-gravity * pow((x), 2));
     // temp = -gravity * log(x) * 10;
     temp = gravity * pow((x - h), 2) + k;
     if(temp >= displayHeight)return 0;
      return temp;

  }
}
/*
Title: Enemy Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: Amy Zeng, Allen Ly, Clarice Zhu, Gary Lin
*/

/*This class serves as a timer and records the start and stop times of various actions or functions.
*/
class timer{
 int savedTime, returnedTime;

 /*The constructor of the class.
 */
  timer(){
    savedTime = 0;
    returnedTime = 0;
  }

  /*This method starts the timer's count.
  */
  public void start(){
    savedTime = millis();
  }

  /*This method stops the timers count.
  */
  public void stop(){
    returnedTime = millis() - savedTime;
    savedTime = 0;
  }

  /*This method gets the current timer count.
    @returns returnedTime as the current timer count.
  */
  public int getTime(){
    returnedTime = millis() - savedTime;
    return returnedTime;
  }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "Slayer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
