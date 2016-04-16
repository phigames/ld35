part of hubris;

class Platform {

  num angleLeft, angleRight;
  num radius;
  List<PlatformCircle> circles;

  Platform(this.angleLeft, this.angleRight, this.radius) {
    circles = new List<PlatformCircle>();
    num platformWidth = angleRight - angleLeft;
    num partWidth = 0.04;
    int parts = platformWidth ~/ partWidth;
    for (int i = 0; i < parts; i++) { // parts
      for (int j = 0; j < 2; j++) { // n circles
        circles.add(new PlatformCircle(angleLeft + partWidth * i + random.nextDouble() * partWidth, radius + random.nextDouble() * 30 + 10, random.nextDouble() * 10 + 20, 0xFD, 0xFD, 0xFD));
      }
    }
    circles.shuffle();
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
  String color;

  PlatformCircle(this.angle, this.radius, this.radiusCircle, int red, int green, int blue) {
    num brighten = random.nextDouble() * 0.1 + 0.95;
    int r = (red * brighten).round();
    if (r > 0xFF) r = 0xFF;
    int g = (green * brighten).round();
    if (g > 0xFF) g = 0xFF;
    int b = (blue * brighten).round();
    if (b > 0xFF) b = 0xFF;
    color = '#';
    if (r < 0x10) color += '0';
    color += r.toRadixString(16);
    if (g < 0x10) color += '0';
    color += g.toRadixString(16);
    if (b < 0x10) color += '0';
    color += b.toRadixString(16);
    print('r:$r g:$g b:$b');
    print(color);
  }

  void draw() {
    bufferContext.beginPath();
    bufferContext.fillStyle = color;
    bufferContext.arc(cos(angle) * radius + world.centerX, sin(angle) * radius + world.centerY, radiusCircle, 0, 2 * PI);
    bufferContext.fill();
  }

}