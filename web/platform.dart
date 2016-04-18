part of hubris;

class Platform {

  num angleLeft, angleRight;
  num radius;
  List<PlatformCircle> circles;
  int type;
  bool lightning;

  Platform(this.angleLeft, this.angleRight, this.radius, this.type, this.lightning) {
    circles = new List<PlatformCircle>();
    num platformWidth = angleRight - angleLeft;
    num partWidth = 0.04;
    int parts = platformWidth ~/ partWidth;
    int r, g, b;
    if (type == 1) {
      r = 0x00;
      g = 0xAA;
      b = 0x0E;
    } else if (type == 2) {
      r = 0xFD;
      g = 0xFD;
      b = 0xFD;
    }
    for (int i = 0; i < parts; i++) { // parts
      for (int j = 0; j < 2; j++) { // n circles
        circles.add(new PlatformCircle(angleLeft + partWidth * i + partWidth / 2, radius + random.nextDouble() * 30 + 10, random.nextDouble() * 10 + 15, r, g, b));
      }
    }
    circles.add(new PlatformCircle(angleRight - partWidth, radius + random.nextDouble() * 30 + 10, random.nextDouble() * 10 + 15, r, g, b));
    circles.shuffle();
  }

  void onLand() {
    if (lightning && world.lightning == null) {
      world.lightning = new Lightning(world.player.angle, world.player.radius);
    }
  }

  void draw() {
    if (type == 1) {
      num a1 = angleLeft + (angleRight - angleLeft) / 2 - 0.02 + world.offsetAngle;
      num a2 = a1 + 0.04;
      num r = radius + 25;
      bufferContext.fillStyle = '#5B4220';
      bufferContext.beginPath();
      bufferContext.moveTo(world.centerX + cos(a1) * r, world.centerY + sin(a1) * r);
      bufferContext.lineTo(world.centerX + cos(a2) * r, world.centerY + sin(a2) * r);
      bufferContext.lineTo(world.centerX + cos(a2) * world.radius, world.centerY + sin(a2) * world.radius);
      bufferContext.lineTo(world.centerX + cos(a1) * world.radius, world.centerY + sin(a1) * world.radius);
      bufferContext.closePath();
      bufferContext.fill();
    }
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
  }

  void draw() {
    bufferContext.beginPath();
    bufferContext.fillStyle = color;
    bufferContext.arc(cos(angle + world.offsetAngle) * radius + world.centerX, sin(angle + world.offsetAngle) * radius + world.centerY, radiusCircle, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
  }

}