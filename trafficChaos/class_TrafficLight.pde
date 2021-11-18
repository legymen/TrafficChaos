class TrafficLight {

  String state;
  int stateTimer;
  float xpos, ypos;

  TrafficLight(float _xpos, float _ypos) {
    xpos = _xpos;
    ypos = _ypos;
    state = "RED";
    stateTimer = millis();
  }

  void render(boolean lightsR, boolean lightsY, boolean lightsG, boolean walkOn) {
    // Renders the trafficlight with walksignal and button at xpos, ypos

    pushMatrix();
    translate(xpos, ypos);
    renderTrafficLight(lightsR, lightsY, lightsG);
    renderWalkSignal(walkOn);
    renderButton(true);
    popMatrix();
  }

  void update() {
    // Update runs every frame and calls render()

    switch(state) {

    case "RED":
      render(true, false, false, true);
      if (millis() - stateTimer > 2000) {
        state = "RED_YELLOW";
        stateTimer = millis();
      }
      break;

    case "RED_YELLOW":
      render(true, true, false, false);
      if (millis() - stateTimer > 2000) {
        state = "GREEN";
        stateTimer = millis();
      }
      break;

    case "GREEN":
      render(false, false, true, false);
      if (millis() - stateTimer > 2000) {
        state = "YELLOW";
        stateTimer = millis();
      }
      break;

    case "YELLOW":
      render(false, true, false, false);
      if (millis() - stateTimer > 2000) {
        state = "RED";
        stateTimer = millis();
      }
      break;
    }

    //Check the button every frame
    if (buttonPressed()) {
      state = "RED";
    }
  }

  void renderTrafficLight(boolean redOn, boolean yellowOn, boolean greenOn) {
    // This function renders a traffic light. Origin is in upper left corner

    color black = color(0);
    color redLight = color(255, 0, 0 );
    color yellowLight = color(255, 255, 0);
    color greenLight = color(0, 255, 0);
    color offLight = color(200);

    // Render the "box"
    fill(black);
    rect(0, 0, 100, 300);

    // Render red light if on
    if (redOn) {
      fill(redLight);
    } else {
      fill(offLight);
    }
    ellipse(50, 50, 75, 75);

    // Render yellow light if on
    if (yellowOn) {
      fill(yellowLight);
    } else {
      fill(offLight);
    }
    ellipse(50, 150, 75, 75);

    // Render green light if on
    if (greenOn) {
      fill(greenLight);
    } else {
      fill(offLight);
    }
    ellipse(50, 250, 75, 75);
  }

  void renderWalkSignal(boolean walk) {
    // This function renders a walk signal

    color black = color(0);
    color redLight = color(255, 0, 0 );
    color greenLight = color(0, 255, 0);
    color offLight = color(200);

    // Render the "box"
    fill(black);
    rect(300, 0, 100, 200);

    // Render red light if on
    if (walk) {
      fill(offLight);
    } else {
      fill(redLight);
    }
    ellipse(350, 50, 75, 75);

    // Render green light if on
    if (walk) {
      fill(greenLight);
    } else {
      fill(offLight);
    }
    ellipse(350, 150, 75, 75);
  }

  void renderButton(boolean buttonOn) {
    // This function renders a button
    color black = color(0);
    color buttonOffColor = color(54, 74, 183);
    color buttonOnColor = color(182, 179, 203);

    fill(black);
    rect(300, 400, 100, 100);

    if (buttonOn) {
      fill(buttonOnColor);
    } else {
      fill(buttonOffColor);
    }
    ellipse(350, 450, 36, 36);
  }

  boolean buttonPressed() {
    // Returns true if the button is pressed, false otherwise
    if (mousePressed && sqrt(sq(mouseX-(xpos+350))+sq(mouseY-(ypos+450))) < 18) {
      return true;
    } else {
      return false;
    }
  }
}
