import geomerative.*;
import processing.opengl.*;
//import processing.xml.*;

Letter letterB, letterI;
PGraphics g1;
PGraphics g2;

void setup() {
  // Initilaize the sketch
  size(700, 400, OPENGL);
//  background(255);

  frameRate(30);
  
  // Always initialize Geomeratie library
  RG.init(this);
  RG.setPolygonizer(RG.ADAPTATIVE);
  g1 = createGraphics(200,200,JAVA2D);
  g2 = createGraphics(200,200,JAVA2D);
  g1.beginDraw();
  letterB = new Letter("B");
  g1.endDraw();
  
  g2.beginDraw();
  letterI = new Letter("I");
  g2.endDraw();
  //println(shp.getTopLeft().x);

}

void draw() {
  background(255);
  letterB.display();
  pushMatrix();
  translate(200,0);
  letterI.display();
  popMatrix();

}





