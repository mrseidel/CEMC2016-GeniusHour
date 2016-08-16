//Planet class
//its a base level class - might become the second last base if base class is made
class Planet {

  String [] types = {"ice", "lava", "jungle", "tech", "void", "dry"};
  String type;
  // Dungeon = random dungeon

  int dungeonDimensionX; // min 5
  int dungeonDimensionY;
  int chunkDimensionX; //min 10
  int chunkDimensionY;

  float dimness;
  int [][] dimnessArray;

  int cellSize = 32;

  int characterChunkIndexX;
  int characterChunkIndexY;
  int characterChunkPositionX;
  int characterChunkPositionY;

  int monsterFrequencyValue;
  int treasureFrequencyValue;
  int plantFrequencyValue; 
  int oilFrequencyValue; 

  //visited planet # of times
  int visitCount = 0;
  //died on planet # of times
  int deathCount = 0;

  Dungeon dungeon;

  //shape of planet
  int[][] shapeOfPlanet;

  //the actual character
  SpaceMan character;

  //collection variables
  boolean hasCollected;
  String lastCollectedItem;

  Planet() {
    //random dungeon and chunk sizes
    dungeonDimensionX = int(random(20, 100)); // min 5
    dungeonDimensionY = dungeonDimensionX + int(random(-10, 10)); // min 5
    chunkDimensionX = int(random(40, 100)); // min 10
    chunkDimensionY = chunkDimensionX + int(random(-20, 20)); // min 10

    //monster frequency - frequency of loot - plant frequency - oil frequency
    monsterFrequencyValue = int(random(20, 300)); // area per monster 20-300
    treasureFrequencyValue = int(random(-100, 0)); //arbitrary values for frequency
    plantFrequencyValue = int(random(-50, 0)); //arbitrary
    oilFrequencyValue =int(random(-600, 0)); //arbitrary

    //dimness
    dimness = random(.5, 2);

    //actual Dungeon class
    dungeon = new Dungeon(dungeonDimensionX, dungeonDimensionY, chunkDimensionX, 
      chunkDimensionY, cellSize, monsterFrequencyValue, treasureFrequencyValue, 
      plantFrequencyValue, oilFrequencyValue);

    //getting the shape
    shapeOfPlanet = dungeon.getShape();

    //spawn
    characterChunkIndexX = dungeon.spawn()[0];
    characterChunkIndexY = dungeon.spawn()[1];

    characterChunkPositionX = dungeon.spawn()[2];
    characterChunkPositionY = dungeon.spawn()[3];

    //character constructor
    character = new SpaceMan(characterChunkPositionX, characterChunkPositionY, cellSize);

    // type / terrain
    type = types[floor(random(types.length))];
  }

  int getDungeonSizeX() {
    return dungeonDimensionX;
  }
  int getDungeonSizeY() {
    return dungeonDimensionY;
  }
  int getChunkSizeX() {
    return chunkDimensionX;
  }
  int getChunkSizeY() {
    return chunkDimensionY;
  }
  int getDimnessPercent() {
    println(dimness);
    return int((dimness)/3*100);
  }
  int getMonsterFrequencyPercent() {
    return (300 - monsterFrequencyValue)/3;
  }  
  int getTreasureFrequencyPercent() {
    return (100 - abs(treasureFrequencyValue));
  }  
  int getPlantFrequencyPercent() {
    return (50 - abs(plantFrequencyValue))*2;
  }
  int getOilFrequencyPercent() {
    return (600 - abs(oilFrequencyValue))/6;
  }

  void visitCounter() {
    visitCount += 1;
  }
  void deathCounter() {
    deathCount += 1;
  }

  String [] getStatistics() {
    String [] stats  = new String[6];
    stats[0] = "Area of planet is: " + (dungeonDimensionX * dungeonDimensionY * chunkDimensionX * chunkDimensionY) + " km^2";
    stats[1] = "Dimness: " + getDimnessPercent() + "%";
    stats[2] = "Monster frequency: " + getMonsterFrequencyPercent() + "%";
    stats[3] = "Treasure frequency: " + getTreasureFrequencyPercent() + "%";
    stats[4] = "Plant frequency: " + getPlantFrequencyPercent() + "%";
    stats[5] = "Oil frequency: " + getOilFrequencyPercent() + "%";

    printArray(stats);
    return stats;
  }

