Path p;
Path1 p1;
ArrayList<Vehicle> vs;


void setup() {
  size(1000, 400);
  p = new Path(new PVector(0, height/2), new PVector(width, height/2));

  vs = new ArrayList<Vehicle>();

  p1 = new Path1();
}
void draw() {
  background(255);
  if (mousePressed) {
    Vehicle v = new Vehicle(mouseX, mouseY);
    vs.add(v);
  }

  p1.display();



  for (Vehicle v : vs) {
    v.follow(p1);
    v.update();
    v.borders(p1);
    v.display();
  }
}
