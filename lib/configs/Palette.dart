import 'dart:math';

import 'package:art/posters/Collage.dart';
import 'package:art/posters/PosterClassic.dart';
import 'package:art/posters/PosterExtraodinary.dart';
import 'package:art/posters/PosterRandomBack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DefaultData.dart';

List<Color> appThemeColorList = [
  Color.fromARGB(255, 20, 243, 190),
  CupertinoColors.systemPink
];
final Color mainThemeColor =
    appThemeColorList[Random().nextInt(appThemeColorList.length)];

List<Color> defaultColorsList = [
  CupertinoColors.activeBlue,
  CupertinoColors.systemPink,
  CupertinoColors.systemYellow,
  Colors.black12,
  Colors.orange,
  Colors.blueGrey,
  Color.fromARGB(130, 199, 219, 4),
  Color.fromARGB(130, 245, 69, 8),
  Color.fromARGB(130, 7, 250, 240),
  Color.fromARGB(130, 243, 227, 0),
  Color.fromARGB(130, 64, 125, 142),
  Color.fromARGB(100, 0, 255, 255),
  Color.fromARGB(100, 255, 0, 0)
];

List<Color> classicColorsList = [
  Colors.black,
  Colors.brown[100],
  Colors.brown[300],
  Colors.blueGrey
];

List extraColorsList = [
  CupertinoColors.systemPink,
  CupertinoColors.white,
  CupertinoColors.activeBlue,
  CupertinoColors.systemPurple,
  Colors.blueGrey,
  Color.fromRGBO(199, 219, 4, 1),
  Color.fromRGBO(245, 69, 8, 1),
  Color.fromRGBO(7, 250, 240, 1),
  Color.fromRGBO(243, 227, 0, 1),
  Color.fromRGBO(64, 125, 142, 1),
];

List<AssetImage> posterClassicBacks = [
  AssetImage('assets/ClassicBackground/0.jpg'),
  AssetImage('assets/ClassicBackground/1.jpg'),
  AssetImage('assets/ClassicBackground/2.jpg'),
  AssetImage('assets/ClassicBackground/3.jpg'),
  AssetImage('assets/ClassicBackground/4.jpg')
];

List<AssetImage> posterUsualBacks = [
  AssetImage('assets/LightBackground/0.jpg'),
  AssetImage('assets/LightBackground/1.jpg'),
  AssetImage('assets/LightBackground/2.jpg'),
  AssetImage('assets/LightBackground/3.jpg'),
  AssetImage('assets/LightBackground/4.jpg')
];
List<AssetImage> posterExtraBacks = [
  AssetImage('assets/ExtraBackgrounds/0.jpg'),
  AssetImage('assets/ExtraBackgrounds/1.jpg'),
  AssetImage('assets/ExtraBackgrounds/2.jpg'),
  AssetImage('assets/ExtraBackgrounds/3.jpg'),
  AssetImage('assets/ExtraBackgrounds/4.jpg'),
  AssetImage('assets/ExtraBackgrounds/5.jpg'),
  AssetImage('assets/ExtraBackgrounds/6.jpg'),
  AssetImage('assets/ExtraBackgrounds/7.jpg'),
];

List<Widget> widgetList = [
  PosterClassic(
    data: defaultData,
  ),
  PosterExtraodinary(
    data: defaultData,
  ),
  PosterRandomBack(
    data: defaultData,
  ),
  PosterRandomBack(
    data: defaultData,
    isVerticalOnly: false,
  ),
  PosterRandomBack(
    data: defaultData,
    isImageBackground: true,
  )
];

List<AssetImage> previewsImages = [
  AssetImage('assets/Preview/0.jpg'),
  AssetImage('assets/Preview/1.jpg'),
  AssetImage('assets/Preview/2.jpg'),
  AssetImage('assets/Preview/3.jpg'),
  AssetImage('assets/Preview/4.jpg'),
];

List<String> previewText = [
  'Classic',
  'Exrta',
  'Vertical',
  'Horizontal',
  'Modern'
];
List<String> previewTextCollage = ['1x1', '3x3', '4x3', '3x2', '2x2'];
List<Widget> widgetListCollage = [
  Collage(
    d: 1,
    oneLine: 1,
  ),
  Collage(
    d: 9,
    oneLine: 3,
  ),
  Collage(
    d: 12,
    oneLine: 3,
  ),
  Collage(
    d: 6,
    oneLine: 2,
  ),
  Collage(
    d: 4,
    oneLine: 2,
  ),
];

List<AssetImage> previewsImagesCollage = [
  AssetImage('assets/Preview/colEx11.jpg'),
  AssetImage('assets/Preview/colEx39.jpg'),
  AssetImage('assets/Preview/colEx312.jpg'),
  AssetImage('assets/Preview/colEx26.jpg'),
  AssetImage('assets/Preview/colEx24.jpg'),
];
