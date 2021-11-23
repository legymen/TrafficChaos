boolean debug = true;

Path path;

Car car1;
Car car2;

TrafficLight light1, light2;

void setup() {
  size(1600, 1200);

  newPath();

  car1 = new Car(new PVector(0, height/2), 2, 0.04);
  car2 = new Car(new PVector(0, height/2), 3, 0.1);

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(800, 300);
}

void draw() {
  background(140);

  path.render();

  car1.follow(path);
  car2.follow(path);

  car1.run();
  car2.run();

  car1.borders(path);
  car2.borders(path);

  light1.update();
  light2.update();
}

void newPath(){
  path = new Path();
  path.addPoint(-20, height/2);
  path.addPoint(random(0, width/2), random(0, height));
  path.addPoint(random(width/2, width), random(0, height));
  path.addPoint(width+20, height/2);
}

public void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}

public void mousePressed() {
  newPath();
}