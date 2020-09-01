import 'package:art/configs/Palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget inputComponentPoster(
  label,
  controller,
) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
    child: TextFormField(
      style: TextStyle(color: CupertinoColors.white),
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(
              color: mainThemeColor, width: 2, style: BorderStyle.solid),
        ),
        labelText: label,
        icon: Icon(
          CupertinoIcons.tags_solid,
          color: mainThemeColor,
        ),
        fillColor: CupertinoColors.darkBackgroundGray,
        labelStyle: TextStyle(
          color: CupertinoColors.white,
        ),
      ),
    ),
  );
}
