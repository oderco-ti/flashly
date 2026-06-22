import 'package:audioplayers/audioplayers.dart';

Future<void> playAudio(String path) async {
  await AudioPlayer().play(AssetSource(path));
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
