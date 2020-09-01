import 'dart:math';

import 'package:flutter/cupertino.dart';

Widget verticalBackgroundLine(bgColor) {
  Random random = Random();
  double rectangleWidth = random.nextInt(200).toDouble() + 10;
  double leftBackgroundOff = random.nextInt(500).toDouble();
  return Positioned(
    child: SizedBox(
      height: 9999999.0,
      child: Container(
        width: rectangleWidth,
        height: double.infinity,
        child: null,
        decoration: BoxDecoration(color: bgColor),
      ),
    ),
    left: leftBackgroundOff,
    top: 0,
  );
}
