library hubris;

import 'dart:html';
import 'dart:math';

part 'world.dart';
part 'player.dart';

int screenWidth, screenHeight;
CanvasElement canvas, buffer;
CanvasRenderingContext2D canvasContext, bufferContext;
Random random;
World world;
num lastUpdate;

void main() {
  canvas = querySelector('#canvas');
  screenWidth = canvas.width;
  screenHeight = canvas.height;
  buffer = new CanvasElement(width: screenWidth, height: screenHeight);
  canvasContext = canvas.context2D;
  bufferContext = buffer.context2D;
  random = new Random();
  world = new World();
  lastUpdate = -1;
  requestFrame();
}

void update() {

}

void draw() {
  bufferContext.clearRect(0, 0, screenWidth, screenHeight);
  world.draw();
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