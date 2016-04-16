part of hubris;

class World {

  num radius;
  num centerX, centerY;
  num offsetAngle;
  List<Platform> platforms;
  Player player;

  World() {
    radius = 800;
    centerX = screenWidth / 2;
    centerY = screenHeight * 0.75 - radius;
    offsetAngle = 0;
    platforms = new List<Platform>();
    platforms.add(new Platform(PI/2, PI/2 + 0.2, 700));
    platforms.add(new Platform(PI/2 - 0.2, PI/2 - 0.1, 600));
    player = new Player(PI/2, radius);
  }

  void update() {
    player.update();
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
    player.draw();
  }

}