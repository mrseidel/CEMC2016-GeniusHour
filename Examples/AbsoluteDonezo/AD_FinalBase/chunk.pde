class Chunk {
  //variables
  int [][] chunk;
  int [] spawnIndex = new int[2];
  ArrayList <Alien> aliens = new ArrayList <Alien>();
  int cellSize;


  //constructor
  Chunk(int dimensionX, int dimensionY, boolean N, boolean E, boolean S, boolean W, int cellSize, 
    int monsterFrequencyValue, int treasureFrequencyValue, int plantFrequencyValue, int oilFrequencyValue) {
    this.cellSize = cellSize;

    chunk = createChunk(dimensionX, dimensionY, N, E, S, W, treasureFrequencyValue, plantFrequencyValue, oilFrequencyValue);

    for (int i = dimensionX/4; i < (dimensionX/4)*3; i++) {
      for (int j = dimensionY/4; j < (dimensionY/4)*3; j++) {

        int surroundingValues = state(chunk[i][j-1]) + state(chunk[i+1][j-1]) + state(chunk[i+1][j]) + state(chunk[i+1][j+1])
          + state(chunk[i][j+1]) + state(chunk[i-1][j+1]) + state(chunk[i-1][j]) + state(chunk[i-1][j-1]) + state(chunk[i][j+2]);

        if (chunk[i][j] == 1 && surroundingValues > 8) {
          spawnIndex[0] = i;
          spawnIndex[1] = j;
          break;
        }
        if (i == (dimensionX/4)*3) {
          i = 0;
        }
      }
    }

    // finds out how many white blocks
    int emptyBlockCount = 0;
    for (int i = 0; i < dimensionX; i++) {
      for (int j = 0; j < dimensionY; j++) {
        if (chunk[i][j] == 1) emptyBlockCount += 1;
      }
    }
    while (aliens.size() < floor(emptyBlockCount/monsterFrequencyValue)) {
      int xIndex = floor(random(2, dimensionX-2));
      int yIndex = floor(random(2, dimensionY-2));
      int [] alienSpawn = new int[2];
      alienSpawn[0] = xIndex;
      alienSpawn[1] = yIndex;

      if (chunk[xIndex][yIndex] == 1) aliens.add(new Alien(alienSpawn, cellSize));
    }
  }


  //methods

  int get(int xIndex, int yIndex) {
    return chunk[xIndex][yIndex];
  }
  void set(int xIndex, int yIndex, int value) {
    chunk[xIndex][yIndex] = value;
  }
  int[] spawn() {
    return spawnIndex;
  }
  int[][] getArray() {
    return chunk;
  }
  ArrayList <Alien> getAliens() {
    return aliens;
  }
  void updateAlienArrayList(ArrayList <Alien> array) {
    aliens = array;
  }
}

int[][] createChunk(int dimensionX, int dimensionY, boolean N, boolean E, boolean S, boolean W, int treasureFrequencyValue, int plantFrequencyValue, int oilFrequencyValue) {
  int[][] cellStates = new int[dimensionX][dimensionY];

  for (int i = 0; i < dimensionX; i++) {
    for (int j = 0; j < dimensionY; j++) {
      cellStates[i][j] = int(noise(random(100000))* (2.139+ .037)); //.03

      //makes a black border
      cellStates[i][0] = 0;
      cellStates[dimensionX-1][j] = 0;
      cellStates[i][dimensionY-1] = 0;
      cellStates[0][j] = 0;
    }
  }

  for (int i = 0; i < 20; i++)  cellStates = update(cellStates, dimensionX, dimensionY, N, E, S, W);
  //adds properties
  /*
  */
  for (int i = 1; i < dimensionX-2; i++) {
    for (int j = 1; j < dimensionY-2; j++) {
      int surroundingValues = state(cellStates[i][j-1]) + state(cellStates[i+1][j-1])  + state(cellStates[i+1][j])  +
        state(cellStates[i+1][j+1]) + (cellStates[i][j+1]) + state(cellStates[i-1][j+1]) + state(cellStates[i-1][j]) + 
        state(cellStates[i-1][j-1]);

      //plants
      if (surroundingValues >= 7 && state(cellStates[i][j]) == 1) {
        int newState = floor(random(plantFrequencyValue, 2)); 
        if (newState == 0) cellStates[i][j] = 3;
      }

      //treasure
      if (surroundingValues <= 4 && state(cellStates[i][j]) == 1) {
        int newState = floor(random(treasureFrequencyValue, 2)); 
        if (newState == 0) cellStates[i][j] = 4;
      }

      // oil
      if (surroundingValues >= 8 && state(cellStates[i][j]) == 1) {
        int newState = floor(random(oilFrequencyValue, 2)); 
        if (newState == 0) cellStates[i][j] = 5;
      }
    }
  }

  /*
  */


  return cellStates;
}


int[][] update(int[][] array, int dimensionX, int dimensionY, boolean N, boolean E, boolean S, boolean W) {
  int[][] updatedCellStates = array;

  //
  //this for adding the borders and opening
  for (int i = 0; i < dimensionX; i++) {
    for (int j = 0; j < dimensionY; j++) {

      //makes a black border
      updatedCellStates[i][0] = 0;
      updatedCellStates[dimensionX-1][j] = 0;
      updatedCellStates[i][dimensionY-1] = 0;
      updatedCellStates[0][j] = 0;


      //fills in the white openings
      if (N) {
        if (i > int(dimensionX/3) && i < floor(dimensionX/3)*2) {
          updatedCellStates[i][0] = 1;
        }
      }
      if (E) {
        if (j > int(dimensionY/3) && j < floor(dimensionY/3)*2) {
          updatedCellStates[dimensionX-1][j] = 1;
        }
      }
      if (S) {
        if (i > int(dimensionX/3) && i < floor(dimensionX/3)*2) {
          updatedCellStates[i][dimensionY-1] = 1;
        }
      }
      if (W) {
        if (j > int(dimensionY/3) && j < floor(dimensionY/3)*2) {
          updatedCellStates[0][j] = 1;
        }
      }
    }
  }
  //

  for (int i = 1; i < dimensionX-1; i++) {
    for (int j = 1; j < dimensionY-1; j++) {
      //
      //this is for actually making the shape
      //  N,  NE,  E,  SE,  S,  SW,  W,  NW,
      int surroundingValues = state(array[i][j-1]) + state(array[i+1][j-1])  + state(array[i+1][j])  +
        state(array[i+1][j+1]) + state(array[i][j+1]) + state(array[i-1][j+1]) + state(array[i-1][j]) + state(array[i-1][j-1]);

      if ( array[i][j] == 0 && surroundingValues <= 4) array[i][j] = 0; //dead
      else if ( array[i][j] == 1 && surroundingValues <= 3) array[i][j] = 0; //dead
      else array[i][j] = 1;
    }
  }

  return updatedCellStates;
}

int state(int state) {
  if (state > 1) return 1;
  return state;
}