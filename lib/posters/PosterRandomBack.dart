import 'dart:io';

import 'package:art/components/HorizontalBackgroundLine.dart';
import 'package:art/components/verticalBackgroundLine.dart';
import 'package:art/functions/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../configs/Palette.dart';

class PosterRandomBack extends StatefulWidget {
  final bool isVerticalOnly;
  final bool isImageBackground;
  final data;
  const PosterRandomBack({
    Key key,
    this.isImageBackground = false,
    this.isVerticalOnly = true,
    this.data,
  }) : super(key: key);
  @override
  _PosterRandomBackState createState() => _PosterRandomBackState();
}

class _PosterRandomBackState extends State<PosterRandomBack> {
  List<Widget> backgroundItem;
  Color bgColor = defaultColorsList[Random().nextInt(defaultColorsList.length)];
  AssetImage backgroundImage;
  String bigText;
  String descrText;
  String leadText;
  String topText;

  List coords = [];
  bool firstLoad;
  File _image;
  File _image2;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    firstLoad = true;
    coords = [
      [26.0, 20.0],
      [26.0, 90.0],
      [26.0, 10.0],
      [26.0, 10.0],
    ];

    descrText = widget.data["desctiption_tr"];
    topText =
        (Random().nextInt(2) == 0) ? (widget.data["topHeader_tr"]) : ("|||||");
    bigText = widget.data["h1_tr"];
    leadText = widget.data["littleHeader_tr"];
    backgroundImage =
        posterUsualBacks[Random().nextInt(posterUsualBacks.length)];
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  Widget topHeadBlock(topHead) {
    return Positioned(
      left: coords[2][0],
      bottom: coords[2][1],
      child: Draggable(
        child: getEditable(
            Text(
              topHead,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'NotoSansTC',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ), (localController) {
          setState(() {
            topText = localController.text;
          });
        }, context),
        feedback: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: Colors.black38),
        ),
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          setState(() {
            coords[2][0] = dragDetails.offset.dx;
            coords[2][1] = MediaQuery.of(context).size.height -
                dragDetails.offset.dy -
                74 -
                20 +
                1;
          });
        },
      ),
    );
  }

  Widget bigHeadBlock(bigHead) {
    return Positioned(
      left: coords[0][0],
      bottom: coords[0][1],
      child: Draggable(
        child: getEditable(
            Text(
              bigHead,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'NotoSansTC',
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ), (localController) {
          setState(() {
            bigText = localController.text;
          });
        }, context),
        feedback: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: Colors.black38),
        ),
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          setState(() {
            coords[0][0] = dragDetails.offset.dx;
            coords[0][1] = MediaQuery.of(context).size.height -
                dragDetails.offset.dy -
                74 -
                40 +
                3;
          });
        },
      ),
    );
  }

  Widget qrBlock(descr, lead) {
    return Positioned(
      left: coords[3][0],
      bottom: coords[3][1],
      child: Draggable(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.screen),
                child: GestureDetector(
                  child: (_image2 == null)
                      ? (Image(
                          image: AssetImage("assets/qr.png"),
                          fit: BoxFit.cover,
                        ))
                      : (Image.file(
                          _image2,
                          fit: BoxFit.cover,
                        )),
                  onDoubleTap: getImage2,
                ),
              ),
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getEditable(
                    Text(
                      descr,
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'NotoSansTC',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ), (localController) {
                  setState(() {
                    descrText = localController.text;
                  });
                }, context),
                getEditable(
                    Text(
                      lead,
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'NotoSansTC',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ), (localController) {
                  setState(() {
                    leadText = localController.text;
                  });
                }, context),
              ],
            )
          ],
        ),
        feedback: Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(color: Colors.black38),
        ),
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          setState(() {
            coords[3][0] = dragDetails.offset.dx;
            coords[3][1] =
                MediaQuery.of(context).size.height - dragDetails.offset.dy - 94;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      firstLoad = false;
      setState(() {
        coords[0][1] = MediaQuery.of(context).size.width;
        coords[2][1] = MediaQuery.of(context).size.width + 46;
        bgColor = defaultColorsList[Random().nextInt(defaultColorsList.length)];
        backgroundItem = [
          (widget.isVerticalOnly)
              ? verticalBackgroundLine(bgColor)
              : horizontalBackgroundLine(bgColor),
          verticalBackgroundLine(bgColor)
        ];
      });
      backgroundImage =
          posterUsualBacks[Random().nextInt(posterUsualBacks.length)];
    }

    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          Center(child: CupertinoActivityIndicator()),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
          ),
          (widget.isImageBackground)
              ? (Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image(
                    image: backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ))
              : (backgroundItem[0]),
          (widget.isImageBackground) ? (SizedBox()) : (backgroundItem[1]),
          qrBlock(descrText, leadText),
          topHeadBlock(topText),
          bigHeadBlock(bigText),
          Positioned(
            left: coords[1][0],
            bottom: coords[1][1],
            child: Draggable(
              child: Container(
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          CupertinoColors.white, BlendMode.colorBurn),
                      child: GestureDetector(
                        child: (_image == null)
                            ? (Image(
                                image: AssetImage("assets/qr.png"),
                                fit: BoxFit.cover,
                              ))
                            : (Image.file(
                                _image,
                                fit: BoxFit.cover,
                              )),
                        onDoubleTap: getImage,
                      )),
                  width: (MediaQuery.of(context).size.width - 90),
                  height: (MediaQuery.of(context).size.width - 90),
                  decoration: (!widget.isImageBackground)
                      ? (BoxDecoration(
                          border: Border.all(
                            color: bgColor,
                            width: 10.0,
                          ),
                        ))
                      : (BoxDecoration())),
              feedback: Container(
                width: (MediaQuery.of(context).size.width - 90),
                height: (MediaQuery.of(context).size.width - 90),
                decoration: BoxDecoration(color: Colors.black38),
              ),
              childWhenDragging: Container(),
              onDragEnd: (dragDetails) {
                setState(() {
                  coords[1][0] = (dragDetails.offset.dx);
                  coords[1][1] = (MediaQuery.of(context).size.height -
                          dragDetails.offset.dy) -
                      (MediaQuery.of(context).size.width - 90) -
                      53;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
