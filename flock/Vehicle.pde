class Vehicle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float maxforce;
  float maxspeed;

  Vehicle(float x, float y) {
    loc = new PVector(x, y);
    //vel = new PVector(1, 0);
    acc = new PVector(0, 0);

    vel = PVector.random2D();
    vel.mult(random(1, 4));
    r = 3;
    maxspeed = 3;
    maxforce = 0.2;
  }

  void separate(ArrayList<Vehicle> vs) {
    float sd = 40;
    PVector sum = new PVector(0, 0);
    int cnt = 0;
    for (Vehicle other : vs) {
      float d= PVector.dist(loc, other.loc);
      if (d > 0 && d < sd) {
        PVector dir = PVector.sub(loc, other.loc);
        dir.normalize();
        dir.div(d);
        sum.add(dir);
        cnt++;
      }
    }

    if (cnt > 0) {
      sum.div((float)cnt);
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, vel);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

  void align(ArrayList<Vehicle> vs) {
    float nd = 30;
    PVector sum = new PVector(0, 0);
    int cnt = 0;
    for (Vehicle other : vs) {
      float d= PVector.dist(loc, other.loc);
      if (d > 0 && d < nd) {
        sum.add(other.vel);
        cnt++;
      }
    }

    if (cnt > 0) {
      sum.div((float)cnt);
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, vel);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

  void cohesion(ArrayList<Vehicle> vs) {
    float nd = 20;
    PVector sum = new PVector(0, 0);
    int cnt = 0;
    for (Vehicle other : vs) {
      float d= PVector.dist(loc, other.loc);
      if (d > 0 && d < nd) {
        sum.add(other.loc);
        cnt++;
      }
    }

    if (cnt > 0) {
      sum.div((float)cnt);
      seek(sum);
    }
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, loc);
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
