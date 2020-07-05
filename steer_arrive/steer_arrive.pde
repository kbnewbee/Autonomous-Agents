Vehicle v;

void setup() {
  size(600, 400);
  v = new Vehicle();
}
void draw() {

  background(255);

  fill(127, 64);
  stroke(0);
  ellipse(mouseX, mouseY, 40, 40);

  //v.seek(new PVector(mouseX, mouseY));
  v.arrive(new PVector(mouseX, mouseY));
  v.update();
  v.display();
}
