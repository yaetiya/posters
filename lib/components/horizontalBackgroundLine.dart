import 'dart:math';

import 'package:flutter/cupertino.dart';

Widget horizontalBackgroundLine(bgColor) {
  Random random = Random();
  double rectangleHeight = random.nextInt(400).toDouble() + 10;
  double topBackgroundOff = random.nextInt(500).toDouble();
  return Positioned(
    child: SizedBox(
      width: 9999999.0,
      child: Container(
        height: rectangleHeight,
        width: double.infinity,
        child: null,
        decoration: BoxDecoration(color: bgColor),
      ),
    ),
    top: topBackgroundOff,
    left: 0,
  );
}
