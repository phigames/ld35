part of hubris;

World world;

abstract class GameState {

  void update();

  void draw();

}

class LoadingState extends GameState {

  void update() { }

  void draw() {
    if (!Resources.allLoaded()) {
      bufferContext.fillStyle = '#000';
      bufferContext.font = '50px Forum';
      bufferContext.fillText('loading...', 300, 200);
    } else {
      gameState = new IntroState();
      //gameState = new WorldState();
    }
  }

}

class IntroState extends GameState {

  ImageElement cloudsOut = Resources.images['clouds_out'];
  ImageElement cloudsIn = Resources.images['clouds_in'];
  ImageElement tower = Resources.images['tower'];
  ImageElement fog = Resources.images['fog'];
  ImageElement god = Resources.images['god'];
  ImageElement hero = Resources.images['hero'];
  int phase = 0;
  int phaseTime = 0;
  num fogTime = 0;

  IntroState() {
    Resources.sounds['loop1'].play();
  }

  void update() {
    phaseTime++;
    fogTime++;
    if (input.spaceKey) {
      if (phase < 10) {
        phase++;
        phaseTime = 0;
        input.spaceKey = false;
      } else {
        gameState = new WorldState();
      }
    }
  }

  void draw() {
    if (phase == 0) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2, 100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.save();
      bufferContext.translate(screenWidth / 2, screenHeight / 2);
      //bufferContext.rotate(fogTime / 100);
      bufferContext.translate(-160, -160);
      bufferContext.drawImage(cloudsOut, 0, 0);
      bufferContext.restore();
      bufferContext.fillStyle = '#FFF';
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('Until the year 631 B.C., humans had lived on Earth peacefully.', 28, 50);
      if (phaseTime % 70 > 30) {
        bufferContext.fillStyle = '#FFF';
        bufferContext.font = 'bold 20px Forum';
        bufferContext.fillText('press [SPACE] to continue', 580, 435);
      }


    } else if (phase == 1) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2, 100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.save();
      bufferContext.translate(screenWidth / 2, screenHeight / 2);
      //bufferContext.rotate(fogTime / 100);
      bufferContext.translate(-160, -160);
      bufferContext.drawImage(cloudsOut, 0, 0);
      bufferContext.restore();
      bufferContext.fillStyle = '#000';
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('But then they wanted more.', 180, 430);


    } else if (phase == 2) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2 + min(phaseTime, 100) * 21.5, 100 + min(phaseTime, 100) * 20, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.fillStyle = '#000';
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('They wanted to see the world', 220, 50);
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('through the eyes of a God.', 185, 100);


    } else if (phase == 3) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2 + 2150, 2100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      if (phaseTime <= 50) {
        bufferContext.globalAlpha = phaseTime / 50;
      }
      bufferContext.drawImage(tower, 0, 0);
      bufferContext.drawImage(fog, sin(fogTime / 200) * 100 - 100, 0);
      bufferContext.globalAlpha = 1;
      bufferContext.fillStyle = '#FFF';
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('So they began building a tower that reached', 50, 80);
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('beyond the clouds.', 450, 115);


    } else if (phase == 4) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2 + 2150, 2100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.drawImage(tower, 0, 0);
      bufferContext.drawImage(fog, sin(fogTime / 100) * 100 - 100, 0);
      if (phaseTime <= 50) {
        bufferContext.drawImage(god, screenWidth - phaseTime * 6, screenHeight - 300);
      } else {
        bufferContext.drawImage(god, screenWidth - 300, screenHeight - 300);
      }
      bufferContext.fillStyle = '#000';
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('Their God was not pleased to see these events.', 110, 70);


    } else if (phase == 5) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2 + max(100 - phaseTime, 0) * 21.5, 100 + max(100 - phaseTime, 0) * 20, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      if (phaseTime <= 50) {
        bufferContext.drawImage(god, screenWidth - (50 - phaseTime) * 6, screenHeight - 300);
      }
      if (phaseTime > 100) {
        bufferContext.save();
        bufferContext.translate(screenWidth / 2, screenHeight / 2);
        //bufferContext.rotate(fogTime / 100);
        bufferContext.translate(-160, -160);
        bufferContext.drawImage(cloudsOut, 0, 0);
        bufferContext.restore();
      }
      bufferContext.fillStyle = '#FFF';
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('Humans are not allowed in a God\'s realm,', 60, 50);
      bufferContext.fillStyle = '#000';
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('So he decided to punish them in the most cruel way.', 80, 430);


    } else if (phase == 5) {
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#A06239';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2 + max(100 - phaseTime, 0) * 21.5, 100 + max(100 - phaseTime, 0) * 20, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      if (phaseTime <= 50) {
        bufferContext.drawImage(god, screenWidth - (50 - phaseTime) * 6, screenHeight - 300);
      } else {
        bufferContext.save();
        bufferContext.translate(screenWidth / 2, screenHeight / 2);
        //bufferContext.rotate(fogTime / 100);
        bufferContext.translate(-160, -160);
        bufferContext.drawImage(cloudsOut, 0, 0);
        bufferContext.restore();
      }
      bufferContext.fillStyle = '#000';
      bufferContext.fillText('Humans are not allowed in a God\'s realm,', 100, 100);
      bufferContext.fillText('So he decided to punish them in the most cruel way.', 100, 400);


    } else if (phase == 6) {
      if (phaseTime <= 50) {
        bufferContext.fillStyle = '#4FB8FF';
        bufferContext.fillRect(0, 0, screenWidth, screenHeight);
        bufferContext.fillStyle = '#A06239';
        bufferContext.beginPath();
        num t = phaseTime * phaseTime * 0.2;
        bufferContext.arc(screenWidth / 2, screenHeight / 2 + t * 20.2, 100 + t * 20, 0, 2 * PI);
        bufferContext.closePath();
        bufferContext.fill();
      } else if (phaseTime <= 100) {
        bufferContext.fillStyle = '#A06239';
        bufferContext.fillRect(0, 0, screenWidth, screenHeight);
        bufferContext.fillStyle = '#4FB8FF';
        bufferContext.beginPath();
        num t = (100 - phaseTime) * (100 - phaseTime) * 0.2;
        bufferContext.arc(screenWidth / 2, screenHeight / 2 - t * 20.2, 100 + t * 20, 0, 2 * PI);
        bufferContext.closePath();
        bufferContext.fill();
      } else {
        bufferContext.fillStyle = '#A06239';
        bufferContext.fillRect(0, 0, screenWidth, screenHeight);
        bufferContext.fillStyle = '#4FB8FF';
        bufferContext.beginPath();
        bufferContext.arc(screenWidth / 2, screenHeight / 2, 100, 0, 2 * PI);
        bufferContext.closePath();
        bufferContext.fill();
        bufferContext.save();
        bufferContext.translate(screenWidth / 2, screenHeight / 2);
        //bufferContext.rotate(fogTime / 100);
        bufferContext.translate(-75, -75);
        bufferContext.drawImage(cloudsIn, 0, 0);
        bufferContext.restore();
      }
      bufferContext.fillStyle = '#000';
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('He turned Earth inside out,', 180, 80);
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('so they would never see the stars again.', 160, 400);


    } else if (phase == 7) {
      bufferContext.fillStyle = '#A06239';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2, 100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.save();
      bufferContext.translate(screenWidth / 2, screenHeight / 2);
      //bufferContext.rotate(fogTime / 100);
      bufferContext.translate(-75, -75);
      bufferContext.drawImage(cloudsIn, 0, 0);
      bufferContext.restore();
      bufferContext.fillStyle = '#FFF';
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('But there was one brave human', 140, 80);
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('who dared to undo this punishment.', 180, 400);


    } else if (phase == 8) {
      bufferContext.fillStyle = '#A06239';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2, 100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.save();
      bufferContext.translate(screenWidth / 2, screenHeight / 2);
      //bufferContext.rotate(fogTime / 100);
      bufferContext.translate(-75, -75);
      bufferContext.drawImage(cloudsIn, 0, 0);
      bufferContext.restore();
      if (phaseTime <= 50) {
        bufferContext.drawImage(hero, phaseTime * 6 - 300, screenHeight - 300);
      } else {
        bufferContext.drawImage(hero, 0, screenHeight - 300);
      }
      bufferContext.fillStyle = '#FFF';
      bufferContext.font = 'bold 40px Forum';
      bufferContext.fillText('Her name was Eurydike.', 370, 400);


    } else if (phase == 9) {
      bufferContext.fillStyle = '#A06239';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2, 100, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      bufferContext.save();
      bufferContext.translate(screenWidth / 2, screenHeight / 2);
      //bufferContext.rotate(fogTime / 100);
      bufferContext.translate(-75, -75);
      bufferContext.drawImage(cloudsIn, 0, 0);
      bufferContext.restore();
      bufferContext.drawImage(hero, 0, screenHeight - 300);
      bufferContext.fillStyle = '#000';
      bufferContext.font = 'bold 30px Forum';
      bufferContext.fillText('She knew that a God loses his power', 100, 50);
      bufferContext.fillText('when he is touched by a mortal.', 300, 90);
      bufferContext.fillStyle = '#FFF';
      bufferContext.fillText('So she set out on a quest', 370, 375);
      bufferContext.fillText('to restore Earth\'s shape.', 470, 415);


    } else if (phase == 10) {
      bufferContext.fillStyle = '#A06239';
      bufferContext.fillRect(0, 0, screenWidth, screenHeight);
      bufferContext.fillStyle = '#4FB8FF';
      bufferContext.beginPath();
      bufferContext.arc(screenWidth / 2, screenHeight / 2 - min(phaseTime, 100) * 6.2, 100 + min(phaseTime, 100) * 7, 0, 2 * PI);
      bufferContext.closePath();
      bufferContext.fill();
      Resources.sounds['loop1'].volume = max(1 - phaseTime / 100, 0);
      if (phaseTime > 100) {
        gameState = new WorldState();
      }
    }
  }

}

class WorldState extends GameState {

  WorldState() {
    world = new World();
    Resources.sounds['loop1'].pause();
    Resources.sounds['loop2'].play();
  }

  void update() {
    world.update();
  }

  void draw() {
    world.draw();
  }

}