import 'dart:async';

import 'package:flashly/src/alerts/show_alert.dart';
import 'package:flashly/src/core/flashly.dart';
import 'package:flutter/material.dart';

void showTimingLoaderAlert(
  String placeholder, [
  int? secs,
]) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showLoaderAlert(placeholder: placeholder));
  Timer(Duration(seconds: secs ?? 2), () => Navigator.pop(Flashly.context));
}

void showLoaderAlert({
  String? placeholder,
  int? closeLoaderAfterSecs,
  BuildContext? context,
}) {
  final placeholdr = placeholder != null ? '$placeholder...' : '';
  showAlert(
    placeholdr,
    context: context,
    asLoader: true,
    isDestructive: true,
    negativeTitle: 'Fechar',
    closeLoaderAfterSecs: closeLoaderAfterSecs ?? 45,
  );
}

void closeLoaderAlert([BuildContext? context]) {
  if (Navigator.canPop(context ?? Flashly.context)) {
    Navigator.pop(context ?? Flashly.context);
  }
}
