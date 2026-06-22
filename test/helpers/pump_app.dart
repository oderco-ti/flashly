import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] inside a [MaterialApp] for widget tests.
extension FlashlyWidgetTester on WidgetTester {
  Future<void> pumpFlashlyApp(Widget child) {
    return pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: Scaffold(body: child),
      ),
    );
  }
}
