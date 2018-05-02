PImage img;
float px,py,pz;
boolean[] keydown;

void setup() {
  //size(1230,700);
  px=0;
  py=0;
  keydown = new boolean[256];
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
  clip(10,100,width/2-15,height-110);
  image(img,10+px,100+py,pz*img.width,pz*img.height);
  clip(width/2+5,100,width/2-15,height-110);
  image(img,width/2+5+px,100+py,pz*img.width,pz*img.height);
  noClip();
  //fill(bg);
  noStroke();
  //rect(width-10,100,10,height-100);
  //rect(width/2-5,100,10,height-100);
  fill(0);
  rect(0,0,width,90);
  handleKeys();
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
  println("key down "+keyCode + " " + key);
  int i = keyCode & 255;
  keydown[i]=true;  
}

void keyReleased() {
  println("key up "+keyCode + " " + key);
  int i = keyCode & 255;
  keydown[i]=false;  
}

void handleKeys() {
  int ss=30;
  float w=img.width*pz -50;
  float h = img.height*pz-50;
  if (keydown[90]) zoom(1.1); 
  if (keydown[88]) zoom(1/1.1); 
  if (keydown[65] && px > -w) px -= ss; 
  if (keydown[68] && px < w) px += ss; 
  if (keydown[87] && py > -h) py -= ss; 
  if (keydown[83] && py < h) py += ss; 
}

void zoom(float f) {
  pz *= f;
  int w = width/4;
  int h = (height-100)/2;
  px += (w - px) * (pz/f - pz);
  py += (h - py) * (pz/f - pz);
}