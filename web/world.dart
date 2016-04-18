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
  int wingsMode;
  num wingsAngle, wingsRadius;
  ImageElement wingsImage;
  ImageElement godImage;

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
    platforms.add(new Platform(4.8, 5.2, 450, 1, false, false));

    platforms.add(new Platform(4.5, 4.9, 350, 2, false, false));
    platforms.add(new Platform(4.7, 5.2, 250, 2, false, false));
    platforms.add(new Platform(5.0, 6.2, 150, 2, false, false));

    platforms.add(new Platform(2.3, 2.8, 600, 1, false, false));
    platforms.add(new Platform(2.7, 3.0, 530, 1, false, false));
    platforms.add(new Platform(2.4, 2.8, 430, 1, false, false));
    platforms.add(new Platform(2.9, 3.8, 390, 1, false, false));
    platforms.add(new Platform(1.7, 2.3, 430, 1, false, false));
    platforms.add(new Platform(1.5, 3.5, 150, 2, false, false));

    player = new Player(PI / 2, radius);
    stones = new List<Stone>();
    stones.add(new Stone(3.0, radius, 40));
    stones.add(new Stone(0.8, radius, 70));
    stones.add(new Stone(0.5, radius, 30));
    horseMode = 0;
    horseAngle = 3.6;
    horseRadius = 390;
    horseImage = Resources.images['horse'];
    wingsMode = 0;
    wingsAngle = 5.8;
    wingsRadius = 150;
    wingsImage = Resources.images['wings'];
    godImage = Resources.images['god'];
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
    if (horseMode == 0 && player.radius == 390 && angleDifference(player.angle, horseAngle).abs() < 0.1 && input.spaceKey) {
      horseMode = 1;
    } else if (horseMode == 1 && player.radius == 450 && angleDifference(player.angle, 6).abs() < 0.1 && input.spaceKey) {
      horseMode = 2;
      horseAngle = 6;
      horseRadius = 450;
    } else if (horseMode == 2) {
      horseAngle -= 0.01;
      player.angle = horseAngle;
      if (horseAngle < 5) {
        player.angle = 5;
        horseMode = 1;
      }
    }
    if (wingsMode == 0 && player.radius == wingsRadius && angleDifference(player.angle, wingsAngle).abs() < 0.1 && input.spaceKey) {
      wingsMode = 1;
    } else if (wingsMode == 1 && player.radius == 430 && angleDifference(player.angle, 2).abs() < 0.1 && input.spaceKey) {
      wingsMode = 2;
    } else if (wingsMode == 2) {
      player.radius -= 1;
      Resources.sounds['loop2'].volume = max(((player.radius - 150) / 280), 0);
      if (player.radius < 150) {
        player.radius = 150;
        gameState = new OutroState();
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
    bufferContext.save();
    bufferContext.translate(cos(3 + offsetAngle) * 150 + centerX, sin(3 + offsetAngle) * 150 + centerY);
    bufferContext.rotate(world.offsetAngle + 3 - PI / 2);
    bufferContext.translate(-84, -162);
    bufferContext.drawImageScaled(godImage, 0, 0, 168, 162);
    bufferContext.restore();
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
      if (player.radius == 390 && angleDifference(player.angle, horseAngle).abs() < 0.1) {
        bufferContext.fillStyle = '#FFF';
        bufferContext.font = 'bold 20px Forum';
        bufferContext.fillText('press [SPACE] to pick up', cos(horseAngle + offsetAngle) * horseRadius - 100 + centerX, sin(horseAngle + offsetAngle) * horseRadius + 50 + centerY);
      }
    } else if (horseMode == 1) {
      if (player.radius == 450 && angleDifference(player.angle, 6).abs() < 0.1) {
        bufferContext.fillStyle = '#FFF';
        bufferContext.font = 'bold 20px Forum';
        bufferContext.fillText('press [SPACE] to use horse', cos(6 + offsetAngle) * 450 - 100 + centerX, sin(6 + offsetAngle) * 450 + 50 + centerY);
      }
    } else if (horseMode == 2) {
      bufferContext.drawImage(horseImage, cos(horseAngle + offsetAngle) * horseRadius - 78 + centerX, sin(horseAngle + offsetAngle) * horseRadius - 131 + centerY);
    }
    if (wingsMode == 0) {
      bufferContext.save();
      bufferContext.translate(cos(wingsAngle + offsetAngle) * wingsRadius + centerX, sin(wingsAngle + offsetAngle) * wingsRadius + centerY);
      bufferContext.rotate(world.offsetAngle + wingsAngle - PI / 2);
      bufferContext.translate(-59, -48);
      bufferContext.drawImageScaledFromSource(wingsImage, 0, 0, 118, 48, 0, 0, 118, 48);
      bufferContext.restore();
      if (player.radius == wingsRadius && angleDifference(player.angle, wingsAngle).abs() < 0.1) {
        bufferContext.fillStyle = '#FFF';
        bufferContext.font = 'bold 20px Forum';
        bufferContext.fillText('press [SPACE] to pick up', cos(wingsAngle + offsetAngle) * wingsRadius - 100 + centerX, sin(wingsAngle + offsetAngle) * wingsRadius + 50 + centerY);
      }
    } else if (wingsMode == 1) {
      if (player.radius == 430 && angleDifference(player.angle, 2).abs() < 0.1) {
        bufferContext.fillStyle = '#FFF';
        bufferContext.font = 'bold 20px Forum';
        bufferContext.fillText('press [SPACE] to use wings', cos(2 + offsetAngle) * 430 - 100 + centerX, sin(2 + offsetAngle) * 430 + 50 + centerY);
      }
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