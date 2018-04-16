PImage img;
float px,py,pz;


void setup() {
  //size(1230,700);
  px=0;
  py=0;
  //img = loadImage("emmaus.jpg");
  //img = loadImage("cows.jpg");
  img = loadImage("calf.jpg");
  println("loaded cows w "+img.width+" h "+img.height);
  pz=Math.min(600.0/img.width,600.0/img.height);
  surface.setResizable(true);
  int h = (int)(img.height * pz) + 110;
  surface.setSize(1230, h);
}

void draw() {
  int bg=60;
  background(bg);
  image(img,10,100,pz*img.width,pz*img.height);
  image(img,width/2+5,100,pz*img.width,pz*img.height);
  fill(bg);
  noStroke();
  rect(width-10,100,10,height-100);
  rect(width/2-5,100,10,height-100);
  fill(0);
  rect(0,0,width,90);
}

void mousePressed(MouseEvent event) {
  println("+button "+event.getButton()+" mod " + event.getModifiers());
}

void mouseReleased(MouseEvent event) {
  println("-button "+event.getButton()+" mod " + event.getModifiers());
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println("wheel " + e);
}

void mouseMoved() {
}

void keyPressed() {
  println("key "+keyCode);
}