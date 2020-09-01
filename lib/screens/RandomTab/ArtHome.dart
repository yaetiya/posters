import 'dart:io';
import 'package:art/configs/DefaultData.dart';
import 'package:art/posters/PosterExtraodinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/rendering.dart';

import '../../posters/PosterRandomBack.dart';
import '../../posters/PosterClassic.dart';
import '../../configs/Palette.dart';

class ArtHome extends StatefulWidget {
  final controlls;
  const ArtHome({
    Key key,
    this.controlls,
  }) : super(key: key);
  @override
  _ArtHomeState createState() => _ArtHomeState();
}

class _ArtHomeState extends State<ArtHome> {
  Color leftAction;
  List coords;

  Widget mainContainer;
  Random random = new Random();

  dynamic data;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    leftAction = CupertinoColors.white;

    data = {
      "coords_tr": coords,
      "littleHeader_tr": widget.controlls[3].text,
      "topHeader_tr": widget.controlls[2].text,
      "h1_tr": widget.controlls[0].text,
      "desctiption_tr": widget.controlls[1].text,
    };

    if (data["desctiption_tr"] == "") {
      data["desctiption_tr"] = defaultData['desctiption_tr'];
    }
    if (data["littleHeader_tr"] == "") {
      data["littleHeader_tr"] = defaultData['littleHeader_tr'];
    }
    if (data["topHeader_tr"] == "") {
      data["topHeader_tr"] = defaultData['topHeader_tr'];
    }
    if (data["h1_tr"] == "") {
      data["h1_tr"] = defaultData['h1_tr'];
    }

    mainContainer = new PosterRandomBack(
      data: data,
    );
  }

  void getRandom(data) {
    final List<Widget> allPosters = [
      PosterRandomBack(
        data: data,
      ),
      PosterExtraodinary(
        data: data,
      ),
      PosterClassic(
        data: data,
      ),
      PosterRandomBack(
        data: data,
        isVerticalOnly: false,
      ),
      PosterRandomBack(
        data: data,
        isImageBackground: true,
      ),
    ];

    final newMainPoster = allPosters[random.nextInt(allPosters.length)];
    if (mainContainer != newMainPoster) {
      setState(() {
        mainContainer = newMainPoster;
      });
    } else {
      setState(() {
        mainContainer = allPosters[random.nextInt(allPosters.length)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Column(
              children: <Widget>[
                Spacer(),
                GestureDetector(
                  child: Text(
                    'Save',
                    style: TextStyle(color: leftAction),
                  ),
                  onTap: () {
                    setState(() {
                      leftAction = mainThemeColor;
                    });

                    screenshotController
                        .capture(
                            delay: Duration(milliseconds: 500), pixelRatio: 1.5)
                        .then((File image) async {
                      final paths = await getExternalStorageDirectory();
                      final mainpath = paths.path +
                          '/' +
                          DateTime.now().millisecondsSinceEpoch.toString() +
                          '.png';
                      image.copy(mainpath);
                      setState(() {
                        leftAction = CupertinoColors.white;
                      });
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('Succesfully saved to'),
                            content: Text(mainpath),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                ),
                Spacer(),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                getRandom(data);
              },
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text('New'),
                  Spacer(),
                ],
              ),
            )),
        child: Screenshot(
          controller: screenshotController,
          child: mainContainer,
        ));
  }
}
