import 'package:flutter/material.dart';

/// Global keys and context accessors for Flashly overlays.
class Flashly {
  Flashly._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static BuildContext get context => navigatorKey.currentState!.context;
}
