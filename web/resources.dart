part of hubris;

class Resources {

  static Map<String, ImageElement> images;
  static Map<String, AudioElement> sounds;
  static int imagesLoaded = 0, soundsLoaded = 0;

  static void load() {
    images = new Map<String, ImageElement>();
    sounds = new Map<String, AudioElement>();
    images['clouds_out'] = new ImageElement(src: 'res/clouds_out.png')..onLoad.first.then((e) => imagesLoaded++);
    images['clouds_in'] = new ImageElement(src: 'res/clouds_in.png')..onLoad.first.then((e) => imagesLoaded++);
    images['tower'] = new ImageElement(src: 'res/tower.png')..onLoad.first.then((e) => imagesLoaded++);
    images['fog'] = new ImageElement(src: 'res/fog.png')..onLoad.first.then((e) => imagesLoaded++);
    images['god'] = new ImageElement(src: 'res/god.png')..onLoad.first.then((e) => imagesLoaded++);
    images['hero'] = new ImageElement(src: 'res/hero.png')..onLoad.first.then((e) => imagesLoaded++);
    images['god_small'] = new ImageElement(src: 'res/god_small.png')..onLoad.first.then((e) => imagesLoaded++);
    images['lightning'] = new ImageElement(src: 'res/lightning.png')..onLoad.first.then((e) => imagesLoaded++);
    sounds['loop1'] = new AudioElement('res/loop1.wav')..onLoadedData.first.then((e) => soundsLoaded++)..loop = true;
    sounds['loop2'] = new AudioElement('res/loop2.wav')..onLoadedData.first.then((e) => soundsLoaded++)..loop = true;
  }

  static bool allLoaded() {
    return imagesLoaded == images.values.length && soundsLoaded == sounds.values.length;
  }

}