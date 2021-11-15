class TrafficLight {

  String state;
  int stateTimer;
  float xpos, ypos;

  TrafficLights(_xpos, _ypos) {
    xpos = _xpos;
    ypos = _ypos;
    state = "RED";
    stateTimer = millis();
  }

  void render(boolean lightsR, boolean lightsY, boolean lightsG, boolean walkOn, boolean buttonOn) {
    renderTrafficLights(lightsR, lightsY, lightsG);
    renderWalkSignal(walkOn);
    renderButton(buttonOn);
  }

  void update() {
    // Update runs every frame and calls render()

    switch(state) {

    case "RED":
      renderTrafficLight(true, false, false);
      renderWalkSignal(true);
      if (millis() - start > 2000) {
        state = "RED_YELLOW";
        stateTimer = millis();
      }
      break;

    case "RED_YELLOW":

      break;

    case "GREEN":

      break;

    case "YELLOW":

      break;
    }

    //Check the button every frame
    if (buttonPressed()) {
      renderButton(true);
      state = "RED";
    } else {
      renderButton(false);
    }
  }

  void renderTrafficLight(boolean redOn, boolean yellowOn, boolean greenOn) {
    // This function renders a traffic light.

    color black = color(0);
    color redLight = color(255, 0, 0 );
    color yellowLight = color(255, 255, 0);
    color greenLight = color(0, 255, 0);
    color offLight = color(200);

    // Render the "box"
    fill(black);
    rect(100, 100, 100, 300);

    // Render red light if on
    if (redOn) {
      fill(redLight);
    } else {
      fill(offLight);
    }
    ellipse(150, 150, 75, 75);

    // Render yellow light if on
    if (yellowOn) {
      fill(yellowLight);
    } else {
      fill(offLight);
    }
    ellipse(150, 250, 75, 75);

    // Render green light if on
    if (greenOn) {
      fill(greenLight);
    } else {
      fill(offLight);
    }
    ellipse(150, 350, 75, 75);
  }

  void renderWalkSignal(boolean walk) {
    // This function renders a walk signal

    color black = color(0);
    color redLight = color(255, 0, 0 );
    color greenLight = color(0, 255, 0);
    color offLight = color(200);

    // Render the "box"
    fill(black);
    rect(400, 100, 100, 200);

    // Render red light if on
    if (walk) {
      fill(offLight);
    } else {
      fill(redLight);
    }
    ellipse(450, 150, 75, 75);

    // Render green light if on
    if (walk) {
      fill(greenLight);
    } else {
      fill(offLight);
    }
    ellipse(450, 250, 75, 75);
  }

  void renderButton(boolean buttonOn) {
    // This function renders a button
    color black = color(0);
    color buttonOffColor = color(54, 74, 183);
    color buttonOnColor = color(182, 179, 203);

    fill(black);
    rect(400, 500, 100, 100);

    if (buttonOn) {
      fill(buttonOnColor);
    } else {
      fill(buttonOffColor);
    }
    ellipse(450, 550, 36, 36);
  }

  boolean buttonPressed() {
    // Returns true if the button is pressed, false otherwise
    if (mousePressed && sqrt(sq(mouseX-450)+sq(mouseY-550)) < 18) {
      return true;
    } else {
      return false;
    }
  }
}
