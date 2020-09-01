import 'dart:io';

import 'package:art/configs/DefaultData.dart';
import 'package:art/posters/PosterExtraodinary.dart';
import 'package:art/posters/PosterRandomBack.dart';
import 'package:art/posters/PosterClassic.dart';
import 'package:art/posters/Collage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math';

import '../../configs/Palette.dart';

class AllPostersHome extends StatefulWidget {
  @override
  _AllPostersHomeState createState() => _AllPostersHomeState();
}

class _AllPostersHomeState extends State<AllPostersHome> {
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    appStoreIdentifier: '',
    googlePlayIdentifier: 'com.wwr.art',
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          title: 'Rate us...',
          message: 'Thank you!',
          actionsBuilder: (context, stars) {
            return [
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (stars != null) {
                    _rateMyApp.save().then((v) => Navigator.pop(context));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ];
          },
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: StarRatingOptions(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('All compositions'),
        ),
        child: Container(
          width: double.infinity,
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(4),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 0.6,
                  crossAxisCount: 3,
                  children: <Widget>[
                    for (var i = 0; i < widgetList.length; i++)
                      OneScreen(context, widgetList[i], previewsImages[i],
                          previewText[i]),
                  ],
                ),
              ),
              SliverPadding(
                  padding: const EdgeInsets.all(4),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.6,
                    crossAxisCount: 3,
                    children: <Widget>[
                      for (var i = 0; i < widgetListCollage.length; i++)
                        OneScreen(context, widgetListCollage[i],
                            previewsImagesCollage[i], previewTextCollage[i]),
                    ],
                  ))
            ],
          ),
        ));
  }
}

class OneRedactor extends StatefulWidget {
  final wid;
  const OneRedactor({
    Key key,
    this.wid,
  }) : super(key: key);
  @override
  _OneRedactorState createState() => _OneRedactorState();
}

class _OneRedactorState extends State<OneRedactor> {
  Color leftAction;
  Widget mainContainer;
  Random random = new Random();
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
    leftAction = CupertinoColors.white;
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
        ),
        child: Screenshot(
          controller: screenshotController,
          child: widget.wid,
        ));
  }
}

Widget OneScreen(context, wid, bg, text) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: bg,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.white, width: 2),
              ),
            ),
            Text(text)
          ],
        ),
        onTap: () {
          return Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) {
              return OneRedactor(
                wid: wid,
              );
            },
          ));
        },
      ));
}
