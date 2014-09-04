class Letter extends Thread{

  private String letter;
  private RShape shp;
  private RFont font;
  private RPoint[][] pnts;  

  private ArrayList ve; // empty array list
  private int count = 1;

  private ArrayList <Particle> particles; // the list of particles
  private float maxSegments = 10.0; // maximum segments length
  
  private PGraphics pg;

  Letter(String letter_) {
    letter = letter_;

    particles = new ArrayList <Particle>(); // create particles

    ve = new ArrayList();
    
    pg = createGraphics(200,200,JAVA2D);

    // Assign variables
    font = new RFont("Futura-Medium.ttf", 250, RFont.CENTER);
    shp = font.toShape(letter);
    shp.translate(width/2, height/2 + shp.getHeight()/2);

    fill(0, 255, 0);
    // Enable smoothing
    smooth();
    exVert(shp);

// [Justin] By commenting these out, it seems to work. What does this do? 
    //RG.setPolygonizer(RG.ADAPTATIVE);
    //RG.setPolygonizerLength(maxSegments);
    
    shp = RG.polygonize(shp);
    println("# of points: " + ve.size());
  }

  void display() {
    shp.draw();
    System.out.println("I am running: " + letter + "\t I have ve: " + ve.size() );
    if (count < ve.size()) {
      //    strokeWeight(map(mouseY, 0, height, 1, 10));
      if (((Point) ve.get(count)).z != -55.0) {
        fill(0);
        particles.add(new Particle(((Point) ve.get(count-1)).x, ((Point) ve.get(count-1)).y, shp));
        //      ellipse(((Point) ve.get(nve-1)).x, ((Point) ve.get(nve-1)).y, 4,4);
      }
      count++;
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

  void exVert(RShape s) {
    RShape[] ch; // children
    int n = s.countChildren();
    if (n > 0) {
      ch = s.children;
      for (int i = 0; i < n; i++) {
        exVert(ch[i]);
      }
    } else { // no children -> work on vertex
      pnts = s.getPointsInPaths();
      n = pnts.length;
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < pnts[i].length; j++) {
          ellipse(pnts[i][j].x, pnts[i][j].y, 5, 5);
          // display points of font
          if (j==0)
            ve.add(new Point(pnts[i][j].x, pnts[i][j].y, -10.0));
          else
            ve.add(new Point(pnts[i][j].x, pnts[i][j].y, 0.0));
        }
      }
      println("# of paths for " + letter + ": " + s.countPaths());
    }
  }

  void addRemoveParticles() {
    // remove particles with no life left
    for (int i=particles.size ()-1; i>=0; i--) {
      Particle p = particles.get(i);
      if (p.life <= 0) {
        particles.remove(i);
      }
    }
  }
  
//  void start() {
//    running = true;
//  }
//  
//  void run() {
//  }
}

