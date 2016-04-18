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
    velocity *= 0.98;
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
    }
  }

  void draw() {
    bufferContext.beginPath();
    bufferContext.fillStyle = '#888888';
    bufferContext.arc(cos(angle + world.offsetAngle) * radius + world.centerX, sin(angle + world.offsetAngle) * radius + world.centerY, size, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
  }

}