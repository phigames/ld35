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
    bufferContext.fillRect(cos(angle) * radius + world.centerX - width / 2, sin(angle) * radius + world.centerY - height, width, height);
  }
}