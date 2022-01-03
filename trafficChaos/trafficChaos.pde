// File names
String BACKGROUND_FILE = "images/bakgrundv3.jpg";
String CAR_PATH_FILE = "textfiles/carPathPos.txt";
String WALKER_PATH_FILE = "textfiles/walkerPathPos.txt";
String LIGHTS_POS_FILE = "textfiles/lightsPos.txt";

// Settings variables
int numberOfWalkers = 0;
int numberOfCars = 5;
float walkerMaxSpeed = 0.8;
float walkerMaxForce = 0.02;
float carMaxSpeed = 2.8;
float carMaxForce = 0.05;

// Used for detecting mousepress
boolean mpressed = false;

// State varable for the game
String gameState = "RUN";

// Paths for cars and walkers
Path path_cars, path_walkers;

// The arraylists
ArrayList<Car> cars;
ArrayList<Walker> walkers;
ArrayList<TrafficLight> lights;

Dash dash;

PImage bg;

void setup() {
  size(1400, 997);

  bg = loadImage(BACKGROUND_FILE);

  // Initialize
  path_cars = new Path();
  path_walkers = new Path();
  lights = new ArrayList<TrafficLight>();

  cars = new ArrayList<Car>();
  walkers = new ArrayList<Walker>();
  
  dash = new Dash();

 // read carPath from file
  String[] carPathPos = loadStrings(CAR_PATH_FILE);

  for (String s : carPathPos) {
    float[] ccoord = float(split(s, ' '));
    path_cars.addPoint(ccoord[0], ccoord[1]);
  }

  // read walkerPath from file
  String[] walkerPathPos = loadStrings(WALKER_PATH_FILE);

  for (String s : walkerPathPos) {
    float[] wcoord = float(split(s, ' '));
    path_walkers.addPoint(wcoord[0], wcoord[1]);
  }

  // read lights from file and add them
  String[] lightsPos = loadStrings(LIGHTS_POS_FILE);

  for(String s : lightsPos){
    float[] lcoord = float(split(s, ' '));
    lights.add(new TrafficLight(lcoord[0], lcoord[1], lcoord[2], lcoord[3]));
  }

  // add the cars
  for (int i = 0; i < numberOfCars; i++) {
    PVector spawn = path_cars.getRandom();
    cars.add(new Car(new PVector(spawn.x, spawn.y), carMaxSpeed, carMaxForce));
  }

  // add the walkers
  for (int i = 0; i < numberOfWalkers; i++) {
    PVector spawn = path_walkers.getRandom();
    walkers.add(new Walker(new PVector(spawn.x, spawn.y), walkerMaxSpeed, walkerMaxForce));
  }
 
}

void draw() {
  background(bg);

  switch(gameState) {

    //*********GAMESTATE RUN**********
    case("RUN"):

    // Make the walkers follow the path and render them
    for (int i = 0; i < walkers.size(); i++) {
      Walker walker = walkers.get(i);
      walker.follow(path_walkers);
      walker.run();
    }

    // Make the cars follow the path and check for
    // collision and stop lights. Render the cars.
    for (int i = 0; i < cars.size(); i++) {
      Car car = cars.get(i);
      car.follow(path_cars);
      car.checkCollision(walkers);
      car.checkStopLights(lights);
      car.run();
    }

    // Update the lights
    for (int i = 0; i < lights.size(); i++) {
      TrafficLight light = lights.get(i);
      light.update();
    }

    // Update the dash
    dash.run();
    
    break;


    //**********GAMESTATE GAME_OVER*************
    case("GAME_OVER"):
    background(0);
    textSize(100);
    fill(255);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    break;

  }



}
