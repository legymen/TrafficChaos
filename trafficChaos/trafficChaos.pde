boolean debug = true;
boolean pressed = false;

String state = "MAKE_PATH";

Path path1;

Car car1;
Car car2;

Walker walker1, walker2;

TrafficLight light1, light2;

void setup() {
  size(1600, 1200);

  path1 = new Path();

  car1 = new Car(new PVector(0, height/2), 2, 0.04);
  car2 = new Car(new PVector(0, height/2), 3, 0.1);

  walker1 = new Walker(new PVector(0, height/2), 2, 0.04);
  walker2 = new Walker(new PVector(0, height/2), 3, 0.1);

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(800, 300);
}

void draw() {
  background(140);

  switch(state) {
    case("MAKE_PATH"):
    if (mousePressed && !pressed) {
      path1.addPoint(mouseX, mouseY);
      pressed = true;
    } else {
      pressed = false;
    }
    if (keyPressed && key == 'd') {
      state = "RUN";
    }    
    path1.render();   
    break;

    case("RUN"):
    path1.render();

/*     car1.follow(path1);
    car2.follow(path1);

    car1.run();
    car2.run();

    car1.borders(path1);
    car2.borders(path1); */

    walker1.follow(path1);
    // walker2.follow(path1);

    walker1.run();
    // walker2.run();

    walker1.borders(path1);
    // walker2.borders(path1);

    // light1.update();
    // light2.update();
    break;
  }
}

public void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}
