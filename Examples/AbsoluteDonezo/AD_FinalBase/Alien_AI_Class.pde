//Ai class //still needs to implement colors

class Alien {

  final int maxHealth;
  final int maxSleep;
  final int maxHunger;

  int health;
  int sleep;
  int hunger;
  int gender;
  int lifespan;

  String Type;

  String [] natures = {"aggressive", "timid", "lazy", "hungry", "greedy", "explosive"};
  String nature;
  String [] types = {"AlienOne", "AlienTwo", "AlienThree", "AlienFour"};
  String type;
  String [] characteristicsOne = {"none", "horns", "ears", "brain"};
  String [] characteristicsTwo = {"none", "spikey", "furry", "armoured"};
  String [] characteristicsThree = {"none", "tail", "tusks", "claws"};
  String characteristicOne;
  String characteristicTwo;
  String characteristicThree;
  String [] genes = new String[9]; // Health, Gender, lifespan, nature, type, colour, characteristic, characteristic, characteristic

  boolean sleeping, lookingForFood, attacking, threatened, dead;

  int min = 4;
  int enough = 12;
  int updateCycle = int(random(200));

  int [] position = new int  [2];
  int [] limitPosition = new int [2];
  PVector alienCoordinates;
  boolean moveUp, moveDown, moveLeft, moveRight;

  Alien() {
    limitPosition = position;
    nature = natures[int(random(natures.length))];

    maxHealth = int(random(8, 30));
    maxSleep = 20;
    if (nature.equals("aggressive")) {
      maxHunger = 9;
    } else {
      maxHunger = 20;
    }

    health = int(random(maxHealth * .75, maxHealth));
    sleep = int(random(maxSleep * .75, maxSleep));
    hunger = int(random(maxHunger * .75, maxHunger));
    gender = floor(random(2));
    lifespan = int(random(10, 15));

    type = types[int(random(types.length))];
    characteristicOne = characteristicsOne[int(random(characteristicsOne.length))];
    characteristicTwo = characteristicsTwo[int(random(characteristicsTwo.length))];
    characteristicThree = characteristicsThree[int(random(characteristicsThree.length))];

    genes[0] = str(maxHealth);      //health
    genes[1] = str(gender);         //gender
    genes[2] = str(lifespan);       // lifespan
    genes[3] = nature;              //nature
    genes[4] = type;                //type
    genes[5] = null;                //colour
    genes[6] = characteristicOne;
    genes[7] = characteristicTwo;
    genes[8] = characteristicThree;
  }

  Alien(int [] position, int cellSize) {

    this.position = position;
    limitPosition  = position;
    alienCoordinates = new PVector(position[0]*cellSize, position[1]*cellSize);
    nature = natures[int(random(natures.length))];

    maxHealth = int(random(8, 30));
    maxSleep = 20;
    if (nature.equals("aggressive")) {
      maxHunger = 9;
    } else {
      maxHunger = 20;
    }

    health = int(random(maxHealth * .75, maxHealth));
    sleep = int(random(maxSleep * .75, maxSleep));
    hunger = int(random(maxHunger * .75, maxHunger));
    gender = floor(random(2));
    lifespan = int(random(10, 15));

    type = types[int(random(types.length))];
    characteristicOne = characteristicsOne[int(random(characteristicsOne.length))];
    characteristicTwo = characteristicsTwo[int(random(characteristicsTwo.length))];
    characteristicThree = characteristicsThree[int(random(characteristicsThree.length))];

    genes[0] = str(maxHealth);      //health
    genes[1] = str(gender);         //gender
    genes[2] = str(lifespan);       // lifespan
    genes[3] = nature;              //nature
    genes[4] = type;                //type
    genes[5] = null;                //colour
    genes[6] = characteristicOne;
    genes[7] = characteristicTwo;
    genes[8] = characteristicThree;
  }

  Alien(String [] femaleParentGenes, String [] maleParentGenes, int[] position, int cellSize) {

    this.position = position;
    limitPosition = position;
    alienCoordinates = new PVector(position[0]*cellSize, position[1]*cellSize);

    Alien alien = new Alien();
    String [] mutations = alien.getGeneticCode();

    for (int i = 0; i < genes.length; i++) {
      int parent = floor(random(3));

      if (parent == 0) {
        // femaleParentGenes
        genes[i] = femaleParentGenes[i];
      } else if (parent == 1) {
        // maleParentGenes
        genes[i] = maleParentGenes[i];
      } else {
        genes[i] = mutations[i];
      }
    }

    //
    for (int i = 0; i < genes.length; i++) println(femaleParentGenes[i]);
    println("");
    for (int i = 0; i < genes.length; i++) println(maleParentGenes[i]);
    println("");

    for (int i = 0; i < genes.length; i++) println(getGeneticCode()[i]);


    //fix later
    genes[5] = null;

    maxHealth = Integer.parseInt(genes[0]);
    maxSleep = 10;
    maxHunger = 10;

    health = int(random(maxHealth * .75, maxHealth));
    sleep = int(random(maxSleep * .75, maxSleep));
    hunger = int(random(maxHunger * .75, maxHunger));
    gender = floor(random(2));
    lifespan = Integer.parseInt(genes[2]);

    nature = genes[3];
    type = genes[4];
    characteristicOne = genes[6];
    characteristicTwo = genes[7];
    characteristicThree = genes[8];
  }

