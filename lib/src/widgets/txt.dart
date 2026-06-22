import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  const Txt(
    this.text, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontFamily,
    this.style,
    this.decoration,
    this.textAlign,
    this.overflow,
    this.height,
    this.maxLines,
  });

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextStyle? style;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? height;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.visible,
      textAlign: textAlign,
      maxLines: maxLines,
      style:
          style ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: fontSize ?? 16,
            color: color ?? Theme.of(context).colorScheme.onSurface,
            decoration: decoration,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            decorationColor: color ?? Theme.of(context).colorScheme.onSurface,
            height: height,
          ),
    );
  }
}
