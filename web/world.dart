part of hubris;

class World {

  num radius;
  num centerX, centerY;
  num offsetAngle;
  List<Platform> platforms;
  Player player;
  List<Stone> stones;
  Lightning lightning;
  int horseMode;
  num horseAngle, horseRadius;
  ImageElement horseImage;

  World() {
    radius = 800;
    centerX = screenWidth / 2;
    centerY = screenHeight / 2 - 620;
    offsetAngle = 0;
    platforms = new List<Platform>();
    platforms.add(new Platform(0.5, 0.9, 600, 1, false, false));
    platforms.add(new Platform(0.8, 1.3, 520, 1, false, false));
    platforms.add(new Platform(0.0, 0.7, 470, 1, false, false));
    platforms.add(new Platform(5.7, 6.2, 450, 1, true, false));
    platforms.add(new Platform(5.2, 5.7, 450, 2, false, true));
    platforms.add(new Platform(4.5, 5.2, 450, 1, false, false));

    platforms.add(new Platform(2.3, 2.8, 600, 1, false, false));
    platforms.add(new Platform(2.7, 3.0, 530, 1, false, false));
    platforms.add(new Platform(2.4, 2.8, 430, 1, false, false));
    platforms.add(new Platform(2.8, 3.8, 390, 1, false, false));
    player = new Player(PI / 2, radius);
    stones = new List<Stone>();
    stones.add(new Stone(2, radius, 50));
    stones.add(new Stone(1.2, radius, 30));
    stones.add(new Stone(0.8, radius, 70));
    stones.add(new Stone(0.5, radius, 30));
    horseMode = 0;
    horseAngle = 3.6;
    horseRadius = 390;
    horseImage = Resources.images['horse'];
  }

  void update() {
    if (horseMode != 2) {
      player.update();
    }
    if (player.angle + offsetAngle > PI / 2 + 0.1) {
      offsetAngle = PI / 2 + 0.1 - player.angle;
    } else if (player.angle + offsetAngle < PI / 2 - 0.1) {
      offsetAngle = PI / 2 - 0.1 - player.angle;
    }
    if (horseMode == 0 && angleDifference(player.angle, horseAngle).abs() < 0.1 && input.spaceKey) {
      horseMode = 1;
    } else if (horseMode == 1 && player.radius == 450 && angleDifference(player.angle, 6).abs() < 0.2 && input.spaceKey) {
      horseMode = 2;
      horseAngle = player.angle;
      horseRadius = 450;
    } else if (horseMode == 2) {
      horseAngle -= 0.01;
      player.angle = horseAngle;
      if (horseAngle < 4.8 - 2 * PI) {
        player.angle = 4.8;
        horseMode = 1;
      }
    }
    if (player.radius + world.centerY > 400) {
      centerY = 400 - player.radius;
    } else if (player.radius + centerY < 200) {
      centerY = 200 - player.radius;
    }
    for (int i = 0; i < stones.length; i++) {
      stones[i].update();
    }
    if (lightning != null) {
      lightning.update();
      if (lightning.progress >= 1) {
        lightning = null;
      }
    }
  }

  void draw() {
    bufferContext.fillStyle = '#A06239';
    bufferContext.fillRect(0, 0, screenWidth, screenHeight);
    bufferContext.fillStyle = '#4FB8FF';
    bufferContext.beginPath();
    bufferContext.arc(centerX, centerY, radius, 0, 2 * PI);
    bufferContext.closePath();
    bufferContext.fill();
    for (int i = 0; i < platforms.length; i++) {
      platforms[i].draw();
    }
    if (horseMode == 0) {
      bufferContext.save();
      bufferContext.translate(cos(horseAngle + offsetAngle) * horseRadius + centerX, sin(horseAngle + offsetAngle) * horseRadius + centerY);
      bufferContext.rotate(world.offsetAngle + horseAngle - PI / 2);
      bufferContext.translate(-78, -131);
      bufferContext.drawImage(horseImage, 0, 0);
      bufferContext.restore();
      if ((player.angle - horseAngle).abs() < 0.1) {
        bufferContext.fillStyle = '#FFF';
        bufferContext.font = 'bold 20px Forum';
        bufferContext.fillText('press [SPACE] to pick up', cos(horseAngle + offsetAngle) * horseRadius - 100 + centerX, sin(horseAngle + offsetAngle) * horseRadius + 50 + centerY);
      }
    } else if (horseMode == 2) {
      bufferContext.drawImage(horseImage, cos(horseAngle + offsetAngle) * horseRadius - 78 + centerX, sin(horseAngle + offsetAngle) * horseRadius - 131 + centerY);
    }
    if (horseMode != 2) {
      player.draw();
    }
    for (int i = 0; i < stones.length; i++) {
      stones[i].draw();
    }
    if (lightning != null) {
      lightning.draw();
    }
  }

}