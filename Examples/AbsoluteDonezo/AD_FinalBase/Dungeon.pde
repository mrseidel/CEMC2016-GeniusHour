class Dungeon {
  // variables
  int [][] shape;
  int [] spawnIndex = new int[4];
  Chunk[][] chunks;

  //constructor
  Dungeon(int dimensionX, int dimensionY, int chunkSizeX, int chunkSizeY, int cellSize, int monsterFrequencyValue, 
    int treasureFrequencyValue, int plantFrequencyValue, int oilFrequencyValue) {
    chunks = new Chunk[dimensionX][dimensionY];
    int [][] shape = createDungeonShape(dimensionX, dimensionY);

    for (int i = dimensionX/4; i < (dimensionX/4)*3; i++) {
      for (int j = dimensionY/4; j < (dimensionY/4)*3; j++) {

        int surroundingValues = shape[i][j-1] + shape[i+1][j-1] 
          + shape[i+1][j] + shape[i+1][j+1] 
          + shape[i][j+1] + shape[i-1][j+1]  
          + shape[i-1][j] + shape[i-1][j-1];

        if (surroundingValues == 8) {
          spawnIndex[0] = i;
          spawnIndex[1] = j;
        }
      }
    }


    //shut off not only the other blocks but also the edges

    for (int i = 1; i < dimensionX-1; i++) {
      for (int j = 1; j < dimensionY-1; j++) {
        if (shape[i][j] == 1) {
          chunks[i][j] = new Chunk(chunkSizeX, chunkSizeY, 
            (shape[i][j-1] == 1), 
            (shape[i+1][j] == 1), 
            (shape[i][j+1] == 1), 
            (shape[i-1][j] == 1), 
            cellSize, monsterFrequencyValue, treasureFrequencyValue, plantFrequencyValue, oilFrequencyValue);
        } else {
          chunks[i][j] = null;
        }
      }
    }
  }

  //methods

  Chunk get(int xIndex, int yIndex) {
    return chunks[xIndex][yIndex];
  }

  int[][] getShape() {
    return shape;
  }

  int[] spawn() {
    spawnIndex[2] = chunks[spawnIndex[0]][spawnIndex[1]].spawn()[0];
    spawnIndex[3] = chunks[spawnIndex[0]][spawnIndex[1]].spawn()[1];

    return spawnIndex;
  }
}

int[][] createDungeonShape(int dimensionX, int dimensionY) {
  int[][] cellStates = new int[dimensionX][dimensionY];

  for (int i = 0; i < dimensionX; i++) {
    for (int j = 0; j < dimensionY; j++) {
      cellStates[i][j] = int(noise(random(100000))*2.15); //2.14
    }
  }

  for (int i = 0; i < 20; i++)  cellStates = shapeUpdate(cellStates, dimensionX, dimensionY);

  // adds guaranteed spawn location everytime (if size is above certain size)

  return cellStates;
}


int[][] shapeUpdate(int[][] array, int dimensionX, int dimensionY) {
  int[][] updatedCellStates = array;

  // adds consistent spawn
  for (int i = floor(dimensionX/2)-2; i < floor(dimensionX/2)+2; i++) {
    for (int j = floor(dimensionY/2)-2; j < floor(dimensionY/2)+2; j++) {
      updatedCellStates[i][j] = 1;
    }
  }

  //this for adding the borders and opening
  for (int i = 0; i < dimensionX; i++) {
    for (int j = 0; j < dimensionY; j++) {
      //makes a black border
      updatedCellStates[i][0] = 0;
      updatedCellStates[dimensionX-1][j] = 0;
      updatedCellStates[i][dimensionY-1] = 0;
      updatedCellStates[0][j] = 0;
    }
  }

  for (int i = 1; i < dimensionX-1; i++) {
    for (int j = 1; j < dimensionY-1; j++) {
      //
      //this is for actually making the shape
      //  N,  NE,  E,  SE,  S,  SW,  W,  NW,
      int surroundingValues = state(array[i][j-1]) + state(array[i+1][j-1])  + state(array[i+1][j])  +
        state(array[i+1][j+1]) + state(array[i][j+1]) + state(array[i-1][j+1]) + state(array[i-1][j]) + state(array[i-1][j-1]);

      if ( array[i][j] == 1 && surroundingValues <= 4) array[i][j] = 1; //dead
      else if ( array[i][j] == 0 && surroundingValues <= 7) array[i][j] = 0; //dead
      else array[i][j] = 1;
    }
  }

  for (int i = 1; i < dimensionX-1; i++) {
    for (int j = 1; j < dimensionY-1; j++) {
      int fourDirectionValues = state(array[i][j-1]) + state(array[i+1][j])  +
        state(array[i][j+1]) + state(array[i-1][j]);
      if ( array[i][j] == 0 && fourDirectionValues >= 3) array[i][j] = floor(random(1));
    }
  }
  for (int i = 1; i < dimensionX-1; i++) {
    for (int j = 1; j < dimensionY-1; j++) {
      int TwoDirectionValues = state(array[i][j-1]) + state(array[i][j+1]);
      if ( array[i][j] == 0 && TwoDirectionValues == 2) array[i][j] = 5;
    }
  }

  return updatedCellStates;
}