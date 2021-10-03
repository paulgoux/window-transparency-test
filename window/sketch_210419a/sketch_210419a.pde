class homeWindow extends PApplet {
  homeWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
};
homeWindow h;
boolean mdown;
  void settings() {

    size(1000, 300);
  };

  void setup() {
    background(150);
  };

  void draw() {
    if (focused != true) {

      redraw();
    }
    if(mousePressed&&!mdown){
      h = new homeWindow();
      
    }
  };
