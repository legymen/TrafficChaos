// Heavily dependent on:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Walker{

    PVector position;
    PVector velocity;
    PVector acceleration;
    float r, maxForce, maxSpeed;

    PImage spriteSheet;
    PImage[][] movement;
    boolean inMotion;
    int currentDirection;
    float currentFrame;
    final int UP = 0, LEFT = 1, DOWN = 2, RIGHT = 3;

    Walker(PVector _position, float _maxSpeed, float _maxForce){
        position = _position.get();
        r = 4.0;
        maxSpeed = _maxSpeed;
        maxForce = _maxForce;
        acceleration = new PVector(0, 0);
        velocity = new PVector(maxSpeed, 0);

        setupSprites();
        inMotion = false;
        currentDirection = LEFT;
        currentFrame = 0;

    }

    void run(){
        update();
        render();
    }

    void update(){
        // Code for handling the movement
        velocity.add(acceleration);
        velocity.limit(maxSpeed);
        position.add(velocity);
        acceleration.mult(0);

        // Updating variables needed for the sprite sheet
        currentFrame = (currentFrame + 0.5) % 8;
        inMotion = true;
        float angle = degrees(velocity.heading());
        if (angle >= -45 && angle <= 45){
            currentDirection = RIGHT;
        } else if (angle > 45 && angle < 135){
            currentDirection = UP;
        } else if (angle >= 135 || angle <= -135){
            currentDirection = LEFT;
        } else if (angle < -45 && angle > -135){
            currentDirection = DOWN;
        }

    }

    void render(){

        if(inMotion){
            image(movement[currentDirection][1 + int(currentFrame)], position.x, position.y);
        } else {
            image(movement[currentDirection][0], position.x, position.y);
        }

    }

    void setupSprites(){
        movement = new PImage[4][9];
        spriteSheet = loadImage("images/theprofessor.png");
        for(int i = 0; i < 9; i++){
            movement[0][i] = spriteSheet.get(16 + 64 * i, 8, 32, 56);
            movement[1][i] = spriteSheet.get(16 + 64 * i, 72, 32, 56);
            movement[2][i] = spriteSheet.get(16 + 64 * i, 136, 32, 56);
            movement[3][i] = spriteSheet.get(16 + 64 * i, 200, 32, 56);
        }
    }

    void applyForce(PVector force) {
        acceleration.add(force);
    }

    void seek(PVector target){
        PVector desired = PVector.sub(target, position);

        if (desired.mag() == 0){
            return;
        }

        desired.normalize();
        desired.mult(maxSpeed);

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);

        applyForce(steer);
    }

    // This function implements Craig Reynolds' path following algorithm
    // http://www.red3d.com/cwr/steer/PathFollow.html
    void follow(Path p) {

        // Predict position 50 (arbitrary choice) frames ahead
        // This could be based on speed 
        PVector predict = velocity.get();
        predict.normalize();
        predict.mult(50);
        PVector predictpos = PVector.add(position, predict);

        // Now we must find the normal to the path from the predicted position
        // We look at the normal for each line segment and pick out the closest one

        PVector normal = null;
        PVector target = null;
        float worldRecord = 1000000;  // Start with a very high record distance that can easily be beaten

        // Loop through all points of the path
        for (int i = 0; i < p.points.size()-1; i++) {

        // Look at a line segment
        PVector a = p.points.get(i);
        PVector b = p.points.get(i+1);

        // Get the normal point to that line
        PVector normalPoint = getNormalPoint(predictpos, a, b);
        // This only works because we know our path goes from left to right
        // We could have a more sophisticated test to tell if the point is in the line segment or not
        if (normalPoint.x < a.x || normalPoint.x > b.x) {
            // This is something of a hacky solution, but if it's not within the line segment
            // consider the normal to just be the end of the line segment (point b)
            normalPoint = b.get();
        }

        // How far away are we from the path?
        float distance = PVector.dist(predictpos, normalPoint);
        // Did we beat the record and find the closest line segment?
        if (distance < worldRecord) {
            worldRecord = distance;
            // If so the target we want to steer towards is the normal
            normal = normalPoint;

            // Look at the direction of the line segment so we can seek a little bit ahead of the normal
            PVector dir = PVector.sub(b, a);
            dir.normalize();
            // This is an oversimplification
            // Should be based on distance to path & velocity
            dir.mult(10);
            target = normalPoint.get();
            target.add(dir);
        }
        }

        // Only if the distance is greater than the path's radius do we bother to steer
        if (worldRecord > p.radius) {
            seek(target);
        }


        // Draw the debugging stuff
        if (debug) {
        // Draw predicted future position
            stroke(0);
            fill(0);
            line(position.x, position.y, predictpos.x, predictpos.y);
            ellipse(predictpos.x, predictpos.y, 4, 4);

            // Draw normal position
            stroke(0);
            fill(0);
            ellipse(normal.x, normal.y, 4, 4);
            // Draw actual target (red if steering towards it)
            line(predictpos.x, predictpos.y, normal.x, normal.y);
            if (worldRecord > p.radius) fill(255, 0, 0);
            noStroke();
            ellipse(target.x, target.y, 8, 8);
        }
    }

    PVector getNormalPoint(PVector p, PVector a, PVector b){
        PVector ap = PVector.sub(p, a);
        PVector ab = PVector.sub(b, a);
        ab.normalize();
        ab.mult(ap.dot(ab));
        PVector normalPoint = PVector.add(a, ab);
        return normalPoint;
    }

    void borders(Path p){
        if (position.x > p.getEnd().x + r){
            position.x = p.getStart().x - r;
            position.y = p.getStart().y + (position.y - p.getEnd().y);
        }
    }

}
