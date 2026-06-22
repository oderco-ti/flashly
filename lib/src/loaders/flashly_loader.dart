import 'dart:io';

import 'package:flashly/src/constants/animation_assets.dart';
import 'package:flashly/src/widgets/lottie_animation.dart';
import 'package:flutter/material.dart';

export 'package:flashly/src/widgets/lottie_animation.dart';

Widget loader({
  double? size = 24,
  Color? color,
  Key? key,
  double? scaleFactor,
  double? androidStrokeWidth,
  bool asNative = true,
}) {
  final indicator = Transform.scale(
    scale: scaleFactor ?? (Platform.isIOS ? 1.2 : 1),
    child: asNative
        ? CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(color),
            strokeWidth: androidStrokeWidth ?? 2,
          )
        : buildAnimation(FlashlyAnimations.loading, 50),
  );

  return Center(
    child: SizedBox(
      width: size,
      height: size,
      child: color != null
          ? ColorFiltered(
              colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
              child: indicator,
            )
          : indicator,
    ),
  );
}
