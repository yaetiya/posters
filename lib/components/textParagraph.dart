import 'package:art/configs/Palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textParagraph(head, text) {
  return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              head,
              style: TextStyle(
                  backgroundColor: mainThemeColor,
                  fontSize: 22,
                  color: Colors.black,
                  fontFamily: "RedRose",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18, fontFamily: "NotoSansTC"),
            )
          ],
        ),
      ));
}
