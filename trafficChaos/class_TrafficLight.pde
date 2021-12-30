class TrafficLight {

  String state;
  int stateTimer;
  PVector streetPos;
  PVector renderPos;

  TrafficLight(float _streetXpos, float _streetYpos, float _renderXpos, float _renderYpos) {
    streetPos = new PVector(_streetXpos, _streetYpos);
    renderPos = new PVector(_renderXpos, _renderYpos);
    state = "RED";
    stateTimer = millis();
  }

  void render(boolean lightsR, boolean lightsY, boolean lightsG, boolean walkOn) {
    // Renders the trafficlight with walksignal and button at xpos, ypos

    pushMatrix();
    translate(renderPos.x - 5, renderPos.y - 100);
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

    rectMode(CORNER);

    // Render the "box" and "pole"
    fill(black);
    rect(0, 0, 14, 40);
    rect(5, 40, 4, 70);

    // Render red light if on
    if (redOn) {
      fill(redLight);
    } else {
      fill(offLight);
    }
    ellipse(7, 8, 10, 10);

    // Render yellow light if on
    if (yellowOn) {
      fill(yellowLight);
    } else {
      fill(offLight);
    }
    ellipse(7, 20, 10, 10);

    // Render green light if on
    if (greenOn) {
      fill(greenLight);
    } else {
      fill(offLight);
    }
    ellipse(7, 32, 10, 10);
  }

  void renderWalkSignal(boolean walk) {
    // This function renders a walk signal

    color black = color(0);
    color redLight = color(255, 0, 0 );
    color greenLight = color(0, 255, 0);
    color offLight = color(200);

    rectMode(CORNER);

    // Render the "box" AND "pole"
    fill(black);
    rect(30, 0, 14, 28);
    rect(35, 28, 4, 72);

    // Render red light if on
    if (walk) {
      fill(offLight);
    } else {
      fill(redLight);
    }
    ellipse(37, 8, 10, 10);

    // Render green light if on
    if (walk) {
      fill(greenLight);
    } else {
      fill(offLight);
    }
    ellipse(37, 20, 10, 10);
  }

  void renderButton(boolean buttonOn) {
    // This function renders a button
    color black = color(0);
    color buttonOffColor = color(54, 74, 183);
    color buttonOnColor = color(182, 179, 203);

    fill(black);
    rectMode(CORNER);
    rect(30, 40, 14, 14);

    if (buttonOn) {
      fill(buttonOnColor);
    } else {
      fill(buttonOffColor);
    }
    ellipse(37, 47, 12, 12);
  }

  boolean buttonPressed() {
    // Returns true if the button is pressed, false otherwise
    if (mousePressed && sqrt(sq(mouseX-(renderPos.x - 5 + 37))+sq(mouseY-(renderPos.y - 100 + 47))) < 6) {
      return true;
    } else {
      return false;
    }
  }
}
