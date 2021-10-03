class wnd extends Window{
  //applet = b;
  wnd(float xx,float yy,float ww,float hh,String dir,BMS bms){
    //super(b);
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    bw = w;
    bh = h;
    Bms = bms;
    applet = bms.applet;
    theme = Bms.theme;
    list = fileUtils.listFileNames(dir);
    link = dir;
    currentp = dir;
    
    initqNav();
    initGrid();
    //cols = 10;
    println(buttons.size(),cols);
    canvas1 = applet.createGraphics((int)w-10,(int)(rowheight*3.5));
    canvas2 = applet.createGraphics((int)w-10,(int)(rowheight*3.5));
  };
  
  wnd(boolean k){
    initqNav();
  };
  
  public void displayGrid(){
    //    
    h = (7+1) * 50;
    //if(mousePressed)
    
    open = true;
    Slider s = null;
    if(sliders.get(0)!=null)s = sliders.get(0);
    s.h = h;
    s.setRadius(0,0,20,0);
    if(toggle||applet.frameCount==0) {
      open = true;
    }else {
      open = false;
    }
    if(close){
      toggle = false;
      open = false;
      close = false;
    }

    if(open||firstRun||buttonHover) {
      canvas1.beginDraw();
      canvas1.background(255,0);
      //canvas1.fill(theme.windowfillcol,theme.windowtransparency/40);
      canvas1.noStroke();
      //if(firstRun||buttonHover)canvas1.rect(0,0,w,h,r1,r2,r3,r4);
    }

    if(open){
      Window w2 = windows.get(windows.size()-1);
      mouse = getMouse();
      float ay = 70;
      if(w2!=null&&!fileDir.toggle) {
        fileDir.label = w2.link;
      }
      //else fileDir.textBox = "";
      
      fileName.setPos(x+20,y+h-ay);
      fileDir.setPos(x+90,y - 45);
      select.setPos(fileName.x+20+fileName.w,y+h-ay);
      drawBorder();
      drawNav();
//      if(getClose())close = true;
      //id();
      drawRapidOptions();
      select.draw();
      select.toggleAll();
      select.toggle(0,this,"close");
      select.toggle(1,this,"close");
      drawScrollbar();
      gridlogic();
      grid();
      fileName.draw();
      fileDir.draw();

      if(open||firstRun) {
        canvas1.endDraw();
        update = false;
        firstRun = false;
      }
    }
    
    if(open)applet.image(canvas1,x,y);
  };
  
  public void grid(){
    Window w2 = windows.get(windows.size()-1);
    Slider s = sliders.get(0);
    //    s.mouseFunctions();

    //    s.set(0,2000);
    mouse = getMouse();
    mouse.y+=20-s.value;
    counter = 0;
//    applet.println("window",y,h);
    int miny = (int)(s.value/rowheight);
//    applet.println("window",miny,rows);
    int maxy = miny+5;
    if(true) {
      for(int i=0;i<7;i++){
        maxy = miny+5;
        for(int j=0;j<10;j++){

          int pos = j+i*cols;
          Button b = null;
          
          if(pos<w2.buttonGrid.size()){
            b = w2.buttonGrid.get(pos);
            Button b1 = w2.buttons.get(pos);
            b.visible = false;
//            applet.println(b.tsize);
//            if(pos==0)
            //applet.println(pos,i,j);
            if(w2.init)b.setPos( 10 + colwidth * j,
            10 + (rowheight+b.tsize) * i);
            b.y = b.by - s.value+20;
            
            b.mouse = mouse;
            //b.highlight(mouse);
            b.draw(canvas1);
            b.textbtm = true;
            
            b.yoff = -20;
            b.parentCanvas = true;
            if(!b.textcheck)b.labelcheck(colwidth);
//            
            boolean k = b.pos(mouse);
            b.set = true;
            //if(b.visible)
            if(k&&b.submenu!=null&&track.size()<1){
              int size = currentp.length();
              if(currentp.charAt(size-1)!='\\')currentp += "\\";
              currentl = currentp + b.blabel;
            }
            else if(k&&b.submenu==null){
              int size = currentp.length();
              if(currentp.charAt(size-1)!='\\')currentp += "\\";
              currentf = currentp + b.blabel;
            }
            if(k&&theme.dclick&&b1.submenu!=null&&!smdown&&track.size()<1){
              int size = currentp.length();
              if(currentp.charAt(size-1)!='\\')currentp += "\\";
              back = currentp;
              currentp += b.blabel;
              forward = currentp;
              Window w1 = new Window(w2.x+200,w2.y,w,h,currentp,Bms);
              windows.add(w1);
              windex = 0;
              s.value = 0;
              s.valuex = 0;
              wid = windows.size()-1;
              smdown = true;
              currentFolder = currentf;
            }
            else if(k&&theme.dclick&&b1.submenu==null&&!smdown&&track.size()<1){
              int size = currentp.length();
              if(currentp.charAt(size-1)!='\\')currentp += "\\";
              String file = currentp + b.blabel;
              currentf = file;
              currentLink = currentf;
              //if(launchable)launch(file);
              smdown = true;
            }
            if(k)counter++;
//            //            rect
          }
          }}
      w2.init = true;
    }
    buttonHover = counter>0;
    if(!applet.mousePressed)smdown = false;
  };
  
};
