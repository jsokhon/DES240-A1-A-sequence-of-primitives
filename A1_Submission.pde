int arcSize = 300; // initial arc size
int growStep = 200; // distance between the arcs
int numOfArcs = 0; // count num of arcs
int totalNumOfArcs = 0;
int disconnectedArcCounter = 0;

boolean stopDrawing = false;
boolean arcFinished = false;
boolean disconnectedArc = false; // when disconnected arc needs to appear
boolean allArcsDrawn = false;

int circleSize = 10;
boolean circleGrow = true;
int step = 5; // size that the circle grows by

int count;

int angle1 = 185;
int angle2 = 235;
int delaySpeed = 275;

boolean countBlinker = true;

void setup() {
  size(1000, 1000);
  frameRate(20);
  background(0);
}

void draw() {

  if (circleSize > 100) { // show that the circle is growing with every wifi connection it makes

    circleGrow = false;
  }

  if (circleGrow == true) {
    circleSize += step;
  }


  pushMatrix();
  fill(255);
  noStroke();

  circle(width/2, height/2, circleSize);
  popMatrix();


  count = frameCount % 10; // plays with speed


  strokeWeight(20);
  noFill();
  pushMatrix(); // only moves things that are inside this section
  translate(width/2, height/2); // make the new origin the centre of the page

  if (!arcFinished && !stopDrawing) {

    if (numOfArcs < count && numOfArcs < 3) {
      drawArc(angle1, angle2, arcSize+numOfArcs*growStep, 255);
      totalNumOfArcs++;
      numOfArcs++; // counter
      delay(delaySpeed);
    }
  }

  if (numOfArcs == 3) {
    numOfArcs = 0;
    if (totalNumOfArcs <=18) {
      delaySpeed -= 40;
      angle1 += 60;
      angle2 += 60;
    }
  }

  if (numOfArcs == 0) {
    arcFinished = false;
  }

  if (totalNumOfArcs == 19) { // when 5 wifi symbols are drawn it stops
    allArcsDrawn = true;
    disconnectedArc = true;
    totalNumOfArcs = 1000;
  }

  if (disconnectedArc && allArcsDrawn) {

    stopDrawing = true;
    background(0);
    delay(500);

    arcSegment(255, 255, 255, 485, 535);
    disconnectedArc = false;
    noStroke();
    fill(255);
    circle(0, 0, circleSize-10);

    pushMatrix();
    stroke(0);
    strokeWeight(20);
    line(-24, -24, 24, 24);

    rotate(radians(90));
    line(-24, -24, 24, 24);
    popMatrix();
  } else if (!disconnectedArc && allArcsDrawn) {
    delay(400);
    arcSegment(0, 0, 0, 485, 535);

    noStroke();
    fill(255);
    circle(0, 0, circleSize-20);

    pushMatrix();
    stroke(0);
    strokeWeight(20);
    line(-28, -28, 28, 28);

    rotate(radians(90));
    line(-28, -28, 28, 28);
    popMatrix();


    disconnectedArcCounter++;
    disconnectedArc = true;
  }

  if (disconnectedArcCounter > 5) {
    background(0);
  }
  popMatrix(); // brings it back to the original one


  //saveFrame("######.png");
}


void drawArc(int angle1, int angle2, int finalArcSize, int colour) {
  stroke(colour);
  arc(0, 0, finalArcSize, finalArcSize, radians(angle1), radians(angle2));
}

void arcSegment(int inner, int mid, int outter, int ang1, int ang2)
{
  stroke(inner);
  arc(0, 0, arcSize+0*growStep, arcSize+0*growStep, radians(ang1), radians(ang2));
  stroke(mid);
  arc(0, 0, arcSize+growStep, arcSize+growStep, radians(ang1), radians(ang2));
  stroke(outter);
  arc(0, 0, arcSize+2*growStep, arcSize+2*growStep, radians(ang1), radians(ang2));
}
