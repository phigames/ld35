part of hubris;

class Stone {

  num angle;
  num radius;
  num size;
  num imageAngle;
  num velocity;
  ImageElement image;

  Stone(this.angle, this.radius, this.size) {
    radius -= size;
    imageAngle = 0;
    velocity = 0;
    image = Resources.images['stone'];
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
      imageAngle -= velocity * radius / size;
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
    /*bufferContext.fillStyle = '#888888';
    bufferContext.strokeStyle = '#000';
    bufferContext.beginPath();
    bufferContext.arc(cos(angle + world.offsetAngle) * radius + world.centerX, sin(angle + world.offsetAngle) * radius + world.centerY, size, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
    bufferContext.stroke();*/
    bufferContext.save();
    bufferContext.translate(cos(angle + world.offsetAngle) * radius + world.centerX, sin(angle + world.offsetAngle) * radius + world.centerY);
    bufferContext.rotate(imageAngle + world.offsetAngle);
    bufferContext.translate(-size, -size);
    bufferContext.drawImageScaled(image, 0, 0, 2 * size, 2 * size);
    bufferContext.restore();
  }

}