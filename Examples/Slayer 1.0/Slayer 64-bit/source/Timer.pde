/*
Title: Enemy Class
Version: Beta 1.0
Released: Jan. 9th, 2014
Authors: A.Z, A.L, C.Z., G.L.
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
  void start(){
    savedTime = millis();
  }

  /*This method stops the timers count.
  */
  void stop(){
    returnedTime = millis() - savedTime;
    savedTime = 0;
  }

  /*This method gets the current timer count.
    @returns returnedTime as the current timer count.
  */
  int getTime(){
    returnedTime = millis() - savedTime;
    return returnedTime;
  }

}