  void display() {

    //Map
    for (int i = 0; i < chunkDimensionX; i++) {
      for (int j = 0; j < chunkDimensionY; j++) {

        if (dungeon.get(characterChunkIndexX, characterChunkIndexY) == null) { //open space
          continue;
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(i, j) == 1) { //open space
          fill(255);
          noStroke();
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(i, j) == 0) { // wall
          fill(0);
          stroke(0);
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(i, j)== 3) { // plant
          fill(78, 234, 89);
          noStroke();
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(i, j) == 4) { // Treasure
          fill(178, 34, 89);
          noStroke();
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(i, j) == 5) { // Fuel
          fill(128);
          noStroke();
        } 
        rect((i * cellSize), (j * cellSize), cellSize, cellSize);
      }
    }
    // display AI and character
    //updates both the character and AI aswell
    for (int i = dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().size()-1; i > -1; i--) {
      if (dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(i).getPosition()[1] < character.getPosition()[1]) {
        dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(i).display(cellSize, i);
      }
    }
    character.run(cellSize);

    for (int i = dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().size()-1; i > -1; i--) {
      if (dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(i).getPosition()[1] >= character.getPosition()[1]) {
        dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(i).display(cellSize, i);
      }
    }
    //movementUpdate
    for (int i = dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().size()-1; i > -1; i--) {
      dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(i).movementUpdate(cellSize);
    }
  }

  void displayMiniMap() {

    for (int i = 0; i < dungeonDimensionX; i++) {
      for (int j = 0; j < dungeonDimensionY; j++) {
        if (dungeon.get(i, j) == null)fill(0);
        if (dungeon.get(i, j) !=null)fill(255);
        rect(i * cellSize/2, j * cellSize/2, cellSize/2, cellSize/2);
      }
    }
  }

