import 'package:flashly/flashly.dart';
import 'package:flashly/src/constants/animation_assets.dart';
import 'package:flashly/src/widgets/alert_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_helper.dart';

void main() {
  group('Alert golden tests', () {
    for (final entry in _alertCases.entries) {
      testWidgets(entry.key, (tester) async {
        await pumpGoldenWidget(
          tester,
          AlertContainer(
            asLoader: entry.value.asLoader,
            child: entry.value.child,
          ),
          surfaceSize: entry.value.size,
        );

        await tester.pump(const Duration(milliseconds: 800));
        await expectFlashlyGolden(tester, entry.key);
      });
    }
  });
}

class _AlertCase {
  const _AlertCase({
    required this.child,
    this.asLoader = false,
    this.size = const Size(360, 420),
  });

  final Widget child;
  final bool asLoader;
  final Size size;
}

final _alertCases = <String, _AlertCase>{
  'alert_success': _AlertCase(
    child: _buildAlert(
      'Operation completed',
      description: 'Your data was saved successfully.',
      state: AlertState.success,
      positiveTitle: 'OK',
    ),
  ),
  'alert_error': _AlertCase(
    child: _buildAlert(
      'Something went wrong',
      description: 'The operation could not be completed.',
      state: AlertState.error,
      negativeTitle: 'Cancel',
      positiveTitle: 'Try again',
      isDestructive: true,
    ),
    size: const Size(360, 440),
  ),
  'alert_warning': _AlertCase(
    child: _buildAlert(
      'Attention',
      description: 'Please review your data before continuing.',
      state: AlertState.warning,
      positiveTitle: 'Got it',
    ),
  ),
  'alert_loader': _AlertCase(
    child: _buildLoaderAlert('Loading...'),
    asLoader: true,
    size: const Size(360, 120),
  ),
};

Widget _buildAlert(
  String title, {
  String? description,
  AlertState? state,
  String? negativeTitle,
  String? positiveTitle,
  bool isDestructive = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        if (state != null) _animationForState(state),
        SizedBox(
          width: double.maxFinite,
          child: Column(
            spacing: 12,
            children: [
              Txt(
                title,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              if (description != null)
                Txt(
                  description,
                  fontSize: 15,
                  maxLines: 7,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: AlertActionButton(
                text: negativeTitle ?? 'Cancel',
                isDestructive: positiveTitle == null && isDestructive,
                isDestrutiveCancel: positiveTitle != null && isDestructive,
                isPositive: positiveTitle == null,
                onPressed: _noop,
              ),
            ),
            if (positiveTitle != null)
              Expanded(
                child: AlertActionButton(
                  text: positiveTitle,
                  isPositive: !isDestructive,
                  isDestructive: isDestructive,
                  onPressed: _noop,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLoaderAlert(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    child: Row(
      spacing: 16,
      children: [
        buildAnimation(FlashlyAnimations.loading, 50),
        Expanded(
          child: Txt(title, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    ),
  );
}

Widget _animationForState(AlertState state) {
  return switch (state) {
    AlertState.success => buildAnimation(FlashlyAnimations.alertSuccess),
    AlertState.error => buildAnimation(FlashlyAnimations.alertError),
    AlertState.info => buildAnimation(FlashlyAnimations.alertInfo),
    AlertState.warning => buildAnimation(FlashlyAnimations.warning),
  };
}

void _noop() {}
