import 'package:flashly/src/audio/audio_service.dart';

Future<void> playSound([bool error = false]) async {
  await playAlert(
    isError: error,
    path: 'success.mp3',
    errorPath: error ? 'error.mp3' : null,
  );
}
