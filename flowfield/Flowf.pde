class Flowf {

  PVector[][] f;
  int cols, rows;
  int res;

  Flowf(int r) {
    res = r;
    cols = width/res;
    rows = height/res;
    f = new PVector[cols][rows];
    init();
  }

  void init() {
    noiseSeed((int)random(10000));
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        f[i][j] = new PVector(cos(theta), sin(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }

  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(f[i][j], i*res, j*res, res-2);
      }
    }
  }

  void drawVector(PVector v, float x, float y, float s) {
    pushMatrix();
    translate(x, y);
    stroke(0);
    rotate(v.heading());
    float len = v.mag()*s;
    line(0, 0, len, 0);
    popMatrix();
  }

  PVector lookup(PVector l) {
    int col = int(constrain(l.x/res, 0, cols-1));
    int row = int(constrain(l.y/res, 0, rows-1));
    return f[col][row].copy();
  }
}
