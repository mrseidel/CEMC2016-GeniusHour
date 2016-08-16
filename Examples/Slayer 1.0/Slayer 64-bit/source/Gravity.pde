/*
Title: Gravity Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: A.Z, A.L, C.Z., G.L.
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
  void reset(){
    x = xStart;
  }
  void increment(){
    x++;
  }

  /*This method serves to give the current velocity of fall.
    @returns velocity of current character.
  */
  float getVel(){
      //temp = (-gravity * pow((x), 2));
     // temp = -gravity * log(x) * 10;
     temp = gravity * pow((x - h), 2) + k;
     if(temp >= displayHeight)return 0;
      return temp;

  }
}
