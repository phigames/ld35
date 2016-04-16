part of hubris;

class World {

  num radius;
  num centerX, centerY;
  List<Platform> platforms;

  World() {
    radius = 800;
    centerX = screenWidth / 2;
    centerY = screenHeight * 0.75 - radius;
    platforms = new List<Platform>();
    platforms.add(new Platform(0, 0.5));
  }

  void update() {

  }

  void draw() {
    bufferContext.fillStyle = '#B56900';
    bufferContext.fillRect(0, 0, screenWidth, screenHeight);
    bufferContext.fillStyle = '#4FB8FF';
    bufferContext.arc(centerX, centerY, radius, 0, 2 * PI);
    bufferContext.fill();
    for (int i = 0; i < platforms.length; i++) {
      platforms[i].draw();
    }
    print('draw');
  }

}

class Platform {

  num angleLeft, angleRight;

  Platform(this.angleLeft, this.angleRight) {

  }

  void draw() {

  }

}