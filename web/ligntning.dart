part of hubris;

class Lightning {

  num targetAngle;
  num targetRadius;
  num progress;
  ImageElement image;

  Lightning(this.targetAngle, this.targetRadius) {
    targetRadius -= 120;
    progress = 0;
    image = Resources.images['lightning'];
    Resources.sounds['thunder'].currentTime = 0;
    Resources.sounds['thunder'].play();
  }

  void update() {
    progress += 0.07;
    if (progress >= 1) {
      world.player.hitTime = 60;
    }
  }

  void draw() {
    bufferContext.drawImage(image, cos(targetAngle + world.offsetAngle) * targetRadius + world.centerX - (progress - 1) * 150, sin(targetAngle + world.offsetAngle) * targetRadius + world.centerY + (progress - 1) * 400);
  }

}