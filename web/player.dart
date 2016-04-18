part of hubris;

class Player {

  num angle;
  num radius;
  num width = 95, height = 118;
  num velocityX = 0, velocityY = 0;
  bool onGround = false;
  num hitTime = 0;
  ImageElement image;
  int frame = 0;
  int frameTime = 0;

  Player(this.angle, this.radius) {
    image = Resources.images['walk'];
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
      if (angleDifference(angle, world.stones[i].angle).abs() < world.stones[i].size / radius && ((radius - world.stones[i].radius).abs() < world.stones[i].size || radius == world.stones[i].radius + world.stones[i].size)) {
        world.stones[i].push(velocityX * 1.2);
      }
    }
    onGround = false;
    if (hitTime == 0) {
      for (int i = 0; i < world.platforms.length; i++) {
        if (angle % (2 * PI) >= world.platforms[i].angleLeft % (2 * PI) && angle % (2 * PI) <= world.platforms[i].angleRight % (2 * PI) &&
            ((radius < world.platforms[i].radius && radius + velocityY >= world.platforms[i].radius) ||
                (radius == world.platforms[i].radius && velocityY == 0))) {
          radius = world.platforms[i].radius;
          velocityY = 0;
          onGround = true;
          world.platforms[i].onLand();
          break;
        }
      }
      for (int i = 0; i < world.stones.length; i++) {
        if (angleDifference(angle, world.stones[i].angle).abs() <= world.stones[i].size / radius &&
            ((radius < world.stones[i].radius - world.stones[i].size && radius + velocityY >= world.stones[i].radius - world.stones[i].size) ||
                (radius == world.stones[i].radius - world.stones[i].size && velocityY == 0))) {
          radius = world.stones[i].radius - world.stones[i].size;
          velocityY = 0;
          onGround = true;
          break;
        }
      }
    } else {
      hitTime--;
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
    if (velocityX != 0) {
      frameTime++;
      if (frameTime > 5) {
        frame++;
        if (frame > 5) {
          frame = 1;
        }
        frameTime = 0;
      }
    } else {
      frame = 0;
    }
  }

  void draw() {
    if (hitTime > 0 && hitTime % 20 < 10) {
      bufferContext.globalAlpha = 0.5;
    }
    //bufferContext.fillStyle = '#FFF';
    //bufferContext.fillRect(cos(angle + world.offsetAngle) * radius + world.centerX - width / 2, sin(angle + world.offsetAngle) * radius + world.centerY - height, width, height);
    bufferContext.drawImageToRect(image, new Rectangle<num>(cos(angle + world.offsetAngle) * radius + world.centerX - width / 2, sin(angle + world.offsetAngle) * radius + world.centerY - height, width, height),
        sourceRect: velocityX > 0 ? new Rectangle<num>(frame * width, height, width, height) : new Rectangle<num>(frame * width, 0, width, height));
    bufferContext.globalAlpha = 1;
  }
}