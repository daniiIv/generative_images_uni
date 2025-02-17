int numPoints = 50; // Number of points in the web
Point[] points;

void setup() {
  size(600, 600);
  background(10);
  points = new Point[numPoints];

  // Initialize points randomly
  for (int i = 0; i < numPoints; i++) {
    points[i] = new Point(random(width), random(height));
  }
}

void draw() {
  background(10, 30); // Semi-transparent background for smooth fading

  // Update and draw connections
  for (int i = 0; i < numPoints; i++) {
    points[i].update();
    points[i].display();
    for (int j = i + 1; j < numPoints; j++) {
      float d = dist(points[i].x, points[i].y, points[j].x, points[j].y);
      if (d < 120) { // Connect only close points
        stroke(lerpColor(points[i].c, points[j].c, 0.5), map(d, 0, 120, 255, 50));
        strokeWeight(map(d, 0, 120, 2, 0.5));
        line(points[i].x, points[i].y, points[j].x, points[j].y);
      }
    }
  }
}

// Class for moving points
class Point {
  float x, y, speedX, speedY;
  color c;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
    this.speedX = random(-2, 2);
    this.speedY = random(-2, 2);
    this.c = color(random(255), random(255), random(255)); // Random color
  }

  void update() {
    x += speedX;
    y += speedY;

    // Bounce off edges
    if (x < 0 || x > width) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1;
  }

  void display() {
    fill(c, 200);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}
