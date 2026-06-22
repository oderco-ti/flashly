import 'dart:async';

import 'package:flashly/src/alerts/alert_state.dart';
import 'package:flashly/src/constants/animation_assets.dart';
import 'package:flashly/src/core/flashly.dart';
import 'package:flashly/src/feedback/haptic_feedback.dart';
import 'package:flashly/src/feedback/sound_feedback.dart';
import 'package:flashly/src/widgets/alert_action_button.dart';
import 'package:flashly/src/widgets/alert_container.dart';
import 'package:flashly/src/widgets/lottie_animation.dart';
import 'package:flashly/src/widgets/rich_txt.dart';
import 'package:flashly/src/widgets/txt.dart';
import 'package:flutter/material.dart';

export 'alert_state.dart';

Future<T?> showAlert<T>(
  String title, {
  String? richTitle,
  String? description,
  String? richDescription,
  String? negativeTitle,
  String? positiveTitle,
  BuildContext? context,
  AlertState? state,
  bool isDestructive = false,
  bool asLoader = false,
  VoidCallback? onNegative,
  int? closeLoaderAfterSecs,
  Future<void> Function()? onPositive,
  bool enableHaptics = false,
  bool enableSound = false,
  double? radius,
  double? actionButtonRadius,
  VoidCallback? onTapRichTitle,
  VoidCallback? onTapRichDescription,
  Color? richTitleColor,
  Color? richDescriptionColor,
  FontStyle? richDescriptionFontStyle,
}) async {
  if (!asLoader) {
    if (enableHaptics) haptics();
    if (enableSound) playSound(state == AlertState.error);
  }

  return _showDialog<T>(
    title,
    description: description,
    richTitle: richTitle,
    richDescription: richDescription,
    negativeTitle: negativeTitle,
    positiveTitle: positiveTitle,
    isDestructive: isDestructive,
    onNegative: onNegative,
    onPositive: onPositive,
    asLoader: asLoader,
    closeLoaderAfterSecs: closeLoaderAfterSecs,
    state: state,
    context: context,
    radius: radius,
    actionButtonRadius: actionButtonRadius,
    onTapRichTitle: onTapRichTitle,
    onTapRichDescription: onTapRichDescription,
    richTitleColor: richTitleColor,
    richDescriptionColor: richDescriptionColor,
    richDescriptionFontStyle: richDescriptionFontStyle,
    hapticsEnabled: enableHaptics,
  );
}

Future<T?> _showDialog<T>(
  String title, {
  String? richTitle,
  String? richDescription,
  String? description,
  String? negativeTitle,
  String? positiveTitle,
  BuildContext? context,
  bool isDestructive = false,
  bool asLoader = false,
  VoidCallback? onNegative,
  int? closeLoaderAfterSecs,
  Future<void> Function()? onPositive,
  VoidCallback? onTapRichTitle,
  VoidCallback? onTapRichDescription,
  FontStyle? richDescriptionFontStyle,
  Color? richTitleColor,
  Color? richDescriptionColor,
  AlertState? state,
  double? radius,
  double? actionButtonRadius,
  bool hapticsEnabled = true,
}) async {
  bool showButton = false;
  bool timerStarted = false;

  Widget buildDefaultActionButton() {
    return AlertActionButton(
      text: negativeTitle ?? 'Cancelar',
      isDestructive: positiveTitle == null && isDestructive,
      isDestructiveCancel: positiveTitle != null && isDestructive,
      isPositive: positiveTitle == null,
      radius: actionButtonRadius,
      hapticsEnabled: hapticsEnabled,
      onPressed: () {
        Navigator.pop(context ?? Flashly.context);
        if (onNegative != null) onNegative();
      },
    );
  }

  Widget buildChild() => AnimatedSize(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: asLoader ? 14 : 25),
      child: StatefulBuilder(
        builder: (ctx, setState) {
          if (!timerStarted && closeLoaderAfterSecs != null) {
            timerStarted = true;
            Future.delayed(Duration(seconds: closeLoaderAfterSecs), () {
              if (ctx.mounted && Navigator.canPop(context ?? Flashly.context)) {
                setState(() => showButton = true);
              }
            });
          }

          return Column(
            spacing: (asLoader && showButton) || !asLoader ? 20 : 0,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: asLoader ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              if (state != null && !asLoader) ...[
                if (state == AlertState.success)
                  buildAnimation(FlashlyAnimations.alertSuccess)
                else if (state == AlertState.error)
                  buildAnimation(FlashlyAnimations.alertError)
                else if (state == AlertState.info)
                  buildAnimation(FlashlyAnimations.alertInfo)
                else if (state == AlertState.warning)
                  buildAnimation(FlashlyAnimations.warning),
              ],
              if (asLoader)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildAnimation(FlashlyAnimations.loading, 50),
                      Expanded(child: Txt(title, fontWeight: FontWeight.w500, fontSize: 16)),
                    ],
                  ),
                )
              else
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      if (title.isNotEmpty) ...[
                        if (richTitle != null)
                          RichTxt(
                            text1: title,
                            text2: richTitle,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            onTap2: onTapRichTitle,
                            decoration2: .underline,
                            color2: richTitleColor ?? Theme.of(ctx).primaryColor,
                            textAlign: TextAlign.center,
                            textOverflow1: TextOverflow.ellipsis,
                            textOverflow2: .ellipsis,
                          )
                        else
                          Txt(
                            title,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                      if (description != null) ...[
                        if (richDescription != null)
                          RichTxt(
                            text1: description,
                            text2: richDescription,
                            onTap2: onTapRichDescription,
                            color2: richDescriptionColor ?? Theme.of(ctx).colorScheme.onSurface,
                            textAlign: .center,
                            textOverflow1: .ellipsis,
                            textOverflow2: .ellipsis,
                            fontStyle2: richDescriptionFontStyle,
                            fontSize: 15,
                            fontWeight: .w500,
                          )
                        else
                          Txt(
                            description,
                            color: Theme.of(ctx).colorScheme.onSurface,
                            fontSize: 15,
                            maxLines: 7,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ],
                  ),
                ),
              Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (asLoader)
                    Expanded(
                      child: AnimatedScale(
                        scale: showButton ? 1.0 : .5,
                        duration: const Duration(milliseconds: 500),
                        child: Visibility(
                          visible: showButton,
                          maintainSize: false,
                          maintainAnimation: true,
                          maintainState: true,
                          child: buildDefaultActionButton(),
                        ),
                      ),
                    )
                  else
                    Expanded(child: buildDefaultActionButton()),
                  if (positiveTitle != null && !asLoader)
                    Expanded(
                      child: AlertActionButton(
                        text: positiveTitle,
                        isPositive: !isDestructive,
                        isDestructive: isDestructive,
                        radius: actionButtonRadius,
                        hapticsEnabled: hapticsEnabled,
                        onPressed: () {
                          Navigator.pop(context ?? Flashly.context);
                          if (onPositive != null) onPositive();
                        },
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );

  return showDialog<T>(
    context: context ?? Flashly.context,
    barrierDismissible: false,
    barrierColor: Colors.black45,
    useRootNavigator: context == null,
    builder: (context) {
      final size = MediaQuery.of(context).size;

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height,
            minWidth: size.width,
          ),
          child: Center(
            child: AlertContainer(
              asLoader: asLoader,
              radius: radius,
              child: buildChild(),
            ),
          ),
        ),
      );
    },
  );
}
