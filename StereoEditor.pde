

PImage originalImage;
PImage leftImage;
PImage rightImage;
PImage depthImage;

int xsize, ysize;
float px,py,pz;
boolean[] keydown;
boolean showDepth;

void setup() {
  px=0;
  py=0;
  keydown = new boolean[256];
  loadpic("calf.jpg");
  //loadpic("emmaus.jpg");
  //loadpic("cows.jpg");
  createLeftRightDepth();
  surface.setResizable(true);
  int h = (int)(ysize * pz) + 110;
  surface.setSize(1230, h);
}

void draw() {
  int bg=60;
  background(bg);
  clip(10,100,width/2-15,height-110);
  image(leftImage,10+px,100+py,pz*xsize,pz*ysize);
  clip(width/2+5,100,width/2-15,height-110);
  if (showDepth) image(depthImage,width/2+5+px,100+py,pz*xsize,pz*ysize);
  else image(rightImage,width/2+5+px,100+py,pz*xsize,pz*ysize);
  noClip();
  handleKeys();
  drawButtons();
}


void loadpic(String filename) {
  originalImage = loadImage(filename);
  originalImage.loadPixels();
  xsize = originalImage.width;
  ysize = originalImage.height;
  println("loaded "+filename+" w "+xsize+" h "+ysize);
  pz = Math.min(600.0/xsize,600.0/ysize);
}

void createLeftRightDepth() {
  leftImage = createImage(xsize,ysize,RGB);
  leftImage.copy(originalImage,0,0,xsize,ysize,0,0,xsize,ysize);
  rightImage = createImage(xsize,ysize,RGB);
  rightImage.copy(originalImage,0,0,xsize,ysize,0,0,xsize,ysize);
  depthImage = createImage(xsize,ysize,RGB);
  initDepth(255);
}

void initDepth(int spread) {
  if (spread>255) spread=255;
  for (int x=0; x<xsize; ++x)
    for (int y=0; y<ysize; ++y)
      depthImage.pixels[y*xsize+x] = color(y*spread/ysize+127-spread/2);
  depthImage.updatePixels();
}

// Using the depth image, regenerate the left and right images
void applyDepth() {
  for (int x=0; x<xsize; ++x) {
    for (int y=0; y<ysize; ++y) {
      int i = y*xsize+x;
      int d = (depthImage.pixels[i] & 255) - 127;
      int a = clamp(x + d/2, 0, xsize);
      int b = clamp(x - (d+1)/2, 0, xsize);
      leftImage.pixels[i] = originalImage.pixels[y*xsize+a];
      rightImage.pixels[i] = originalImage.pixels[y*xsize+b];
    }
  }
  leftImage.updatePixels();
  rightImage.updatePixels();
}

// clamp a to the semi open interval [b,c)
int clamp(int a, int b, int c) {
  return a>=c?c-1:a<b?b:a;
}

void drawButtons() {
  noStroke();
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
  println("key down "+keyCode + " " + key);
  int i = keyCode & 255;
  keydown[i]=true;  
}

void keyReleased() {
  println("key up "+keyCode + " " + key);
  int i = keyCode & 255;
  keydown[i]=false;  
}

void keyTyped() {
  if (key=='q') showDepth = !showDepth;
  if (key=='t') applyDepth();
}

void handleKeys() {
  int ss=30;
  float w = xsize*pz - 50;
  float h = ysize*pz - 50;
  //  WASD=move ZX=zoom
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