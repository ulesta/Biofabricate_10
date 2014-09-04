// Daniel Shiffman's code for autonomous agents
class Particle {
  PVector loc, vel, acc, target;
  float maxLife, life, lifeRate, maxSpeed, maxForce, maxSpeed2;
  float r;

  // constructor with x and y inputs
  Particle(float x, float y) {
    r = random(8) + 1;
    getPosition(); // target location
    loc = new PVector(x, y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    
    // set the maximum life of the Particles depending on the drawMode
    maxLife = 10; 
    
    // randomly set a life and lifeRate for each Particle
    life = random(0.2 * maxLife, maxLife);
    lifeRate = random(0.01, 0.02);
    maxForce = 6;
    maxSpeed = 0.1;
    maxSpeed2 = 0.4;
  }
  
  void run() {
    update();
    seek();
  }

  void update() {
    maxSpeed += 0.005;
    loc.add(vel);
    vel.add(acc);
    vel.limit(maxSpeed2);
    acc.mult(0);
    
    life -= lifeRate;
    // decrease life by the lifeRate (the particle is removed by the addRemoveParticles() method when no life is left)
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
  
  // Our seek steering force algorithm
  void seek() {
    PVector desired = PVector.sub(target,loc);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void display(ArrayList<Particle> particles) {
    for (Particle other: particles) {
      float d = PVector.dist(loc, other.loc);   
      if ( d < 50) {
        stroke(d, 50-d);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
      }
    }
  }
  
  boolean isDead() {
    if (life < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
  // AmnonOwed code to get a random position inside the text
  void getPosition() {
    while (target == null || !isInText (target)) target = new PVector(random(width), random(height));
  }

  // return if point is inside the text
  boolean isInText(PVector v) {
    return shp.contains(int(v.x), int(v.y));
  }
}

