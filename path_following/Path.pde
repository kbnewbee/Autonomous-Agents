class Path {

  PVector start, end;
  float r;

  Path(PVector s, PVector e) {
    r = 20;
    start = s.copy();
    end = e.copy();
  }

  void display() {
    strokeWeight(r*2);
    stroke(0, 12);
    line(start.x, start.y, end.x, end.y);
    strokeWeight(1);
    stroke(0);
    line(start.x, start.y, end.x, end.y);
  }
}
