part of hubris;

class Player {

  num angle;
  num radius;
  num width = 20, height = 20;
  num velocityX = 0, velocityY = 0;
  bool onGround = false;
  Platform groundPlatform;

  Player(this.angle, this.radius) {

  }

  void update() {
    velocityX = 0;
    if (input.rightKey) {
      velocityX = -0.01;
    } else if (input.leftKey) {
      velocityX = 0.01;
    }
    if (!onGround) {
      velocityY += 0.5;
    }
    angle += velocityX;
    for (int i = 0; i < world.stones.length; i++) {
      if ((angle - world.stones[i].angle).abs() % (2 * PI) <= world.stones[i].size / radius && (radius - world.stones[i].radius).abs() <= world.stones[i].size) {
        world.stones[i].push(velocityX * 1.2);
      }
    }
    onGround = false;
    for (int i = 0; i < world.platforms.length; i++) {
      if (angle >= world.platforms[i].angleLeft && angle <= world.platforms[i].angleRight &&
          ((radius < world.platforms[i].radius && radius + velocityY >= world.platforms[i].radius) || (radius == world.platforms[i].radius && velocityY == 0))) {
        radius = world.platforms[i].radius;
        velocityY = 0;
        onGround = true;
        break;
      }
    }
    for (int i = 0; i < world.stones.length; i++) {
      if ((angle - world.stones[i].angle).abs() % (2 * PI) <= world.stones[i].size / radius &&
          ((radius < world.stones[i].radius - world.stones[i].size && radius + velocityY >= world.stones[i].radius - world.stones[i].size) || (radius == world.stones[i].radius - world.stones[i].size && velocityY == 0))) {
        radius = world.stones[i].radius - world.stones[i].size;
        velocityY = 0;
        onGround = true;
        break;
      }
    }
    if (radius + velocityY >= world.radius) {
      radius = world.radius;
      velocityY = 0;
      onGround = true;
    }
    if (onGround && input.upKey) {
      velocityY = -10;
    }
    radius += velocityY;
  }

  void draw() {
    bufferContext.fillStyle = '#FFF';
    bufferContext.fillRect(cos(angle + world.offsetAngle) * radius + world.centerX - width / 2, sin(angle + world.offsetAngle) * radius + world.centerY - height, width, height);
  }
}