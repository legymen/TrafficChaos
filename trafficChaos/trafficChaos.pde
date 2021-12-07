int numberOfWalkers = 10;
float walkerMaxSpeed = 0.8;
float walkerMaxForce = 0.02;

boolean debug = true;
boolean mpressed = false;

String state = "MAKE_PATH1";

Path path1, path2;

Car car1, car2;

ArrayList<Walker> walkers;
TrafficLight light1, light2;

void setup() {
  size(1600, 1200);

  path1 = new Path();
  path2 = new Path();

  car1 = new Car(new PVector(0, height/2), 2, 0.04);
  car2 = new Car(new PVector(0, height/2), 3, 0.1);

  walkers = new ArrayList<Walker>();

  for (int i = 0; i < numberOfWalkers; i++){
    walkers.add(new Walker(new PVector(random(0,width), random(0,height)), walkerMaxSpeed, walkerMaxForce));
  }

  light1 = new TrafficLight(50, 200);
  light2 = new TrafficLight(800, 300);
}

void draw() {
  background(140);

  switch(state) {

    //*********MAKE_PATH1**********
    case("MAKE_PATH1"):
    if (mousePressed && !mpressed) {
      path1.addPoint(mouseX, mouseY);
      mpressed = true;
    } else {
      mpressed = false;
    }
    if (keyPressed && key == '1') {
      state = "MAKE_PATH2";
    }  
    path1.render();   
    break;

    //*********MAKE_PATH2**********
    case("MAKE_PATH2"):
    if (mousePressed && !mpressed) {
      path2.addPoint(mouseX, mouseY);
      mpressed = true;
    } else {
      mpressed = false;
    }
    if (keyPressed && key == '2') {
      state = "RUN";
    }
    path1.render();
    path2.render();  
    break;

    //*********RUN**********
    case("RUN"):
    path1.render();
    path2.render();

    car1.follow(path1);
    car2.follow(path1);

    car1.run();
    car2.run();

    for (int i = 0; i < walkers.size(); i++) {
      Walker walker = walkers.get(i);
      walker.follow(path2);
      walker.run();
    }

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
