part of hubris;

num centerX, centerY;
class World {

  num radius;
  List<Platform> platforms;

  World() {
    radius = 800;
    centerX = screenWidth / 2;
    centerY = screenHeight * 0.75 - radius;
    platforms = new List<Platform>();
    platforms.add(new Platform(PI/2, PI/2 + 0.5, 700));
  }

  void update() {

  }

  void draw() {
    bufferContext.fillStyle = '#B56900';
    bufferContext.fillRect(0, 0, screenWidth, screenHeight);
    bufferContext.fillStyle = '#4FB8FF';
    bufferContext.beginPath();
    bufferContext.arc(centerX, centerY, radius, 0, 2 * PI);
    bufferContext.fill();
    for (int i = 0; i < platforms.length; i++) {
      platforms[i].draw();
    }
  }

}

class Platform {

  num angleLeft, angleRight;
  num radius;
  List<PlatformCircle> circles;

  Platform(this.angleLeft, this.angleRight, this.radius) {
    circles = new List<PlatformCircle>();
    num platformWidth = angleRight - angleLeft;
    num partWidth = 0.07;
    int parts = platformWidth ~/ partWidth;
    for (int i = 0; i < parts; i++) { // parts
      for (int j = 0; j < 2; j++) { // n circles
        circles.add(new PlatformCircle(angleLeft + partWidth * i + random.nextDouble() * partWidth, radius + random.nextDouble() * 20 + 10, random.nextDouble() * 20 + 20));
      }
    }
  }

  void draw() {
    for (int i = 0; i < circles.length; i++) {
      circles[i].draw();
    }
  }
}

class PlatformCircle {

  num angle;
  num radius;
  num radiusCircle;

  PlatformCircle(this.angle, this.radius, this.radiusCircle) {

  }

  void draw() {
    bufferContext.beginPath();
    bufferContext.fillStyle = '#F00';
    bufferContext.arc(cos(angle)*radius + centerX, sin(angle)*radius + centerY, radiusCircle, 0, 2 * PI);
    bufferContext.fill();
  }

}