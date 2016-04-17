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
    print(velocity);
  }

  void update() {
    velocity *= 0.98;
    if (velocity.abs() < 0.001) {
      velocity = 0;
    }
    angle += velocity;
  }

  void draw() {
    bufferContext.beginPath();
    bufferContext.fillStyle = '#888888';
    bufferContext.arc(cos(angle + world.offsetAngle) * radius + world.centerX, sin(angle + world.offsetAngle) * radius + world.centerY, size, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
  }

}