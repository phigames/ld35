part of hubris;

class Player {

  num angle;
  num radius;
  num width = 95, height = 118;
  num velocityX = 0, velocityY = 0;
  bool onGround = false;
  num hitTime = 0;
  ImageElement image;
  ImageElement wings;
  int frame = 0;
  int frameTime = 0;
  int wingTime = 0;

  Player(this.angle, this.radius) {
    image = Resources.images['walk'];
    wings = Resources.images['wings'];
  }

  void update() {
    if (world.wingsMode != 2) {
      velocityX = 0;
      if (input.rightKey) {
        velocityX = -0.008;
      } else if (input.leftKey) {
        velocityX = 0.008;
      }
      if (!onGround) {
        velocityY += 0.8;
      }
      angle += velocityX;
      for (int i = 0; i < world.stones.length; i++) {
        if (angleDifference(angle, world.stones[i].angle).abs() < world.stones[i].size / radius &&
            ((radius - world.stones[i].radius).abs() < world.stones[i].size || radius == world.stones[i].radius + world.stones[i].size)) {
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
        velocityY = -12;
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
    } else {
      wingTime++;
    }
  }

  void draw() {
    if (hitTime > 0 && hitTime % 20 < 10) {
      bufferContext.globalAlpha = 0.5;
    }
    if (world.wingsMode == 2) {
      if (wingTime % 40 < 10) {
        bufferContext.drawImageScaledFromSource(wings, 0, 0, 118, 48, cos(angle + world.offsetAngle) * radius + world.centerX - 59, sin(angle + world.offsetAngle) * radius + world.centerY - height, 118, 48);
      } else if (wingTime % 40 < 20) {
        bufferContext.drawImageScaledFromSource(wings, 118, 0, 118, 48, cos(angle + world.offsetAngle) * radius + world.centerX - 59, sin(angle + world.offsetAngle) * radius + world.centerY - height, 118, 48);
      } else if (wingTime % 40 < 30) {
        bufferContext.drawImageScaledFromSource(wings, 236, 0, 118, 48, cos(angle + world.offsetAngle) * radius + world.centerX - 59, sin(angle + world.offsetAngle) * radius + world.centerY - height, 118, 48);
      } else {
        bufferContext.drawImageScaledFromSource(wings, 118, 0, 118, 48, cos(angle + world.offsetAngle) * radius + world.centerX - 59, sin(angle + world.offsetAngle) * radius + world.centerY - height, 118, 48);
      }
    }
    bufferContext.drawImageToRect(image, new Rectangle<num>(cos(angle + world.offsetAngle) * radius + world.centerX - width / 2, sin(angle + world.offsetAngle) * radius + world.centerY - height, width, height),
        sourceRect: velocityX > 0 ? new Rectangle<num>(frame * width, height, width, height) : new Rectangle<num>(frame * width, 0, width, height));
    bufferContext.globalAlpha = 1;
  }
}