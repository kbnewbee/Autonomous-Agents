class Vehicle {
  PVector loc;
  PVector vel;
  PVector acc;

  float ir;
  float maxforce;
  float maxspeed;

  Vehicle() {
    loc = new PVector(100, 100);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    maxspeed = 4;
    maxforce = 0.1;
    ir = 100;
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, loc);
    desired.setMag(maxspeed);

    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);

    applyForce(steer);
  }

  void arrive(PVector target) { 
    PVector desired = PVector.sub(target, loc);
    float d = desired.mag();

    if (d < ir) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else {        
      desired.setMag(maxspeed);
    }

    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);

    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }

  void display() {
    fill(0);
    ellipse(loc.x, loc.y, 20, 20);
  }
}
