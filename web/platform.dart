part of hubris;

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
    bufferContext.arc(cos(angle) * radius + world.centerX, sin(angle) * radius + world.centerY, radiusCircle, 0, 2 * PI);
    bufferContext.fill();
  }

}