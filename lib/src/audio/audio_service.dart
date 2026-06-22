import 'package:audioplayers/audioplayers.dart';

Future<void> playAudio(String path) async {
  final player = AudioPlayer();

  await player.setAudioContext(
    AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.ambient,
      ),
    ),
  );

  await player.setReleaseMode(ReleaseMode.stop);

  await player.play(AssetSource(path));

  player.onPlayerComplete.listen((event) {
    player.dispose();
  });
}

Future<void> playAlert({
  String? errorPath,
  required String path,
  bool isError = false,
}) async {
  if (isError && errorPath != null) {
    await playAudio(errorPath);
    return;
  }
  await playAudio(path);
}
