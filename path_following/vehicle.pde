class Vehicle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;

  float ir;
  float maxforce;
  float maxspeed;

  Vehicle(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(2, 0);
    acc = new PVector(0, 0);
    r = 6;
    maxspeed = 4;
    maxforce = 0.1;
    ir = 100;
  }

  void follow(Path p) {
    PVector predict = vel.copy();
    predict.setMag(50);
    PVector predPos = PVector.add(loc, predict);

    PVector a = p.start;
    PVector b = p.end;
    PVector norm = normalP(predPos, a, b);

    PVector dir = PVector.sub(b, a);
    dir.setMag(10);
    PVector target = PVector.add(norm, dir);

    float dist = PVector.dist(predPos, norm);

    if (dist > p.r) {
      //println(dist);
      seek(target);
    }
  }

  void follow(Path1 p) {
    PVector predict = vel.copy();
    predict.setMag(50);
    PVector predPos = PVector.add(loc, predict);

    float dist = width;
    PVector target = null;

    for (int i=0; i <p.points.size()-1; i++) {
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      PVector norm = normalP(predPos, a, b);
      if (norm.x < a.x || norm.x > b.x) {
        norm = b.copy();
      }

      float tdist = PVector.dist(predPos, norm);

      if (tdist < dist) {
        dist = tdist;

        PVector dir = PVector.sub(b, a);
        dir.setMag(10);
        target = PVector.add(norm, dir);
      }
    }
    //println(dist);

    if (dist > 20) {
      println(0);
      seek(target);
    }
  }

  PVector normalP(PVector p, PVector a, PVector b) {
    PVector ab = PVector.sub(b, a);
    PVector ap = PVector.sub(p, a);

    ab.normalize();
    ab.mult(ap.dot(ab));
    PVector normalPoint = PVector.add(a, ab);
    return normalPoint;
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, loc);
    desired.setMag(maxspeed);

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
    float theta = vel.heading() + radians(90);
    fill(0, 64);
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

  void borders(Path1 p) {
    //if (loc.x > p.end.x) {
    //  loc.x = p.start.x ;
    //  loc.y = p.start.y + (loc.y-p.end.y);
    //}

    if (loc.x > p.getEnd().x) {
      loc.x = p.getStart().x ;
      loc.y = p.getStart().y + (loc.y-p.getEnd().y);
    }
  }
}
