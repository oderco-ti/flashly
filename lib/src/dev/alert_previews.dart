import 'dart:ui';

import 'package:flashly/flashly.dart';
import 'package:flashly/src/constants/animation_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

Widget _buildAlertContent(
  String title, {
  String? description,
  String? negativeTitle,
  String? positiveTitle,
  bool isDestructive = false,
  bool asLoader = false,
  VoidCallback? onNegative,
  int? closeLoaderAfterSecs,
  Future<void> Function()? onPositive,
  AlertState? state,
}) {
  bool showButton = false;
  bool timerStarted = false;
  const actionButtonRadius = 16.0;

  Widget buildDefaultActionButton() {
    return AlertActionButton(
      text: negativeTitle ?? 'Cancelar',
      isDestructive: positiveTitle == null && isDestructive,
      radius: actionButtonRadius,
      onPressed: () {
        Navigator.pop(Flashly.context);
        if (onNegative != null) onNegative();
      },
    );
  }

  return AnimatedSize(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: StatefulBuilder(
        builder: (context, setState) {
          if (!timerStarted && closeLoaderAfterSecs != null) {
            timerStarted = true;
            Future.delayed(Duration(seconds: closeLoaderAfterSecs), () {
              if (context.mounted && Navigator.canPop(Flashly.context)) {
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
                  buildAnimation(FlashlyAnimations.alertInfo),
              ],
              if (asLoader)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildAnimation(FlashlyAnimations.loading),
                      Expanded(child: Txt(title, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                )
              else
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      if (title.isNotEmpty)
                        Txt(
                          title,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (description != null)
                        Txt(
                          description,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 17,
                          maxLines: 5,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                        onPressed: () {
                          Navigator.pop(Flashly.context);
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
}

@Preview(name: 'Loader')
Widget loaderPreview() {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          strokeWidth: 2.0,
        ),
      ),
    ),
  );
}

@Preview(name: 'Alert')
Widget alertPreview() {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320, maxHeight: 300),
          child: Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.25),
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.12),
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                    border: Border.all(
                      width: .6,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.6),
                        offset: const Offset(0, 1),
                        blurRadius: 0,
                        spreadRadius: 0,
                        blurStyle: BlurStyle.inner,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, 8),
                        blurRadius: 32,
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.02),
                        ],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.topLeft,
                              radius: 2.0,
                              colors: [
                                Colors.white.withValues(alpha: 0.03),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: _buildAlertContent(
                              'Alert Title',
                              asLoader: true,
                              description: 'Esta é uma descrição',
                              state: AlertState.info,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
