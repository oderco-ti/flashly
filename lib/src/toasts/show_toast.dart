import 'package:flashly/src/core/flashly.dart';
import 'package:flashly/src/feedback/haptic_feedback.dart';
import 'package:flashly/src/feedback/sound_feedback.dart';
import 'package:flashly/src/toasts/animated_toast.dart';
import 'package:flashly/src/toasts/toast_state.dart';
import 'package:flutter/material.dart';

export 'animated_toast.dart';
export 'toast_state.dart';

void showToast(
  String message, {
  String? richMessage,
  FontStyle? richMessageFontStyle,
  IconData? icon,
  Color? iconColor,
  ToastState? state = ToastState.success,
  double? fontSize,
  Duration? duration,
  bool enableHaptics = false,
  bool enableSound = false,
}) {
  final overlay = Flashly.navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  if (enableHaptics) haptics();
  if (enableSound) playSound(state == ToastState.error);

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => AnimatedToast(
      message: message,
      richMessage: richMessage,
      richMessageFontStyle: richMessageFontStyle,
      icon: icon,
      iconColor: iconColor,
      state: state,
      fontSize: fontSize,
      duration: duration,
      onDismissed: () => overlayEntry.remove(),
    ),
  );

  overlay.insert(overlayEntry);
}
