class Vehicle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;

  float ir;
  float maxforce;
  float maxspeed;

  Vehicle(PVector l, float ms, float mf) {
    loc = l.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = 3;
    maxspeed = ms;
    maxforce = mf;
    ir = 100;
  }

  void follow(Flowf f) {
    PVector desired = f.lookup(loc);
    desired.setMag(maxspeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void run() {
    borders();
    update();
    display();
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
    float theta = vel.heading() + radians(90);
    fill(255);
    stroke(255);
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

  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }
}
