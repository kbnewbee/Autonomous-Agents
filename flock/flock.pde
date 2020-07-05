
ArrayList<Vehicle> vs;

boolean flow = false;

void setup() {
  size(1200, 800, P2D);

  vs = new ArrayList<Vehicle>();
  for (int i=0; i<100; i++) {
    Vehicle v = new Vehicle(random(width), random(height));
    vs.add(v);
  }
}
void draw() {
  background(0, 0, 255);

  for (Vehicle v : vs) {
    v.align(vs);
    v.separate(vs);
    v.cohesion(vs);
    v.run();
  }
}

void mouseDragged() {
  vs.add(new Vehicle(mouseX, mouseY));
}
