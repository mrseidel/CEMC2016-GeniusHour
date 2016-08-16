class SpaceMan {
  //variables
  int [] position = new int  [2];
  int [] limitPosition = new int [2];
  PVector characterCoordinates;
  boolean moveUp, moveDown, moveLeft, moveRight;
  int health;

  //constructor
  SpaceMan(int positionX, int positionY, int cellSize) {
    position[0] = positionX;
    position[1] = positionY;
    limitPosition = position;
    characterCoordinates = new PVector(position[0] * cellSize, position[1] * cellSize);
    health = 30;
  }

  //methods
  void run(int cellSize) {
    update(cellSize);
    display(cellSize);
  }
  int [] getPosition() {
    return position;
  }
  int [] getLimitPosition() {
    return limitPosition;
  }
  void updatePosition(int moveToX, int moveToY) {
    limitPosition[0] = moveToX;
    limitPosition[1] = moveToY;
  }
  void display(int cellSize) {
    fill(0);
    text(health, characterCoordinates.x, characterCoordinates.y);
    fill(#FA9005);
    rect(characterCoordinates.x, characterCoordinates.y, cellSize, cellSize);
  }
  void update(int cellSize) {
    if (moveUp) {
      moveDown = false;

      characterCoordinates.y -= cellSize/5.5;
      if (characterCoordinates.y < limitPosition[1]*cellSize) {
        position[1] = limitPosition[1];
        characterCoordinates.y = position[1]*cellSize;
        moveUp = false;
      }
    } 
    if (moveDown) {
      moveUp = false;

      characterCoordinates.y += cellSize/5.5;
      if (characterCoordinates.y > limitPosition[1]*cellSize) {
        position[1] = limitPosition[1];
        characterCoordinates.y = position[1]*cellSize;
        moveDown = false;
      }
    } 
    if (moveRight) {
      moveLeft = false;

      characterCoordinates.x += cellSize/5.5;
      if (characterCoordinates.x > limitPosition[0]*cellSize) {
        position[0] = limitPosition[0];
        characterCoordinates.x = position[0]*cellSize;
        moveRight = false;
      }
    }
    if (moveLeft) {
      moveRight = false;

      characterCoordinates.x -= cellSize/5.5;
      if (characterCoordinates.x < limitPosition[0]*cellSize) {
        position[0] = limitPosition[0];
        characterCoordinates.x = position[0]*cellSize;
        moveLeft = false;
      }
    }
  }
  void up() {
    moveUp = true;
  }
  void down() {
    moveDown = true;
  }
  void left() {
    moveLeft = true;
  }
  void right() {
    moveRight = true;
  }

  // for detection
  boolean positionEquals(int xIndex, int yIndex) {
    if (position[0] == xIndex && position[1] == yIndex) return true;
    return false;
  }
  // for setting position when changing chunks
  void setPosition(int positionX, int positionY, int cellSize) {
    position[0] = positionX;
    position[1] = positionY;
    limitPosition[0] = positionX;
    limitPosition[1] = positionY;
    characterCoordinates.x = position[0] * cellSize;
    characterCoordinates.y = position[1] * cellSize;
  }
  //for translation of map when character moves
  PVector getCoordinates() {
    return characterCoordinates;
  }

  //taking damage
  void takeDamage(int damage) {
    health -= damage;
  }
}