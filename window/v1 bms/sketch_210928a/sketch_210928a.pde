wnd w;
BMS b;
void setup(){
  size(1000,600,P2D);
  b = new BMS(this);
  w = new wnd(100,300,500,500,"c:/",b);
  w.toggle = true;
  //w.close = false;
};

void draw(){
  background(50);
  b.runEmpty();
  //w.open = true;
  w.displayGrid();
  b.theme.run();
  //w.fileName.draw();
};
