import 'package:flutter/services.dart';

enum HapticImpact { medium, vibrate, light, heavy }

void haptics({
  HapticImpact impact = HapticImpact.medium,
  bool enabled = true,
}) {
  if (enabled) {
    if (impact == HapticImpact.heavy) {
      HapticFeedback.heavyImpact();
    }
    if (impact == HapticImpact.medium) {
      HapticFeedback.mediumImpact();
    }
    if (impact == HapticImpact.light) {
      HapticFeedback.lightImpact();
    }
    if (impact == HapticImpact.vibrate) {
      HapticFeedback.vibrate();
    }
  }
}
