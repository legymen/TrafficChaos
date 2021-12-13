int numberOfWalkers = 0;
int numberOfCars = 3;
float walkerMaxSpeed = 0.8;
float walkerMaxForce = 0.02;
float carMaxSpeed = 2.8;
float carMaxForce = 0.05;

boolean debug = true;
boolean mpressed = false;

String state = "MAKE_PATH1";

Path path1, path2;

ArrayList<Car> cars;
ArrayList<Walker> walkers;
ArrayList<TrafficLight> lights;

void setup() {
  size(1600, 1200);

  path1 = new Path();
  path2 = new Path();


  cars = new ArrayList<Car>();
  for (int i = 0; i < numberOfCars; i++){
    cars.add(new Car(new PVector(random(0,width), random(0,height)), carMaxSpeed, carMaxForce));
  }

  walkers = new ArrayList<Walker>();
  for (int i = 0; i < numberOfWalkers; i++){
    walkers.add(new Walker(new PVector(random(0,width), random(0,height)), walkerMaxSpeed, walkerMaxForce));
  }

  lights = new ArrayList<TrafficLight>();
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
      state = "PLACE_LIGHTS";
    }
    path1.render();
    path2.render();  
    break;


    //*********PLACE_LIGHTS**********
    case("PLACE_LIGHTS"):
    if (mousePressed && !mpressed) {
      lights.add(new TrafficLight(mouseX, mouseY));
      mpressed = true;
    } else {
      mpressed = false;
    }
    if (keyPressed && key == '3') {
      state = "RUN";
    }

    path1.render();
    path2.render();

    for (int i = 0; i < lights.size(); i++) {
      TrafficLight light = lights.get(i);
      light.update();
    }

    break;

    //*********RUN**********
    case("RUN"):
    path1.render();
    path2.render();


    for (int i = 0; i < walkers.size(); i++) {
      Walker walker = walkers.get(i);
      walker.follow(path2);
      walker.run();
    }

    for (int i = 0; i < cars.size(); i++) {
      Car car = cars.get(i);
      car.follow(path1);
      car.run();
      car.checkCollision(walkers);
      car.checkStopLights(lights);
    }

    for (int i = 0; i < lights.size(); i++) {
      TrafficLight light = lights.get(i);
      light.update();
    }
    break;


    //**********GAME_OVER*************
    case("GAME_OVER"):
    background(0);
    textSize(100);
    fill(255);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    break;
  }
}
