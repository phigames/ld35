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
    platforms.add(new Platform(PI / 2, PI / 2 + 0.2, 700, 1, false));
    platforms.add(new Platform(PI / 2 - 0.2, PI / 2 - 0.1, 600, 1, false));
    platforms.add(new Platform(PI / 2 - 0.1, PI / 2 + 0.2, 600, 2, true));
    blocks = new List<Block>();
    //blocks.add(new Block(PI / 2 + 0.3, PI / 2 + 0.4, 750, 800));
    player = new Player(PI/2, radius);
    stones = new List<Stone>();
    stones.add(new Stone(0, radius, 50));
    stones.add(new Stone(PI / 4, radius, 30));
  }

  void update() {
    player.update();
    if (player.angle + offsetAngle > PI / 2 + 0.2) {
      offsetAngle = PI / 2 + 0.2 - player.angle;
    } else if (player.angle + offsetAngle < PI / 2 - 0.2) {
      offsetAngle = PI / 2 - 0.2 - player.angle;
    }
    if (player.radius + world.centerY > 400) {
      centerY = 400 - player.radius;
    } else if (player.radius + centerY < 100) {
      centerY = 100 - player.radius;
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