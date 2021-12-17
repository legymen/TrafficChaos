// Settings variables
int numberOfWalkers = 2;
int numberOfCars = 3;
float walkerMaxSpeed = 0.8;
float walkerMaxForce = 0.02;
float carMaxSpeed = 2.8;
float carMaxForce = 0.05;

// Used for detecting mousepress
boolean mpressed = false;

// State varable for the game
String gameState = "PLACE_LIGHTS";

// Paths for cars and walkers
Path path_cars, path_walkers;

// The arraylists
ArrayList<Car> cars;
ArrayList<Walker> walkers;
ArrayList<TrafficLight> lights;

String[] carPathPos;
String[] carPathCoords;
String[] walkerPathPos;
String[] walkerPathCoords;

PImage bg;

void setup() {
  size(1400, 997);

  bg = loadImage("images/bakgrundv3.jpg");

  // Initialize the paths
  path_cars = new Path();
  path_walkers = new Path();

  // Initialize the car-arraylist and add the cars
  cars = new ArrayList<Car>();
  for (int i = 0; i < numberOfCars; i++) {
    cars.add(new Car(new PVector(random(0, width), random(0, height)), carMaxSpeed, carMaxForce));
  }

  // Initialize the walker-arraylist and add the walkers
  walkers = new ArrayList<Walker>();
  for (int i = 0; i < numberOfWalkers; i++) {
    walkers.add(new Walker(new PVector(random(0, width), random(0, height)), walkerMaxSpeed, walkerMaxForce));
  }

  // Initialize the light-arraylist
  lights = new ArrayList<TrafficLight>();

  // read paths from file
  carPathPos = loadStrings("carPathPos.txt");
  String entirePlay = join(carPathPos, ',');
  String[] carPathCoords = split(entirePlay, ",,");

  float[] coord;
  for (int i = 0; i < carPathCoords.length; i++) {
    coord = float(split(carPathCoords[i], ' '));
    path_cars.addPoint(coord[0], coord[1]);
  }

  walkerPathPos = loadStrings("walkerPathPos.txt");
  String wentirePlay = join(walkerPathPos, ',');
  String[] walkerPathCoords = split(wentirePlay, ",,");

  float[] wcoord;
  for (int i = 0; i < walkerPathCoords.length; i++) {
    wcoord = float(split(walkerPathCoords[i], ' '));
    path_walkers.addPoint(wcoord[0], wcoord[1]);
  }
}

void draw() {
  background(bg);

  switch(gameState) {

  
    //*********PLACE_LIGHTS**********
    case("PLACE_LIGHTS"):
    if (mousePressed && !mpressed) {
      lights.add(new TrafficLight(mouseX, mouseY));
      mpressed = true;
    } else {
      mpressed = false;
    }
    if (keyPressed && key == '3') {
      gameState = "RUN";
    }

    // path_cars.render();
    path_walkers.render();

    for (int i = 0; i < lights.size(); i++) {
      TrafficLight light = lights.get(i);
      light.update();
    }

    break;

    //*********RUN**********
    case("RUN"):
    // Render the cars and the walkers

    // Make the walkers follow the path
    for (int i = 0; i < walkers.size(); i++) {
      Walker walker = walkers.get(i);
      walker.follow(path_walkers);
      walker.run();
    }

    // Make the cars follow the path and check for
    // collision and stop lights
    for (int i = 0; i < cars.size(); i++) {
      Car car = cars.get(i);
      car.follow(path_cars);
      car.run();
      car.checkCollision(walkers);
      car.checkStopLights(lights);
    }

    // Update the lights
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
