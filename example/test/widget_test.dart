import 'package:flashly_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Example app renders home page', (tester) async {
    await tester.pumpWidget(const FlashlyExampleApp());

    expect(find.text('Flashly Example'), findsOneWidget);
    expect(find.text('Success alert'), findsOneWidget);
    expect(find.text('Success toast'), findsOneWidget);
  });
}
