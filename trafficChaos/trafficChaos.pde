TrafficLight light1, light2;

void setup() {
  size(1600, 1200);

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(800, 300);
}

void draw() {
  background(140);

  light1.update();
  light2.update();
}
