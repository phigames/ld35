part of hubris;

class Stone {

  num angle;
  num radius;
  num size;
  num velocity;

  Stone(this.angle, this.radius, this.size) {
    radius -= size;
    velocity = 0;
  }

  void push(num acceleration) {
    velocity = acceleration;
  }

  void update() {
    velocity *= 0.96;
    if (velocity.abs() < 0.001) {
      velocity = 0;
    }
    if (velocity != 0) {
      angle += velocity;
      for (int i = 0; i < world.stones.length; i++) {
        if (world.stones[i] != this && velocity.abs() > world.stones[i].velocity.abs()) {
          num d = angleDifference(angle, world.stones[i].angle);
          if (d.abs() < (size + world.stones[i].size) / radius &&
              ((radius - world.stones[i].radius).abs() < size + world.stones[i].size || radius + size == world.stones[i].radius + world.stones[i].size)) {
            if (d < 0) {
              angle = world.stones[i].angle + world.stones[i].size / world.stones[i].radius + size / radius;
            } else {
              angle = world.stones[i].angle - world.stones[i].size / world.stones[i].radius - size / radius;
            }
            world.stones[i].push(velocity);
            velocity = 0;
          }
        }
      }
      for (int i = 0; i < world.blocks.length; i++) {
        if (velocity > 0 && angleDifference(angle, world.blocks[i].angleLeft) < size / radius) {
          velocity = 0;
        } else if (velocity < 0 && angleDifference(world.blocks[i].angleRight, angle) < size / radius) {
          velocity = 0;
        }
      }
    }
  }

  void draw() {
    bufferContext.fillStyle = '#888888';
    bufferContext.strokeStyle = '#000';
    bufferContext.beginPath();
    bufferContext.arc(cos(angle + world.offsetAngle) * radius + world.centerX, sin(angle + world.offsetAngle) * radius + world.centerY, size, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
    bufferContext.stroke();
  }

}

class Block {

  num angleLeft, angleRight;
  num radiusTop, radiusBottom;

  Block(this.angleLeft, this.angleRight, this.radiusTop, this.radiusBottom) {

  }

  void draw() {
    bufferContext.fillStyle = '#000';
    bufferContext.beginPath();
    bufferContext.moveTo(cos(angleLeft + world.offsetAngle) * radiusTop + world.centerX, sin(angleLeft + world.offsetAngle) * radiusTop + world.centerY);
    bufferContext.lineTo(cos(angleRight + world.offsetAngle) * radiusTop + world.centerX, sin(angleRight + world.offsetAngle) * radiusTop + world.centerY);
    bufferContext.lineTo(cos(angleRight + world.offsetAngle) * radiusBottom + world.centerX, sin(angleRight + world.offsetAngle) * radiusBottom + world.centerY);
    bufferContext.lineTo(cos(angleLeft + world.offsetAngle) * radiusBottom + world.centerX, sin(angleLeft + world.offsetAngle) * radiusBottom + world.centerY);
    bufferContext.closePath();
    bufferContext.fill();
  }

}