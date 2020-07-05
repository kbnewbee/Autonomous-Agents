class  Target {
  float x=0, y=0;
  float r;
  float a;
  float a_vel;
  float a_acc;

  Target() {

    r = 150;
    a = 0;
    a_vel = 0.02;
    a_acc = 0;
  }


  void update() {

    a_vel += a_acc;
    a += a_vel;

    translate(width/2, height/2);
    x = r*sin(a);
    y = r*cos(a);
  }

  void display() {
    fill(0);
    stroke(0);
    ellipse(x, y, 10, 10);
  }
}
