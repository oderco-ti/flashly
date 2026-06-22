import 'package:flashly/flashly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden_helper.dart';

void main() {
  group('Golden tests', () {
    testWidgets('Txt default', (tester) async {
      await pumpGoldenWidget(
        tester,
        const Txt('Hello Flashly'),
        surfaceSize: const Size(280, 80),
      );

      await expectFlashlyGolden(tester, 'txt_default');
    });

    testWidgets('Txt styled', (tester) async {
      await pumpGoldenWidget(
        tester,
        const Txt(
          'Styled text',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0066CC),
        ),
        surfaceSize: const Size(280, 80),
      );

      await expectFlashlyGolden(tester, 'txt_styled');
    });

    testWidgets('RichTxt', (tester) async {
      await pumpGoldenWidget(
        tester,
        const RichTxt(
          text1: 'Part 1 ',
          text2: 'Part 2',
          fontSize: 16,
          color2: Color(0xFF0066CC),
          decoration2: TextDecoration.underline,
        ),
        surfaceSize: const Size(280, 80),
      );

      await expectFlashlyGolden(tester, 'rich_txt');
    });

    testWidgets('AlertActionButton variants', (tester) async {
      await pumpGoldenWidget(
        tester,
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            SizedBox(
              width: 280,
              child: AlertActionButton(text: 'Cancelar', onPressed: _noop),
            ),
            SizedBox(
              width: 280,
              child: AlertActionButton(
                text: 'Confirmar',
                isPositive: true,
                onPressed: _noop,
              ),
            ),
            SizedBox(
              width: 280,
              child: AlertActionButton(
                text: 'Excluir',
                isDestructive: true,
                onPressed: _noop,
              ),
            ),
          ],
        ),
        surfaceSize: const Size(320, 220),
      );

      await expectFlashlyGolden(tester, 'alert_action_buttons');
    });

    testWidgets('loader', (tester) async {
      await pumpGoldenWidget(
        tester,
        loader(color: const Color(0xFF0066CC)),
        surfaceSize: const Size(80, 80),
      );

      await expectFlashlyGolden(tester, 'loader');
    });

    testWidgets('AnimatedToast success', (tester) async {
      await pumpToastGolden(
        tester,
        AnimatedToast(
          message: 'Copiado para a área de transferência',
          state: ToastState.success,
          onDismissed: () {},
        ),
      );

      await expectFlashlyGolden(tester, 'toast_success');
    });

    testWidgets('AnimatedToast error', (tester) async {
      await pumpToastGolden(
        tester,
        AnimatedToast(
          message: 'Falha ao enviar',
          state: ToastState.error,
          onDismissed: () {},
        ),
      );

      await expectFlashlyGolden(tester, 'toast_error');
    });

    testWidgets('AnimatedToast info', (tester) async {
      await pumpToastGolden(
        tester,
        AnimatedToast(
          message: 'Sincronização em andamento',
          state: ToastState.info,
          onDismissed: () {},
        ),
      );

      await expectFlashlyGolden(tester, 'toast_info');
    });
  });
}

void _noop() {}
