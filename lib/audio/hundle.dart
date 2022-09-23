import 'package:just_audio/just_audio.dart';

const bool debug = false;

void playAudio(AudioPlayer player, String path, List<bool> isPlayings, int index, Function setState) async {
  await player.setFilePath(path);
  player.play();
  for (var i=0; i<isPlayings.length; i++) {
    isPlayings[i] = false;
  }
  isPlayings[index] = true;
  setState(() {});
  if (debug) {
    print("===== playAudio =====");
    print("isPlayings : ");
    print(isPlayings);
    print("=====================");
  }
}

void stopAudio(AudioPlayer player, List<bool> isPlayings, int index, Function setState) {
  player.stop();
  isPlayings[index] = false;
  setState(() {});
  if (debug) {
    print("===== stopAudio =====");
    print("isPlayings : ");
    print(isPlayings);
    print("=====================");
  }
}