import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final _goldenTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF0066CC),
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF1A1A1A),
  ),
);

const goldenKey = ValueKey<String>('flashly_golden');

/// Pumps [child] with a fixed surface size for consistent golden images.
Future<void> pumpGoldenWidget(
  WidgetTester tester,
  Widget child, {
  Size surfaceSize = const Size(360, 200),
  ThemeData? theme,
  bool wrapCenter = true,
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final resolvedTheme = theme ?? _goldenTheme;
  final content = wrapCenter ? Center(child: child) : child;

  await tester.pumpWidget(
    MaterialApp(
      theme: resolvedTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: resolvedTheme.colorScheme.surface,
        body: KeyedSubtree(
          key: goldenKey,
          child: content,
        ),
      ),
    ),
  );
}

Future<void> expectFlashlyGolden(
  WidgetTester tester,
  String fileName,
) {
  return expectLater(
    find.byKey(goldenKey),
    matchesGoldenFile('goldens/$fileName.png'),
  );
}

/// Pumps toast widget inside a sized stack for golden capture.
Future<void> pumpToastGolden(
  WidgetTester tester,
  Widget toast, {
  Size surfaceSize = const Size(360, 160),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    MaterialApp(
      theme: _goldenTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: KeyedSubtree(
          key: goldenKey,
          child: MediaQuery(
            data: const MediaQueryData(
              padding: EdgeInsets.zero,
              size: Size(360, 160),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [toast],
            ),
          ),
        ),
      ),
    ),
  );

  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}
