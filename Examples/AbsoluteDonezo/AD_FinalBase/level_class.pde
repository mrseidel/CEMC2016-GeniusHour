//A_D dev of final base\\
class Level {
  Planet firstPlanet = new Planet();

  String [] inventory = new String[16]; //max inventory size is 16
  int fuel;
  int water;
  int food;

  float translateX, translateY;
  float lastPressed = 0;

  Level() {
    fuel = 50;
    water = 50;
    food = 50;
    firstPlanet.updateDimming(int((-translateX + mouseX)/32), int((-translateY + mouseY)/32));
  }

  void run() {
    update();
    display();
  }

  void display() {
    //* 32 is the standard cellSize
    translateX = -firstPlanet.getCharacterCoordinates().x + width/2;
    translateY = -firstPlanet.getCharacterCoordinates().y + height/2;
    translateX = constrain(translateX, -(firstPlanet.getChunkSizeX()*32 - width), 0);
    translateY = constrain(translateY, -(firstPlanet.getChunkSizeY()*32 - height), 0);

    translate(translateX, translateY);
    firstPlanet.display();
    firstPlanet.dimming();

    fill(56, 89, 230);
    rect(int((-translateX + mouseX)/32)*32, int((-translateY + mouseY)/32) *32, 32, 32);
  }

  void update() {
    if (millis() - lastPressed > 185) {
      if (keyPressed == true && (key == 'w'||key == 'a'||key == 's'||key == 'd')) {  
        lastPressed = millis(); 
        firstPlanet.characterControls();
      }
    }

    if (firstPlanet.characterHasCollected()) {
      if (firstPlanet.collectedWhat().split("-")[0].equals("water")) {
        water += int(firstPlanet.collectedWhat().split("-")[1]);
        if (water > 100) water = 100;
        firstPlanet.hasCollectedSwitch();
      } else if (firstPlanet.collectedWhat().split("-")[0].equals("oil")) {
        fuel += int(firstPlanet.collectedWhat().split("-")[1]);
        if (fuel > 100) fuel = 100;
        firstPlanet.hasCollectedSwitch();
      } else {
        //add to inventory
        for (int i = 0; i < inventory.length; i++) {
          if (inventory[i] == null) {
            inventory[i] = firstPlanet.collectedWhat();
            firstPlanet.hasCollectedSwitch();
            break;
          }
        }
      }
    }
  }

  void getDevelopmentInfo() {
    //firstPlanet.characterControls();
    if (key == 't') firstPlanet.getStatistics();
    if (key == ' ') firstPlanet.displayMiniMap();
  }

  void characterAttackingAndCollecting() {
    //attacking
    if (mouseButton == LEFT) {
      firstPlanet.characterAttack(int((-translateX + mouseX)/32), int((-translateY + mouseY)/32));
    }
    //collecting
    if (mouseButton == RIGHT) {
      firstPlanet.characterCollect(int((-translateX + mouseX)/32), int((-translateY + mouseY)/32));
    }
  }

  void characterTeleporting() {
    firstPlanet.characterTeleport(int((-translateX + mouseX)/32), int((-translateY + mouseY)/32));
  }

  void mouseDimmingUpdate() {
    if (keyPressed == true && (key != 'w'||key != 'a'||key != 's'||key != 'd') || keyPressed == false) firstPlanet.updateDimming(int((-translateX + mouseX)/32), int((-translateY + mouseY)/32));
  }

  int getFuel() {
    return fuel;
  }

  int getWater() {
    return water;
  }

  int getFood() {
    return food;
  }
}