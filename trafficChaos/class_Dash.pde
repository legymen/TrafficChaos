class Dash{
    color dashColor = color(255, 0, 0);
    color textColor = color(255);

    int startTime, time;

    Dash(){


    }

    void run(){
        update();
        render();
    }

    void update(){
        time = millis() - startTime;
    }

    void render(){
        pushMatrix();
        translate(width - 120, 0);

        fill(dashColor);
        rectMode(CORNER);
        rect(0, 0, 100, 100, 0, 0, 24, 24);

        fill(textColor);
        textAlign(CENTER);
        textSize(50);
        text(time/1000, 50, 50);

        popMatrix();
    }

}