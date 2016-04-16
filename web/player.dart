part of hubris;

class Player {

  num angle;
  num radius;
  num width = 20, height = 20;
  num velocityY = 0;

  Player(this.angle, this.radius) {

  }

  void update() {
    if (input.rightKey) {

    } else if (input.leftKey) {

    }
    if (input.upKey) {
      velocityY = -5;
    }
  }

  void draw() {
    bufferContext.fillStyle = '#FFF';
    bufferContext.fillRect(cos(angle) * radius + world.centerX, sin(angle) * radius + world.centerY - height + velocityY, width, height);
  }
}