class Vehicle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;

  float ir;
  float maxforce;
  float maxspeed;

  Vehicle() {
    loc = new PVector(0, 0);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = 6;
    maxspeed = 6;
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
    float theta = vel.heading2D() + radians(90);
    fill(127);
    stroke(0);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}
