//A_D dev of final base\\

ArrayList <Level> levels = new ArrayList <Level>();

String [] inventory = new String[16]; //max inventory size is 16
int fuelSupply;
int waterSupply;
int foodSupply;

boolean openingCompanyLogos, openingMenu, playLevel, gameOver, pauseMenu;


void setup() {
  size (1024, 640);
  levels.add(new Level());
  fuelSupply = levels.get(0).getFuel();
  waterSupply = levels.get(0).getWater();
  foodSupply = levels.get(0).getFood();
}

void draw() {
  background(128);
  if (openingCompanyLogos) {
  }
  if (openingMenu) {
  }
  if (playLevel) {
    levels.get(0).run();
  } 
  if (gameOver) {
  }
  if (pauseMenu) {
  }
}

void keyPressed() {
  if (playLevel)if (keyPressed == true) levels.get(0).getDevelopmentInfo();
}

void mousePressed() {
  if (playLevel)levels.get(0).characterAttackingAndCollecting();
}

void mouseMoved() {
  if (playLevel)levels.get(0).mouseDimmingUpdate();
}

void mouseWheel() {
  if (playLevel) levels.get(0).characterTeleporting();
}