/*
Title: Enemy Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: A.Z, A.L, C.Z., G.L.
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
  void animate(int lowerX, int higherX){
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
  void directionChange(){
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
