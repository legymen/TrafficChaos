TrafficLight light1, light2

void setup() {
  size(1000, 800);

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(500, 200);
}

void draw() {
  background(180);

  light1.update();
  light2.update();
}
