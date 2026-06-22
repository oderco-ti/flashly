import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class AlertContainer extends StatelessWidget {
  const AlertContainer({
    super.key,
    required this.asLoader,
    required this.child,
    this.radius,
  });

  final bool asLoader;
  final Widget child;
  final double? radius;

  BorderRadius get _borderRadius => BorderRadius.circular(radius ?? 16);

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 326, maxHeight: 450),
      child: Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: Platform.isIOS ? 6 : 3,
              sigmaY: Platform.isIOS ? 6 : 3,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
                gradient: Platform.isIOS
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).cardColor.withValues(alpha: 0.55),
                          Theme.of(context).cardColor.withValues(alpha: 0.45),
                          Theme.of(context).cardColor.withValues(alpha: 0.38),
                          Theme.of(context).cardColor.withValues(alpha: 0.42),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      )
                    : null,
                color: Platform.isIOS ? null : Theme.of(context).cardColor,
                border: Platform.isIOS
                    ? Border.all(
                        width: .6,
                        color: Theme.of(context).cardColor.withValues(alpha: 0.4),
                      )
                    : null,
                boxShadow: Platform.isIOS
                    ? [
                        BoxShadow(
                          color: Theme.of(context).cardColor.withValues(alpha: 0.6),
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
                      ]
                    : null,
              ),
              child: Container(
                decoration: Platform.isIOS
                    ? BoxDecoration(
                        borderRadius: _borderRadius,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).cardColor.withValues(alpha: 0.08),
                            Theme.of(context).cardColor.withValues(alpha: 0.02),
                          ],
                        ),
                      )
                    : null,
                child: ClipRRect(
                  borderRadius: _borderRadius,
                  child: BackdropFilter(
                    filter: Platform.isIOS
                        ? ImageFilter.blur(sigmaX: 4, sigmaY: 4)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      decoration: Platform.isIOS
                          ? BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.topLeft,
                                radius: 2.0,
                                colors: [
                                  Theme.of(context).cardColor.withValues(alpha: 0.03),
                                  Colors.transparent,
                                ],
                              ),
                            )
                          : null,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (asLoader) return Center(child: content);
    return content;
  }
}