  void dimming() {
    //dimnessArray
    int inf = (int) Double.POSITIVE_INFINITY;

    for (int i = 0; i < chunkDimensionX; i++) {
      for (int j = 0; j < chunkDimensionY; j++) {
        if ( dimnessArray[i][j] < 300 &&  dimnessArray[i][j] != 0) {
          fill(0, dimnessArray[i][j] * 7 * dimness);
          stroke(0, dimnessArray[i][j] * 7 * dimness);
          rect(i * cellSize, j * cellSize, cellSize, cellSize);
        } else {
          fill(0);
          stroke(0);
          rect(i * cellSize, j * cellSize, cellSize, cellSize);
        }
      }
    }
  }
  void updateDimming(int mousePositionX, int mousePositionY) {
    dimnessArray = advancedDimming(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), character.getPosition(), 
      dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens(), mousePositionX, mousePositionY);
  }


  int[][] advancedDimming(int[][] section, int [] startPosition, ArrayList <Alien> array, int mousePositionX, int mousePositionY) {

    int inf = (int) Double.POSITIVE_INFINITY;
    int [][] walls = new int [section.length][section[0].length];

    //makes an array
    for (int i = 0; i < walls.length; i++) {
      for (int j = 0; j < walls[0].length; j++) {

        if (section[i][j] != 0) {
          walls[i][j] = inf;
        } else {
          walls[i][j] = 0;
        }
      }
    } 
    //at character
    walls[startPosition[0]][startPosition[1]] = 2;
    //at mouse - drone - droid
    if (mousePositionX >= 0 && mousePositionX < walls.length-1
      && mousePositionY >= 0 && mousePositionY < walls[0].length-1) {
      walls[mousePositionX][mousePositionY] = 2;
    }

    //int((-(-getCharacterCoordinates().x + width/2) + mouseX)/32), int((-(-getCharacterCoordinates().y + width/2) + mouseY)/32)

    //-firstPlanet.getCharacterCoordinates().x + width/2

    for (int h = 0; h < 45; h++) {
      for (int i = 0; i <  walls.length; i++) {
        for (int j = 0; j <  walls[0].length; j++) {
          //assigns values after certain amount of loops - while loop

          if (walls[i][j] == inf) {
            if (i != 0 && walls[i-1][j] != 0 && walls[i-1][j] != inf && walls[i-1][j] == h && !checkPositions(i-1, j, array)) {
              walls[i][j] = walls[i-1][j] + 1;
            }
            if (i != walls.length-1 && walls[i+1][j] != 0 && walls[i+1][j] != inf && walls[i+1][j] == h  && !checkPositions(i+1, j, array)) {
              walls[i][j] = walls[i+1][j] + 1;
            }
            if (j != 0 && walls[i][j-1] != 0 && walls[i][j-1] != inf && walls[i][j-1] == h  && !checkPositions(i, j-1, array)) {
              walls[i][j] = walls[i][j-1] + 1;
            }
            if (j != walls[0].length-1 && walls[i][j+1] != 0 && walls[i][j+1] != inf && walls[i][j+1] == h  && !checkPositions(i, j+1, array)) {
              walls[i][j] = walls[i][j+1] + 1;
            }
          }
        }
      }
    }
    return walls;
  }

  //updating aliens

  void updateAliens() {
    //then update them
    //for loop through each alien
    for (int i = 0; i < dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().size(); i++) {
      Alien currentAlien = dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(i);

      //checks all 4 direction and determines which are open and which are blocked
      boolean upBlock = true;
      boolean downBlock = true;
      boolean leftBlock = true;
      boolean rightBlock = true;

      //finds character's position
      boolean besideCharacter = false;


      ////////////checks walls

      if (currentAlien.getLimitPosition()[0] - 1 < 2) {
        leftBlock = false;
      }
      if (currentAlien.getLimitPosition()[0] + 1 > chunkDimensionX-2) {
        rightBlock = false;
      }
      if (currentAlien.getLimitPosition()[1] - 1 < 2) {
        upBlock = false;
      }
      if (currentAlien.getLimitPosition()[1] + 1 > chunkDimensionY-2) {
        downBlock = false;
      }

      if (upBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1) == 0) {
        upBlock = false;
      }
      if (downBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1) == 0) {
        downBlock = false;
      }
      if (leftBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]) == 0) {
        leftBlock = false;
      }
      if (rightBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]) == 0) {
        rightBlock = false;
      }
      ////////////checks other aliens
      for (int j = 0; j < dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().size(); j++) {
        if (upBlock != false 
          && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1)) {
          upBlock = false;
        }
        if (downBlock != false 
          && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1)) {
          downBlock = false;
        }
        if (leftBlock != false 
          && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1])) {
          leftBlock = false;
        }
        if (rightBlock != false 
          && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1])) {
          rightBlock = false;
        }
      }
      ////////// checks character

      if (upBlock != false 
        && character.positionEquals(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1)) {
        upBlock = false;
        besideCharacter = true;
      }
      if (downBlock != false 
        && character.positionEquals(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1)) {
        downBlock = false;
        besideCharacter = true;
      }
      if (leftBlock != false 
        && character.positionEquals(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1])) {
        leftBlock = false;
        besideCharacter = true;
      }
      if (rightBlock != false 
        && character.positionEquals(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1])) {
        rightBlock = false;
        besideCharacter = true;
      }
      //////////////////////////
      if (currentAlien.getHealth() < 0 || !currentAlien.getNature().equals("aggressive") && currentAlien.getHunger() < 0 || currentAlien.getLifespan() < 0) {
        // death of alien
        currentAlien.death();
      } else if (currentAlien.isSleeping()) {

        currentAlien.sleep();
      } else if (currentAlien.isLookingForFood()) {

        if (currentAlien.getNature().equals("aggressive")) {
          //*************
          int [] nullResult = new int[2];
          nullResult[0] = 0;
          nullResult[1] = 0;
          int [] foundPosition;

          if (abs(currentAlien.getPosition()[0] - character.getPosition()[0]) + abs(currentAlien.getPosition()[1] - character.getPosition()[1]) < 15) {
            foundPosition = findCharacter(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), 
              currentAlien.getPosition()[0], currentAlien.getPosition()[1], character.getPosition());
          } else {
            foundPosition = findOtherAliens(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), 
              currentAlien.getPosition()[0], currentAlien.getPosition()[1], dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens());
          }

          if (foundPosition[0] > currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && rightBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.right();
          } else if (foundPosition[0] < currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && leftBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.left();
          } else if (foundPosition[1] > currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && downBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.down();
          } else if (foundPosition[1] < currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && upBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.up();
          } else if (foundPosition.equals(nullResult)) {
            currentAlien.adapt();
          }
        } else if (currentAlien.getNature().equals("timid") || currentAlien.getNature().equals("lazy")) {
          int [] nullResult = new int[2];
          nullResult[0] = 0;
          nullResult[1] = 0;
          int [] foundPosition = findSpecifiedFood(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), currentAlien.getPosition()[0], currentAlien.getPosition()[1], 3);

          if (foundPosition[0] > currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && rightBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.right();
          } else if (foundPosition[0] < currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && leftBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.left();
          } else if (foundPosition[1] > currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && downBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.down();
          } else if (foundPosition[1] < currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && upBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.up();
          }
        } else if (currentAlien.getNature().equals("greedy")) {
          int [] nullResult = new int[2];
          nullResult[0] = 0;
          nullResult[1] = 0;
          int [] foundPosition = findSpecifiedFood(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), currentAlien.getPosition()[0], currentAlien.getPosition()[1], 4);

          if (foundPosition[0] > currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && rightBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.right();
          } else if (foundPosition[0] < currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && leftBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.left();
          } else if (foundPosition[1] > currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && downBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.down();
          } else if (foundPosition[1] < currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && upBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.up();
          } else {
            int direction = floor(random(5));
            if (direction == 0 && upBlock == true) {
              println("up");
              currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1);
              currentAlien.up();
            } else if (direction == 1 && downBlock == true) {
              println("down");
              currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1);
              currentAlien.down();
            } else if (direction == 2 && leftBlock == true) {
              println("left");
              currentAlien.updatePosition(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]);
              currentAlien.left();
            } else if (direction == 3 && rightBlock == true) {
              println("right");
              currentAlien.updatePosition(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]);
              currentAlien.right();
            }
            currentAlien.adapt();
          }
        } else if (currentAlien.getNature().equals("explosive")) { 
          int [] nullResult = new int[2];
          nullResult[0] = 0;
          nullResult[1] = 0;
          int [] foundPosition = findSpecifiedFood(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), currentAlien.getPosition()[0], currentAlien.getPosition()[1], 5);

          if (foundPosition[0] > currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && rightBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.right();
          } else if (foundPosition[0] < currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && leftBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.left();
          } else if (foundPosition[1] > currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && downBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.down();
          } else if (foundPosition[1] < currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && upBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.up();
          } else {
            int direction = floor(random(5));
            if (direction == 0 && upBlock == true) {
              println("up");
              currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1);
              currentAlien.up();
            } else if (direction == 1 && downBlock == true) {
              println("down");
              currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1);
              currentAlien.down();
            } else if (direction == 2 && leftBlock == true) {
              println("left");
              currentAlien.updatePosition(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]);
              currentAlien.left();
            } else if (direction == 3 && rightBlock == true) {
              println("right");
              currentAlien.updatePosition(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]);
              currentAlien.right();
            }
            currentAlien.adapt();
          }
        } else if (currentAlien.getNature().equals("hungry")) {
          int [] nullResult = new int[2];
          nullResult[0] = 0;
          nullResult[1] = 0;
          int [] foundPosition = findAnyFood(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), currentAlien.getPosition()[0], currentAlien.getPosition()[1]);

          if (!foundPosition.equals(nullResult) && foundPosition[0] > currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && rightBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.right();
          } else if (!foundPosition.equals(nullResult) && foundPosition[0] < currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && leftBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.left();
          } else if (!foundPosition.equals(nullResult) && foundPosition[1] > currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && downBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.down();
          } else if (!foundPosition.equals(nullResult) && foundPosition[1] < currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && upBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.up();
          }
        }
      } else if (currentAlien.isThreatened()) {
        if (!currentAlien.getNature().equals("timid") && !besideCharacter|| !currentAlien.getNature().equals("lazy") && !besideCharacter) {
          // move towards character
          int [] nullResult = new int[2];
          nullResult[0] = 0;
          nullResult[1] = 0;
          int [] foundPosition = findCharacter(dungeon.get(characterChunkIndexX, characterChunkIndexY).getArray(), 
            currentAlien.getPosition()[0], currentAlien.getPosition()[1], character.getPosition());

          if (foundPosition[0] > currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && rightBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.right();
          } else if (foundPosition[0] < currentAlien.getPosition()[0] && foundPosition[1] == currentAlien.getPosition()[1] && leftBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.left();
          } else if (foundPosition[1] > currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && downBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.down();
          } else if (foundPosition[1] < currentAlien.getPosition()[1] && foundPosition[0] == currentAlien.getPosition()[0] && upBlock == true) {
            currentAlien.updatePosition(foundPosition[0], foundPosition[1]);
            currentAlien.up();
          }
        } else {

          int direction = floor(random(5));
          if (direction == 0 && upBlock == true) {
            println("up");
            currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1);
            currentAlien.up();
          } else if (direction == 1 && downBlock == true) {
            println("down");
            currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1);
            currentAlien.down();
          } else if (direction == 2 && leftBlock == true) {
            println("left");
            currentAlien.updatePosition(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]);
            currentAlien.left();
          } else if (direction == 3 && rightBlock == true) {
            println("right");
            currentAlien.updatePosition(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]);
            currentAlien.right();
          }
        }
      } else if ( currentAlien.getHealth() < currentAlien.getMin() && currentAlien.getSleep() < currentAlien.getMin() || currentAlien.getSleep() <= 1) {

        currentAlien.goToSleep();
      } else if (currentAlien.getHunger() < currentAlien.getMin() + 5) {        

        currentAlien.goLookForFood();
      } else {

        int direction = floor(random(5));
        if (direction == 0 && upBlock == true) {
          println("up");
          currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1);
          currentAlien.up();
        } else if (direction == 1 && downBlock == true) {
          println("down");
          currentAlien.updatePosition(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1);
          currentAlien.down();
        } else if (direction == 2 && leftBlock == true) {
          println("left");
          currentAlien.updatePosition(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]);
          currentAlien.left();
        } else if (direction == 3 && rightBlock == true) {
          println("right");
          currentAlien.updatePosition(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]);
          currentAlien.right();
        }
      }
      currentAlien.update();
      //checks food

      if (currentAlien.getNature().equals("aggressive")) {

        if (currentAlien.getHealth() < 2) currentAlien.restoreHunger();
      } else if (currentAlien.getNature().equals("hungry")) {

        for (int foodNumber = 3; foodNumber < 6; foodNumber++) {
          if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]) == foodNumber
            || dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]) == foodNumber
            || dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1) == foodNumber
            || dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1) == foodNumber) {
            currentAlien.restoreHunger();
          }
        }
      } else {
        int food = 3; // 3 because all others will currently eat
        //if (currentAlien.getNature().equals("hungry")) food = allofthem;
        if (currentAlien.getNature().equals("greedy")) food = 4;
        if (currentAlien.getNature().equals("explosive")) food = 5;

        //food for aggressive = other aliens/character
        //hungry will be anything it is close to
        if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0]+1, currentAlien.getPosition()[1]) == food
          || dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0]-1, currentAlien.getPosition()[1]) == food
          || dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0], currentAlien.getPosition()[1]+1) == food
          || dungeon.get(characterChunkIndexX, characterChunkIndexY).get(currentAlien.getPosition()[0], currentAlien.getPosition()[1]-1) == food) {
          currentAlien.restoreHunger();
        }
        //attacks character\\
        if (currentAlien.isThreatened() && besideCharacter ||currentAlien.getNature().equals("aggressive")) {
          if (currentAlien.getNature().equals("aggressive")) {
            character.takeDamage(floor(random(4, 7)));
          } else {
            character.takeDamage(floor(random(3, 5)));
          }
          currentAlien.attack();
        }
        //checks to see if dead or not, to remove from list or not
        if (currentAlien.isDead()) {
          dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().remove(i);
        }
      }
    }
  }

  //update - control characters
  void characterControls() {

    //checks all 4 direction and determines which are open and which are blocked
    boolean upBlock = true;
    boolean downBlock = true;
    boolean leftBlock = true;
    boolean rightBlock = true;


    ////////////checks walls and boundries

    if (character.getPosition()[0] - 1 < 0) {
      leftBlock = false;
    }
    if (character.getPosition()[0] + 1 > chunkDimensionX-1) {
      rightBlock = false;
    }
    if (character.getPosition()[1] - 1 < 0) {
      upBlock = false;
    }
    if (character.getPosition()[1] + 1 > chunkDimensionY-1) {
      downBlock = false;
    }

    if (upBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(character.getLimitPosition()[0], character.getLimitPosition()[1]-1) == 0) {
      upBlock = false;
    }
    if (downBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(character.getLimitPosition()[0], character.getLimitPosition()[1]+1) == 0) {
      downBlock = false;
    }
    if (leftBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(character.getLimitPosition()[0]-1, character.getLimitPosition()[1]) == 0) {
      leftBlock = false;
    }
    if (rightBlock != false && dungeon.get(characterChunkIndexX, characterChunkIndexY).get(character.getLimitPosition()[0]+1, character.getLimitPosition()[1]) == 0) {
      rightBlock = false;
    }
    ////////////checks  aliens
    for (int j = 0; j < dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().size(); j++) {
      if (upBlock != false 
        && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(character.getPosition()[0], character.getPosition()[1]-1)) {
        upBlock = false;
      }
      if (downBlock != false 
        && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(character.getPosition()[0], character.getPosition()[1]+1)) {
        downBlock = false;
      }
      if (leftBlock != false 
        && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(character.getPosition()[0]-1, character.getPosition()[1])) {
        leftBlock = false;
      }
      if (rightBlock != false 
        && dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(j).positionEquals(character.getPosition()[0]+1, character.getPosition()[1])) {
        rightBlock = false;
      }
    }
    ////////////////////////
    if (keyPressed == true && key == 'w' && upBlock == true) {
      characterChunkPositionY -= 1;
      character.up();
    } else if (keyPressed == true && key == 'a' && leftBlock == true) {
      characterChunkPositionX -= 1;
      character.left();
    } else if (keyPressed == true && key == 's' && downBlock == true) {
      characterChunkPositionY += 1;
      character.down();
    } else if (keyPressed == true && key == 'd' && rightBlock == true) {
      characterChunkPositionX += 1;
      character.right();
    }

    //for moving between chunks
    if (keyPressed == true && key == 'a' && character.getPosition()[0] - 1 < 0) {
      for (int i = 0; i < 10; i++) updateAliens();
      characterChunkIndexX -= 1;
      characterChunkPositionX = chunkDimensionX-1;
      character.setPosition(characterChunkPositionX, characterChunkPositionY, cellSize);
      updateDimming(int((-(-getCharacterCoordinates().x + width/2) + mouseX)/32), int((-(-getCharacterCoordinates().y + height/2) + mouseY)/32));
    }
    if (keyPressed == true && key == 'd' && character.getPosition()[0] + 1 > chunkDimensionX-1) {
      for (int i = 0; i < 10; i++) updateAliens();
      characterChunkIndexX += 1;
      characterChunkPositionX = 0;
      character.setPosition(characterChunkPositionX, characterChunkPositionY, cellSize);
      updateDimming(int((-(-getCharacterCoordinates().x + width/2) + mouseX)/32), int((-(-getCharacterCoordinates().y + height/2) + mouseY)/32));
    }
    if (keyPressed == true && key == 'w' && character.getPosition()[1] - 1 < 0) {
      for (int i = 0; i < 10; i++) updateAliens();
      characterChunkIndexY -= 1;
      characterChunkPositionY = chunkDimensionY-1;
      character.setPosition(characterChunkPositionX, characterChunkPositionY, cellSize);
      updateDimming(int((-(-getCharacterCoordinates().x + width/2) + mouseX)/32), int((-(-getCharacterCoordinates().y + height/2) + mouseY)/32));
    }
    if (keyPressed == true && key == 's' && character.getPosition()[1] + 1 > chunkDimensionY-1) {
      for (int i = 0; i < 10; i++) updateAliens();
      characterChunkIndexY += 1;
      characterChunkPositionY = 0;
      character.setPosition(characterChunkPositionX, characterChunkPositionY, cellSize);
      updateDimming(int((-(-getCharacterCoordinates().x + width/2) + mouseX)/32), int((-(-getCharacterCoordinates().y + height/2) + mouseY)/32));
    }

    character.updatePosition(characterChunkPositionX, characterChunkPositionY);
    updateAliens();
  }

  int[][] getMap() {
    return shapeOfPlanet;
  }

  // pathfinding of AI
  int [] findSpecifiedFood(int[][] section, int startXIndex, int startYIndex, int food) {

    int inf = (int) Double.POSITIVE_INFINITY;
    int [][] walls = new int [section.length][section[0].length];
    int [] endPoint = new int [2];

    //makes an array
    for (int i = 1; i < walls.length-1; i++) {
      for (int j = 1; j < walls[0].length-1; j++) {

        if (section[i][j] != 0) {
          walls[i][j] = inf;
        } else {
          walls[i][j] = 0;
        }
      }
    }

    walls[startXIndex][startYIndex] = 2;

    for (int h = 0; h < 300; h++) {
      for (int i = 2; i <  walls.length-2; i++) {
        for (int j = 2; j <  walls[0].length-2; j++) {
          //assigns values after certain amount of loops - while loop

          if (walls[i][j] == inf) {
            if (walls[i-1][j] != 0 && walls[i-1][j] != inf && walls[i-1][j] == h) {
              walls[i][j] = walls[i-1][j] + 1;
              if (section[i-1][j] == food) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i+1][j] != 0 && walls[i+1][j] != inf && walls[i+1][j] == h) {
              walls[i][j] = walls[i+1][j] + 1;
              if (section[i+1][j] == food) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i][j-1] != 0 && walls[i][j-1] != inf && walls[i][j-1] == h) {
              walls[i][j] = walls[i][j-1] + 1;
              if (section[i][j-1] == food) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i][j+1] != 0 && walls[i][j+1] != inf && walls[i][j+1] == h) {
              walls[i][j] = walls[i][j+1] + 1;
              if (section[i][j+1] == food ) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
          }
        }
      }
    }

    for (int k = walls[endPoint[0]][endPoint[1]]; k > 3; k--) {

      //looks at all four directions if it is smaller than 
      int randomDirectionValue = floor(random(2));

      if (randomDirectionValue == 1) {
        if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        }
      } else if (randomDirectionValue == 0) {
        if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        }
      }
    }

    return endPoint;
  }

  int [] findAnyFood(int[][] section, int startXIndex, int startYIndex) {

    int inf = (int) Double.POSITIVE_INFINITY;
    int [][] walls = new int [section.length][section[0].length];
    int [] endPoint = new int [2];

    //makes an array
    for (int i = 1; i < walls.length-1; i++) {
      for (int j = 1; j < walls[0].length-1; j++) {

        if (section[i][j] != 0) {
          walls[i][j] = inf;
        } else {
          walls[i][j] = 0;
        }
      }
    }

    walls[startXIndex][startYIndex] = 2;

    for (int h = 0; h < 300; h++) {
      for (int i = 2; i <  walls.length-2; i++) {
        for (int j = 2; j <  walls[0].length-2; j++) {
          //assigns values after certain amount of loops - while loop

          if (walls[i][j] == inf) {
            if (walls[i-1][j] != 0 && walls[i-1][j] != inf && walls[i-1][j] == h) {
              walls[i][j] = walls[i-1][j] + 1;
              if (section[i-1][j] != 0 && section[i-1][j] != 1) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i+1][j] != 0 && walls[i+1][j] != inf && walls[i+1][j] == h) {
              walls[i][j] = walls[i+1][j] + 1;
              if (section[i+1][j] != 0 && section[i+1][j] != 1) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i][j-1] != 0 && walls[i][j-1] != inf && walls[i][j-1] == h) {
              walls[i][j] = walls[i][j-1] + 1;
              if (section[i][j-1] != 0 && section[i][j-1] != 1) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i][j+1] != 0 && walls[i][j+1] != inf && walls[i][j+1] == h) {
              walls[i][j] = walls[i][j+1] + 1;
              if (section[i][j+1] != 0 && section[i][j+1] != 1) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
          }
        }
      }
    }

    for (int k = walls[endPoint[0]][endPoint[1]]; k > 3; k--) {
      //looks at all four directions if it is smaller than 
      int randomDirectionValue = floor(random(2));

      if (randomDirectionValue == 1) {
        if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        }
      } else if (randomDirectionValue == 0) {
        if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        }
      }
    }

    return endPoint;
  }

  int [] findOtherAliens(int[][] section, int startXIndex, int startYIndex, ArrayList <Alien> array) {

    int inf = (int) Double.POSITIVE_INFINITY;
    int [][] walls = new int [section.length][section[0].length];
    int [] endPoint = new int [2];

    //makes an array
    for (int i = 1; i < walls.length-1; i++) {
      for (int j = 1; j < walls[0].length-1; j++) {
        if (section[i][j] != 0) {
          walls[i][j] = inf;
        } else {
          walls[i][j] = 0;
        }
      }
    }

    walls[startXIndex][startYIndex] = 2;

    for (int h = 0; h < 300; h++) {
      for (int i = 2; i <  walls.length-2; i++) {
        for (int j = 2; j <  walls[0].length-2; j++) {
          if (walls[i][j] == inf) {
            if (walls[i-1][j] != 0 && walls[i-1][j] != inf && walls[i-1][j] == h) {
              walls[i][j] = walls[i-1][j] + 1;
              if ( checkPositions(i-1, j, array) && !array.get(checkPositionIndex(i-1, j, array)).getNature().equals("aggressive")) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i+1][j] != 0 && walls[i+1][j] != inf && walls[i+1][j] == h) {
              walls[i][j] = walls[i+1][j] + 1;
              if ( checkPositions(i+1, j, array) && !array.get(checkPositionIndex(i+1, j, array)).getNature().equals("aggressive")) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i][j-1] != 0 && walls[i][j-1] != inf && walls[i][j-1] == h) {
              walls[i][j] = walls[i][j-1] + 1;
              if ( checkPositions(i, j-1, array) && !array.get(checkPositionIndex(i, j-1, array)).getNature().equals("aggressive")) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
            if (walls[i][j+1] != 0 && walls[i][j+1] != inf && walls[i][j+1] == h) {
              walls[i][j] = walls[i][j+1] + 1;
              if ( checkPositions(i, j+1, array) && !array.get(checkPositionIndex(i, j+1, array)).getNature().equals("aggressive")) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 301;
              }
            }
          }
        }
      }
    }

    for (int k = walls[endPoint[0]][endPoint[1]]; k > 3; k--) {

      //looks at all four directions if it is smaller than 
      int randomDirectionValue = floor(random(2));

      if (randomDirectionValue == 1) {
        if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        }
      } else if (randomDirectionValue == 0) {
        if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        }
      }
    }

    return endPoint;
  }


  int [] findCharacter(int[][] section, int startXIndex, int startYIndex, int [] characterPosition) {

    int inf = (int) Double.POSITIVE_INFINITY;
    int [][] walls = new int [section.length][section[0].length];
    int [] endPoint = new int [2];

    //makes an array
    for (int i = 1; i < walls.length-1; i++) {
      for (int j = 1; j < walls[0].length-1; j++) {

        if (section[i][j] != 0) {
          walls[i][j] = inf;
        } else {
          walls[i][j] = 0;
        }
      }
    }

    walls[startXIndex][startYIndex] = 2;

    for (int h = 0; h < 300; h++) {
      for (int i = 2; i <  walls.length-2; i++) {
        for (int j = 2; j <  walls[0].length-2; j++) {
          //assigns values after certain amount of loops - while loop

          if (walls[i][j] == inf) {
            if (walls[i-1][j] != 0 && walls[i-1][j] != inf && walls[i-1][j] == h) {
              walls[i][j] = walls[i-1][j] + 1;
              if (i-1 == characterPosition[0] && j == characterPosition[1]) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 300;
              }
            }
            if (walls[i+1][j] != 0 && walls[i+1][j] != inf && walls[i+1][j] == h) {
              walls[i][j] = walls[i+1][j] + 1;
              if (i+1 == characterPosition[0] && j == characterPosition[1]) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 300;
              }
            }
            if (walls[i][j-1] != 0 && walls[i][j-1] != inf && walls[i][j-1] == h) {
              walls[i][j] = walls[i][j-1] + 1;
              if (i == characterPosition[0] && j-1 == characterPosition[1]) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 300;
              }
            }
            if (walls[i][j+1] != 0 && walls[i][j+1] != inf && walls[i][j+1] == h) {
              walls[i][j] = walls[i][j+1] + 1;
              if (i == characterPosition[0] && j+1 == characterPosition[1]) {
                endPoint[0] = i;
                endPoint[1] = j;
                h = 300;
              }
            }
          }
        }
      }
    }

    for (int k = walls[endPoint[0]][endPoint[1]]; k > 3; k--) {
      //looks at all four directions if it is smaller than 
      int randomDirectionValue = floor(random(2));

      if (randomDirectionValue == 1) {
        if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        }
      } else if (randomDirectionValue == 0) {
        if (walls[endPoint[0]][endPoint[1]+1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]+1] != 0 ) {
          endPoint[1] = endPoint[1]+1;
        } else if (walls[endPoint[0]][endPoint[1]-1] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]][endPoint[1]-1] != 0) {
          endPoint[1] = endPoint[1]-1;
        } else if (walls[endPoint[0]+1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]+1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]+1;
        } else if (walls[endPoint[0]-1][endPoint[1]] < walls[endPoint[0]][endPoint[1]] && walls[endPoint[0]-1][endPoint[1]] != 0) {
          endPoint[0] = endPoint[0]-1;
        }
      }
    }

    return endPoint;
  }

  boolean checkPositions(int indexX, int indexY, ArrayList <Alien> array) {
    for (int i = 0; i < array.size(); i++) {
      if (array.get(i).positionEquals(indexX, indexY)) return true;
    }
    return false;
  }
  int checkPositionIndex(int indexX, int indexY, ArrayList <Alien> array) {
    for (int i = 0; i < array.size(); i++) {
      if (array.get(i).positionEquals(indexX, indexY)) return i;
    }
    return 0;
  }

  //for translation

  PVector getCharacterCoordinates() {
    return character.getCoordinates();
  }

  //for collection of objects - attacking
  boolean characterHasCollected() {
    return hasCollected;
  }
  String collectedWhat() {
    return lastCollectedItem;
  }
  void hasCollectedSwitch() {
    hasCollected = !hasCollected;
  }

  void characterCollect(int searchingX, int searchingY) {
    //if distance between character and searching location is < a set distance
    //list or priorities
    //1.there is no alien, there is no wall
    //2.i. what is it
    //2.ii. uses specific fuction to determine
    //      is actually collected according to
    //      the frequencies

    if (abs(searchingX - character.getPosition()[0]) + abs(searchingY - character.getPosition()[1]) <= 2) {
      if (!checkPositions(searchingX, searchingY, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())) {
        if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(searchingX, searchingY) == 0 
          ||dungeon.get(characterChunkIndexX, characterChunkIndexY).get(searchingX, searchingY) == 1) {
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(searchingX, searchingY) == 3) {
          dungeon.get(characterChunkIndexX, characterChunkIndexY).set(searchingX, searchingY, 1);
          collectedWater();
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(searchingX, searchingY) == 4) {
          dungeon.get(characterChunkIndexX, characterChunkIndexY).set(searchingX, searchingY, 1);
          collectedTreasure();
        } else if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(searchingX, searchingY) == 5) {
          dungeon.get(characterChunkIndexX, characterChunkIndexY).set(searchingX, searchingY, 1);
          collectedOil();
        }
      }
    }
  }

  void collectedWater() {
    //plantFrequencyValue
    // 100/22
    hasCollected = true;
    lastCollectedItem = "water-"+ float((100/22)*(1-plantFrequencyValue/100));
  }
  void collectedTreasure() {
    //treasureFrequencyValue
    String [] firstWords = {"Shiny", "Luxuriant", "Simple", "Pleasant", "Cursed" };
    String [] secondWords = {" Orb", " Jewel", " Ore", " Mineral", " Nugget", " Valuable Dust", " Rare Alien Skull"};
    String [] thirdWords = {" of Aether ", " of Destiny ", " of Stars", " of Mystery", " of Doom", " of Butter Fingers"};
    String firstWord = firstWords[int(random(firstWords.length))];
    String secondWord = secondWords[int(random(secondWords.length))];
    String thirdWord = thirdWords[int(random(thirdWords.length))];
    hasCollected = true;
    lastCollectedItem = firstWord + secondWord + thirdWord;
  }
  void collectedOil() {
    //oilFrequencyValue
    //100/12
    hasCollected = true;
    lastCollectedItem = "oil-"+ float((100/12)*(1-oilFrequencyValue/100));
  }

  void characterAttack(int searchingX, int searchingY) {
    //if distance between character and searching location is < a set distance
    //distance determines attack type
    //check for AI
    //find if you are even attacking ai or
    if (checkPositions(searchingX, searchingY, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())) {
      if (abs(searchingX - character.getPosition()[0]) + abs(searchingY - character.getPosition()[1]) <= 2) {
        //close combat animation
        println("close");
        dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(checkPositionIndex(searchingX, searchingY, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())).takeDamage(floor(random(4, 6)));
        dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(checkPositionIndex(searchingX, searchingY, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())).hasBeenThreatened();
        updateAliens();
      } else if (abs(searchingX - character.getPosition()[0]) + abs(searchingY - character.getPosition()[1]) > 2
        && abs(searchingX - character.getPosition()[0]) + abs(searchingY - character.getPosition()[1]) <= 7) {
        //range attack animation
        println("range");
        dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(checkPositionIndex(searchingX, searchingY, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())).takeDamage(floor(random(0, 3)));
        dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens().get(checkPositionIndex(searchingX, searchingY, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())).hasBeenThreatened();
        updateAliens();
      } else {
        //shrug animation f()
      }
    }
  }
  //character teleporting
  void characterTeleport(int moveToX, int moveToY) {
    if (dungeon.get(characterChunkIndexX, characterChunkIndexY).get(moveToX, moveToY) != 0
      && !checkPositions(moveToX, moveToX, dungeon.get(characterChunkIndexX, characterChunkIndexY).getAliens())) {
      character.setPosition (moveToX, moveToY, cellSize);
    }
  }
}