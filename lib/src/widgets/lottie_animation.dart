import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget buildAnimation(String icon, [double? size]) {
  return Lottie.asset(
    icon,
    width: size ?? 70,
    height: size ?? 70,
    fit: BoxFit.cover,
    repeat: true,
    package: 'flashly',
  );
}
