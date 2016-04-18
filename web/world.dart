part of hubris;

class World {

  num radius;
  num centerX, centerY;
  num offsetAngle;
  List<Platform> platforms;
  List<Block> blocks;
  Player player;
  List<Stone> stones;
  Lightning lightning;

  World() {
    radius = 800;
    centerX = screenWidth / 2;
    centerY = screenHeight / 2 - 620;
    offsetAngle = 0;
    platforms = new List<Platform>();
    platforms.add(new Platform(0.5, 0.9, 600, 1, false, false));
    platforms.add(new Platform(0.8, 1.3, 520, 1, false, false));
    platforms.add(new Platform(0.0, 0.7, 490, 1, false, false));
    platforms.add(new Platform(5.8, 6.2, 450, 1, true, false));
    platforms.add(new Platform(5.2, 5.8, 450, 2, false, true));

    platforms.add(new Platform(2.3, 2.8, 600, 1, false, false));
    platforms.add(new Platform(2.7, 3.0, 530, 1, false, false));
    platforms.add(new Platform(2.4, 2.8, 430, 1, false, false));
    platforms.add(new Platform(2.8, 3.8, 390, 1, false, false));
    blocks = new List<Block>();
    player = new Player(PI / 2, radius);
    stones = new List<Stone>();
    stones.add(new Stone(1.2, radius, 30));
    stones.add(new Stone(0.8, radius, 70));
    stones.add(new Stone(0.5, radius, 30));
  }

  void update() {
    player.update();
    if (player.angle + offsetAngle > PI / 2 + 0.1) {
      offsetAngle = PI / 2 + 0.1 - player.angle;
    } else if (player.angle + offsetAngle < PI / 2 - 0.1) {
      offsetAngle = PI / 2 - 0.1 - player.angle;
    }
    if (player.radius + world.centerY > 400) {
      centerY = 400 - player.radius;
    } else if (player.radius + centerY < 200) {
      centerY = 200 - player.radius;
    }
    for (int i = 0; i < stones.length; i++) {
      stones[i].update();
    }
    if (lightning != null) {
      lightning.update();
      if (lightning.progress >= 1) {
        lightning = null;
      }
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
    for (int i = 0; i < blocks.length; i++) {
      blocks[i].draw();
    }
    player.draw();
    for (int i = 0; i < stones.length; i++) {
      stones[i].draw();
    }
    if (lightning != null) {
      lightning.draw();
    }
  }

}