class Cell {
  public int col;
  public int row;
  
  private boolean amAlive = false;  // cell starts dead by default
  private int neighbors = 0;        // neighbors yet to be counted
  private final color DEAD_COLOR = color(#E8E8E8);
  private final color ALIVE_COLOR = color(#FF6600);
  
  public Cell(int row, int col) {
    this.col = col;
    this.row = row;
  }
  
  public void toggleAlive() { amAlive = !amAlive; }
  public void setAlive(boolean alive) { amAlive = alive; }
  public boolean isAlive() { return amAlive; }
  
  public void display(int xoffset, int yoffset, int w, int h) {
    xoffset += (w+1) * col;
    yoffset += (h+1) * row;
    color fillColor = amAlive ? ALIVE_COLOR : DEAD_COLOR;
    fill(fillColor);
    rect(xoffset, yoffset, w, h);
  }
    
  // Set this cell to alive or dead based on current state
  // of amAlive and the number of live neighbors
  public void updateAlive() {
    // Try to figure out an expression using Boolean operator(s) such
    // as && and || along with neighbor count and current alive/dead state
    // to solve this without using if/else
    if (!isAlive()) {
       if (neighbors == 3) {
         toggleAlive();
       }
    }
    //alive case
    else {
      if(neighbors > 3 || neighbors < 2){
        //become dead
        toggleAlive();
      }
    }
   
      
      
  }
  
  // Compute the number of live neighbors for this cell 
  // and return that number
  public int calculateNeighbors() {
     // YOUR_CODE_HERE
     neighbors = 0;
     for (int i = -1; i < 2; i++) {
       for (int n = -1; n < 2; n++) {
         if(i == 0 && n == 0){
           continue;
           //System.out.println(0);
         }
         if(cell[(row+i+ROWS)%ROWS][(col+n+COLS)%COLS].isAlive()){
           neighbors++;
         }
       }
     }
     return 0; // stub
  }
}
