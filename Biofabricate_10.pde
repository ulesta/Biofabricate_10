import geomerative.*;
import processing.opengl.*;
//import processing.xml.*;

// global variables




// global params
float maxSegments = 10.0; // maximum segments length

String word = "B";


ArrayList <Particle> particles; // the list of particles
int startPoint = (int)random(50);

void setup() {
  // Initilaize the sketch
  size(400, 400, OPENGL);
//  background(255);

  frameRate(30);
  particles = new ArrayList <Particle>(); // create particles

  ve = new ArrayList();

  // Always initialize Geomeratie library
  RG.init(this);

  // Assign variables
  font = new RFont("Futura-Medium.ttf", 150, RFont.CENTER);
  shp = font.toShape(word);
  shp.translate(width/2, height/2 + shp.getHeight()/2);

  fill(0,255,0);
  // Enable smoothing
  smooth();
  exVert(shp);

  RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizerLength(maxSegments);
  println("# of points: " + ve.size());
  
//  println(shp.getTopLeft().x);

}

void draw() {
  background(255);

  if (nve < ve.size()) {
//    strokeWeight(map(mouseY, 0, height, 1, 10));
    if (((Point) ve.get(nve)).z != -55.0) {
      fill(0);
      particles.add(new Particle(((Point) ve.get(nve-1)).x, ((Point) ve.get(nve-1)).y));
//      ellipse(((Point) ve.get(nve-1)).x, ((Point) ve.get(nve-1)).y, 4,4);
    }
    nve++;
  }
//  } else { // restart drawing
////    delay(3000);
////    particles.clear();
//    background(255);
//    nve = 0;
//  }
  
  for (Particle p : particles) {
    p.run();
    p.display(particles);
  }
  addRemoveParticles();
  // frame rate for debugging
  fill(0);
  rect(0, height-20, width, 20);
  fill(255);
  text("Framerate: " + int(frameRate), 10, height-6);
}





