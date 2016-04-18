library hubris;

import 'dart:html';
import 'dart:math';

part 'world.dart';
part 'player.dart';
part 'platform.dart';
part 'input.dart';
part 'gamestate.dart';
part 'resources.dart';
part 'stone.dart';

int screenWidth, screenHeight;
CanvasElement canvas, buffer;
CanvasRenderingContext2D canvasContext, bufferContext;
Random random;
GameState gameState;
Input input;
num lastUpdate;

void main() {
  canvas = querySelector('#canvas');
  screenWidth = canvas.width;
  screenHeight = canvas.height;
  buffer = new CanvasElement(width: screenWidth, height: screenHeight);
  canvasContext = canvas.context2D;
  bufferContext = buffer.context2D;
  random = new Random();
  gameState = new LoadingState();
  input = new Input();
  input.initInput();
  window.onKeyDown.listen(input.onKeyDown);
  window.onKeyUp.listen(input.onKeyUp);
  lastUpdate = -1;
  Resources.load();
  requestFrame();
}

num angleDifference(num angle1, num angle2) {
  num a2 = angle2 - angle1;
  if (a2 > 0) {
    a2 = a2 % (2 * PI);
  } else {
    a2 = -((-a2) % (2 * PI));
  }
  return a2;
}

void update() {
  gameState.update();
}

void draw() {
  bufferContext.clearRect(0, 0, screenWidth, screenHeight);
  gameState.draw();
  canvasContext.clearRect(0, 0, screenWidth, screenHeight);
  canvasContext.drawImage(buffer, 0, 0);
}

void frame(num time) {
  if (lastUpdate == -1) {
    lastUpdate = time;
  } else {
    while (time - lastUpdate >= 20) {
      update();
      lastUpdate += 20;
    }
    draw();
  }
  requestFrame();
}

void requestFrame() {
  window.animationFrame.then(frame);
}