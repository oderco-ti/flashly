import 'package:flashly/src/feedback/haptic_feedback.dart';
import 'package:flutter/services.dart';

extension HapticCallback on VoidCallback {
  void hapticCallback() {
    haptics();
    call();
  }
}
