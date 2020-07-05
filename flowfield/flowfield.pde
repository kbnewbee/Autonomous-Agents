Flowf flowf;
ArrayList<Vehicle> vs;

boolean flow = false;

void setup() {
  size(1200, 800, P2D);
  flowf  = new Flowf(10);
  vs = new ArrayList<Vehicle>();
  for (int i=0; i<100; i++) {
    Vehicle v = new Vehicle(new PVector(random(width), random(height)), random(2, 10), random(0.1, 1));
    vs.add(v);
  }
}
void draw() {
  background(0, 0, 255);


  if (mousePressed) {
    Vehicle v = new Vehicle(new PVector(mouseX, mouseY), random(2, 10), random(0.1, 1));
    vs.add(v);
    flowf.init();
  }

  for (Vehicle v : vs) {
    v.follow(flowf);
    v.run();
  }
  if (flow) {
    flowf.display();
  }
}

void keyPressed() {
  if (key == ' ') {
    flow = !flow;
  }
}
