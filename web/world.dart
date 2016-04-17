part of hubris;

class World {

  num radius;
  num centerX, centerY;
  num offsetAngle;
  List<Platform> platforms;
  Player player;
  List<Stone> stones;

  World() {
    radius = 800;
    centerX = screenWidth / 2;
    centerY = screenHeight / 2 - 620;
    offsetAngle = 0;
    platforms = new List<Platform>();
    platforms.add(new Platform(PI/2, PI/2 + 0.2, 700, 1));
    platforms.add(new Platform(PI/2 - 0.2, PI/2 - 0.1, 600, 1));
    player = new Player(PI/2, radius);
    stones = new List<Stone>();
    stones.add(new Stone(0, radius, 50));
  }

  void update() {
    player.update();
    if (player.angle + offsetAngle > PI / 2 + 0.2) {
      offsetAngle = PI / 2 + 0.2 - player.angle;
    } else if (player.angle + offsetAngle < PI / 2 - 0.2) {
      offsetAngle = PI / 2 - 0.2 - player.angle;
    }
    for (int i = 0; i < stones.length; i++) {
      stones[i].update();
    }
  }

  void draw() {
    bufferContext.fillStyle = '#A06239';
    bufferContext.fillRect(0, 0, screenWidth, screenHeight);
    bufferContext.fillStyle = '#4FB8FF';
    bufferContext.beginPath();
    bufferContext.arc(centerX, centerY, radius, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
    for (int i = 0; i < platforms.length; i++) {
      platforms[i].draw();
    }
    player.draw();
    for (int i = 0; i < stones.length; i++) {
      stones[i].draw();
    }
  }

}