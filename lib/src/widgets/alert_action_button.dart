import 'dart:io';

import 'package:flashly/src/constants/colors.dart';
import 'package:flashly/src/extensions/haptic_callback.dart';
import 'package:flashly/src/widgets/press_effect.dart';
import 'package:flashly/src/widgets/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertActionButton extends StatefulWidget {
  const AlertActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.radius,
    this.isDestructive = false,
    this.isDestructiveCancel = false,
    this.isPositive = false,
    this.hapticsEnabled = true,
  });

  final VoidCallback? onPressed;
  final FontWeight? fontWeight;
  final String text;
  final double? fontSize;
  final bool isDestructive, isPositive, isDestructiveCancel, hapticsEnabled;
  final double? radius;

  @override
  State<AlertActionButton> createState() => _AlertActionButtonState();
}

class _AlertActionButtonState extends State<AlertActionButton> {
  BorderRadius get _borderRadius => BorderRadius.circular(widget.radius ?? 16);

  Color get _primaryColor => Theme.of(context).primaryColor;

  Widget _buildButtonDecoration(
    BuildContext context, {
    required Widget child,
  }) {
    late Color backgroundColor;

    if (widget.isDestructiveCancel) {
      backgroundColor = destructiveRed.withValues(alpha: .15);
    } else if (widget.isDestructive) {
      backgroundColor = destructiveRed;
    } else if (widget.isPositive) {
      backgroundColor = _primaryColor.withValues(alpha: 1);
    } else {
      backgroundColor = _primaryColor.withValues(alpha: .15);
    }

    return PressEffect(
      onPressed: () => widget.onPressed?.hapticCallback(widget.hapticsEnabled),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late Color overlayColor;
    late Color color;

    if (widget.isDestructiveCancel || widget.isDestructive) {
      overlayColor = destructiveRed;
    } else {
      overlayColor = _primaryColor;
    }

    if (widget.isDestructiveCancel) {
      color = destructiveRed;
    } else if (widget.isPositive || widget.isDestructive) {
      color = Theme.of(context).cardColor;
    } else {
      color = _primaryColor;
    }

    final child = Txt(
      widget.text,
      fontSize: 17,
      color: color,
      fontWeight: FontWeight.w800,
      maxLines: 1,
      overflow: .ellipsis,
    );

    if (Platform.isIOS) {
      return _buildButtonDecoration(
        context,
        child: CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          borderRadius: _borderRadius,
          color: Colors.transparent,
          onPressed: () => widget.onPressed?.hapticCallback(widget.hapticsEnabled),
          child: child,
        ),
      );
    }

    return _buildButtonDecoration(
      context,
      child: ElevatedButton(
        onPressed: () => widget.onPressed?.hapticCallback(widget.hapticsEnabled),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          overlayColor: overlayColor.withValues(alpha: .04),
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedSuperellipseBorder(borderRadius: _borderRadius),
        ),
        child: child,
      ),
    );
  }
}
