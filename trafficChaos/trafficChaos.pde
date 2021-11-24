boolean debug = true;
boolean pressed = false;

String state = "MAKE_PATH";

Path path;

Car car1;
Car car2;

TrafficLight light1, light2;

void setup() {
  size(1600, 1200);

  path = new Path();

  car1 = new Car(new PVector(0, height/2), 2, 0.04);
  car2 = new Car(new PVector(0, height/2), 3, 0.1);

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(800, 300);
}

void draw() {
  background(140);

  switch(state) {
    case("MAKE_PATH"):
    if (mousePressed && !pressed) {
      path.addPoint(mouseX, mouseY);
      pressed = true;
    } else {
      pressed = false;
    }
    if (keyPressed && key == 'd') {
      state = "RUN";
    }    
    path.render();   
    break;

    case("RUN"):
    path.render();

    car1.follow(path);
    car2.follow(path);

    car1.run();
    car2.run();

    car1.borders(path);
    car2.borders(path);

    light1.update();
    light2.update();
    break;
  }
}

public void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}
