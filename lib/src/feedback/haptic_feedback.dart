import 'package:flutter/services.dart';

enum HapticImpact { medium, vibrate, light, heavy }

void haptics({HapticImpact impact = HapticImpact.medium}) {
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
