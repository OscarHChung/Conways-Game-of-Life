
final int ROWS = 40;
final int COLS = 60;
final int CELL_WIDTH = 15;
final int CELL_HEIGHT = 15;
final int LEFT_OFFSET = 12;  // From left of window to left side of grid
final int TOP_OFFSET = 12;   // From top of window to top of grid
// From top of window to bottom of grid
final int BOTTOM_GRID_OFFSET = TOP_OFFSET + (CELL_HEIGHT+1)*ROWS;
// From top of window to top of buttons
final int BUTTON_Y_OFFSET = BOTTOM_GRID_OFFSET + 12;
final int BUTTON_WIDTH = 100;
final int BUTTON_HEIGHT = 40;

// Array of Cells
Cell[][] cell = new Cell[ROWS][COLS];

// state:
//   STOPPED  -> No animation
//   STEPPING -> Step one iteration
//   RUNNING  -> Play continuous iterations
enum STATE { STOPPED, STEPPING, RUNNING };
STATE state = STATE.STOPPED;

void setup() {
  // It turns out that numeric literals have to be entered 
  // into the first two arguments of the size() procedure.
  // The size cannot be determined by defined constants.
  size(1024, 768);
  
  // Initialize grid of cells
  initGrid();
  
  // Creates a glider on the corners of the grid
  setUpCells();
  
  // Initialize font for drawing buttons
  initFont();
}

// draw() is effectively inside an infinite loop.
void draw() {
  background(#FFFFFF);
  stroke(#000000);
  
  // 1: step, 2: start
  if (state == STATE.STEPPING || state == STATE.RUNNING) {
    // Each cell determines how many neighbors it has
       calcNeighbors();
       
    // Each cell updates is alive/dead status
       updateAlive();

    // 50ms delay between animation updates
    if (state == STATE.RUNNING) {
      delay(50);
    }
    
    // if done with single step, return to original state 
    if (state == STATE.STEPPING) {
      state = STATE.STOPPED;  
    }
  }
 
  // All cells draw themselves as alive/dead on the grid
  displayCells();  
  
  // Draw buttons
  // Start, Stop, Clear rectangles in gray
  drawButtons();
}

void calcNeighbors() {
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      cell[r][c].calculateNeighbors();
    }
  }
}

void updateAlive() {
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      cell[r][c].updateAlive();
    }
  }
}

void displayCells() {
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      cell[r][c].display(LEFT_OFFSET, TOP_OFFSET, CELL_WIDTH, CELL_HEIGHT);
    }
  }
}

void drawButtons() {
  // Start, Stop, Clear rectangles in gray
  fill(#DDDDDD);
  for (int i = 0; i < 3; i++) {
    rect(LEFT_OFFSET+i*(BUTTON_WIDTH+12), BUTTON_Y_OFFSET, BUTTON_WIDTH, BUTTON_HEIGHT);
  }
  
  // Set text color on the buttons to blue
  fill(#0000FF);
  // Draw Start/Stop, Step, Clear text onto the gray buttons
  text((state == STATE.RUNNING) ? "Stop" : "Start", LEFT_OFFSET+50, BUTTON_Y_OFFSET+12); 
  text("Step", LEFT_OFFSET+50+BUTTON_WIDTH+12, BUTTON_Y_OFFSET+12); 
  text("Clear", LEFT_OFFSET+50+2*(BUTTON_WIDTH+12), BUTTON_Y_OFFSET+12); 
}

void initGrid() {
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      cell[r][c] = new Cell(r, c);
    }
  }
}

void setUpCells() {
  cell[ROWS-1][COLS-1].setAlive(true);
  cell[ROWS-1][0].setAlive(true);
  cell[ROWS-1][1].setAlive(true);
  cell[0][1].setAlive(true);
  cell[1][0].setAlive(true);
}

void initFont() {
  textSize(32);
  PFont font = createFont("ComicSansMS-Bold", 32);
  textFont(font);
  textAlign(CENTER, CENTER);
}
