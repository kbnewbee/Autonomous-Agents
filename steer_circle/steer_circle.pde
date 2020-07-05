Vehicle v;
Target t;

void setup() {
  size(600, 400);
  v = new Vehicle();
  t = new Target();
}
void draw() {

  background(255);
  
  noFill();
  stroke(0);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, 300, 300);

  t.update();
  t.display();

  v.arrive(new PVector(t.x, t.y));
  //v.arrive(new PVector(mouseX, mouseY));
  v.update();
  v.display();
}
