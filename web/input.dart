part of hubris;

class Input {

  bool leftKey, rightKey, upKey;

  void initInput(){
    leftKey = false;
    rightKey = false;
  }

  void onKeyDown(KeyboardEvent event) {
    if (event.keyCode == KeyCode.LEFT || event.keyCode == KeyCode.A) {
      leftKey = true;
    } else if (event.keyCode == KeyCode.RIGHT || event.keyCode == KeyCode.D) {
      rightKey = true;
    } else if (event.keyCode == KeyCode.UP || event.keyCode == KeyCode.W) {
      upKey = true;
    }
  }

  void onKeyUp(KeyboardEvent event) {
    if (event.keyCode == KeyCode.LEFT || event.keyCode == KeyCode.A) {
      leftKey = false;
    } else if (event.keyCode == KeyCode.RIGHT || event.keyCode == KeyCode.D) {
      rightKey = false;
    } else if (event.keyCode == KeyCode.UP || event.keyCode == KeyCode.W) {
      upKey = false;
    }
  }

}