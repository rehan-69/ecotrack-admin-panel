import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double responsiveFont(double desktopSize) {
    if (width < 600) {
      return desktopSize * 0.65;
    }

    if (width < 900) {
      return desktopSize * 0.80;
    }

    return desktopSize;
  }
}