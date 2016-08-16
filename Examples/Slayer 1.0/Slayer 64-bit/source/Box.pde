/*
Title: Box Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: A.Z, A.L, C.Z., G.L.
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
  boolean cc(box box){
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