  //int of environment
  void update() {
    //{"aggressive", "timid", "greedy"}

    updateCycle += 1;

    if (updateCycle%41 == 20 && sleeping == false|| updateCycle%41 == 40 && sleeping == false) {
      if (sleep >= 0) sleep -= 1;
    }
    if (updateCycle%41 == 10 && sleeping == false && nature.equals("lazy")||updateCycle%41 == 30 && sleeping == false && nature.equals("lazy")) {
      if (sleep >= 0) sleep -= 1;
    }
    if (updateCycle%41 == 10 && sleeping == false|| updateCycle%41 == 20 && sleeping == false
      ||updateCycle%41 == 30 && sleeping == false|| updateCycle%41 == 40 && sleeping == false) {
      if (hunger >= 0) hunger -= 1;
    }
    if (updateCycle%41 == 15 && sleeping == false && nature.equals("hungry")|| updateCycle%41 == 25 && sleeping == false && nature.equals("hungry")
      || updateCycle%41 == 15 && sleeping == false && nature.equals("explosive")|| updateCycle%41 == 25 && sleeping == false && nature.equals("explosive")) {
      if (hunger >= 0) hunger -= 1;
    }
    if (nature.equals("explosive")) sleep = maxSleep;
    if (nature.equals("timid")) threatened = false;
  }

  void movementUpdate(int cellSize) {
    if (moveUp) {
      moveDown = false;

      alienCoordinates.y -= cellSize/5.5;
      if (alienCoordinates.y < limitPosition[1]*cellSize) {
        position[1] = limitPosition[1];
        alienCoordinates.y = position[1]*cellSize;
        moveUp = false;
      }
    } 
    if (moveDown) {
      moveUp = false;

      alienCoordinates.y += cellSize/5.5;
      if (alienCoordinates.y > limitPosition[1]*cellSize) {
        position[1] = limitPosition[1];
        alienCoordinates.y = position[1]*cellSize;
        moveDown = false;
      }
    } 
    if (moveRight) {
      moveLeft = false;

      alienCoordinates.x += cellSize/5.5;
      if (alienCoordinates.x > limitPosition[0]*cellSize) {
        position[0] = limitPosition[0];
        alienCoordinates.x = position[0]*cellSize;
        moveRight = false;
      }
    }
    if (moveLeft) {
      moveRight = false;

      alienCoordinates.x -= cellSize/5.5;
      if (alienCoordinates.x < limitPosition[0]*cellSize) {
        position[0] = limitPosition[0];
        alienCoordinates.x = position[0]*cellSize;
        moveLeft = false;
      }
    }
  }

  boolean isDead() {
    return dead;
  }

  void restoreHunger() {
    hunger = maxHunger;
    lookingForFood = false;
    println("found food, finished eating");
  }

  void wakeUp() {
  }

  String [] getGeneticCode() {
    return genes;
  }

  String getNature() {
    return nature;
  }

  int getGender() {
    return gender;
  }
  void takeDamage(int damage) {
    health -= damage;
  }
  int [] getPosition() {
    return position;
  }
  void display(float cellSize, int index) { 
    fill(90, 120, 20);
    rect(alienCoordinates.x, alienCoordinates.y, cellSize, cellSize);
    fill(0);
    //text(index, alienCoordinates.x, alienCoordinates.y);
    //text(nature, alienCoordinates.x +10, alienCoordinates.y);
    text(health, alienCoordinates.x, alienCoordinates.y);
  }
  //this is responsible for the functions within its priority

  int getHealth() {
    return health;
  }
  int getHunger() {
    return hunger;
  }
  int getLifespan() {
    return lifespan;
  }
  void death() {
    dead = true;
    nature = "death";
  }
  boolean isAttacking() {
    return attacking;
  }
  boolean isThreatened() {
    return threatened;
  }
  void hasBeenThreatened(){
  threatened = true;
  }
  boolean isSleeping() {
    return sleeping;
  }
  void sleep() {
    if (health < maxHealth) health++;
    if (sleep < maxSleep) sleep++;
    else if (sleep == maxSleep) {
      lifespan -= 1;
      sleeping = false;
      wakeUp();
    }
  }
  boolean isLookingForFood() {
    return lookingForFood;
  }
  int getMin() {
    return min;
  }
  int getSleep() {
    return sleep;
  }
  void goToSleep() {
    sleeping = true;
  }
  void goLookForFood() {
    lookingForFood = true;
  }
  //movement responsible section for the aliens
  int [] getLimitPosition() {
    return limitPosition;
  }
  void updatePosition(int moveToX, int moveToY) {
    limitPosition[0] = moveToX;
    limitPosition[1] = moveToY;
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
  //for the inability to find food
  void adapt() {
    nature = natures[int(random(natures.length))];
  }
  //for attacking
  void attack(){
   println("attacked character"); 
  }
}