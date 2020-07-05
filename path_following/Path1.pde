class Path1 {

  float r;
  ArrayList<PVector> points;

  Path1() {
    r = 20;
    points  = new ArrayList<PVector>();

    //shape
    float a = 0.0;
    for (float x=0; x<width; x+=5) {
      float y = map(sin(a), -1, 1, 100, 300);
      a += 0.05;

      PVector point = new PVector(x, y);
      points.add(point);
    }
  }

  PVector getStart() {
    return points.get(0);
  }

  PVector getEnd() {
    return points.get(points.size()-1);
  }


  void display() {
    strokeWeight(r*2);
    stroke(0,0,255,64);
    noFill();
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape();

    strokeWeight(1);
    stroke(255,0,0);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
