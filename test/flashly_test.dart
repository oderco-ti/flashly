import 'package:flashly/flashly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/pump_app.dart';

void main() {
  group('Flashly', () {
    test('navigatorKey and scaffoldMessengerKey are initialized', () {
      expect(Flashly.navigatorKey, isA<GlobalKey<NavigatorState>>());
      expect(
        Flashly.scaffoldMessengerKey,
        isA<GlobalKey<ScaffoldMessengerState>>(),
      );
    });
  });

  group('Txt', () {
    testWidgets('renders text with default style', (tester) async {
      await tester.pumpFlashlyApp(const Txt('Hello Flashly'));

      expect(find.text('Hello Flashly'), findsOneWidget);
    });

    testWidgets('applies custom fontSize and color', (tester) async {
      await tester.pumpFlashlyApp(
        const Txt('Styled', fontSize: 24, color: Colors.red),
      );

      final text = tester.widget<Text>(find.text('Styled'));
      expect(text.style?.fontSize, 24);
      expect(text.style?.color, Colors.red);
    });
  });

  group('RichTxt', () {
    testWidgets('renders both text spans', (tester) async {
      await tester.pumpFlashlyApp(
        const RichTxt(text1: 'Part 1 ', text2: 'Part 2'),
      );

      expect(find.textContaining('Part 1'), findsOneWidget);
      expect(find.textContaining('Part 2'), findsOneWidget);
    });
  });

  group('PressEffect', () {
    testWidgets('invokes onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpFlashlyApp(
        PressEffect(
          onPressed: () => pressed = true,
          child: const Text('Tap me'),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(pressed, isTrue);
    });

    testWidgets('cancels the release timer when disposed', (tester) async {
      var visible = true;

      await tester.pumpFlashlyApp(
        StatefulBuilder(
          builder: (context, setState) => visible
              ? PressEffect(
                  onPressed: () => setState(() => visible = false),
                  child: const Text('Remove me'),
                )
              : const SizedBox.shrink(),
        ),
      );

      await tester.tap(find.text('Remove me'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Remove me'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('AlertActionButton', () {
    testWidgets('renders button label', (tester) async {
      await tester.pumpFlashlyApp(
        AlertActionButton(text: 'Confirmar', onPressed: () {}),
      );

      expect(find.text('Confirmar'), findsOneWidget);
    });
  });

  group('loader', () {
    testWidgets('renders adaptive progress indicator by default', (
      tester,
    ) async {
      await tester.pumpFlashlyApp(loader());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('AlertState', () {
    test('has four values', () {
      expect(AlertState.values, hasLength(4));
      expect(AlertState.values, contains(AlertState.success));
      expect(AlertState.values, contains(AlertState.error));
    });
  });

  group('ToastState', () {
    test('has three values', () {
      expect(ToastState.values, hasLength(3));
    });
  });

  group('haptics', () {
    test('does not throw for each impact type', () {
      for (final impact in HapticImpact.values) {
        expect(() => haptics(impact: impact), returnsNormally);
      }
    });
  });
}
