import 'dart:io';

import 'package:art/functions/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../configs/Palette.dart';

class PosterExtraodinary extends StatefulWidget {
  final data;
  const PosterExtraodinary({
    Key key,
    this.data,
  }) : super(key: key);
  @override
  _PosterExtraodinaryState createState() => _PosterExtraodinaryState();
}

class _PosterExtraodinaryState extends State<PosterExtraodinary> {
  Color mainColr = extraColorsList[Random().nextInt(extraColorsList.length)];
  String bigText;
  String leadText;
  String topText;
  Random random = new Random();
  String kk;
  File _image1;
  File _image2;
  File _image3;
  final picker = ImagePicker();
  List coordinationsList;
  double t;
  bool firstload;
  AssetImage backgroudImage;

  @override
  void initState() {
    super.initState();

    topText =
        (Random().nextInt(2) == 0) ? (widget.data["topHeader_tr"]) : ("|||||");
    bigText = (Random().nextInt(2) == 0) ? (widget.data["h1_tr"]) : ("");
    leadText = widget.data["littleHeader_tr"];
    t = random.nextInt(100) + 110.0;
    coordinationsList = [
      [t + 83, 140.0],
      [30.0, 140.0]
    ];
    firstload = true;
    backgroudImage =
        posterExtraBacks[Random().nextInt(posterExtraBacks.length)];
  }

  Future getImage1() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image1 = File(pickedFile.path);
    });
  }

  Future getImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  Future getImage3() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image3 = File(pickedFile.path);
    });
  }

  Widget mainBlock(coordinations, top, lead) {
    return Positioned(
      left: coordinations[0],
      top: coordinations[1],
      child: Draggable(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getEditable(
                Text(
                  top.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Rowdies',
                    fontWeight: FontWeight.w100,
                    fontSize: (t / topText.length * 1.4),
                  ),
                ), (localController) {
              setState(() {
                topText = localController.text;
              });
            }, context),
            Container(
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(mainColr, BlendMode.hue),
                  child: GestureDetector(
                    child: (_image1 == null)
                        ? (Image(
                            image: AssetImage("assets/qr.png"),
                            fit: BoxFit.cover,
                          ))
                        : (Image.file(
                            _image1,
                            fit: BoxFit.cover,
                          )),
                    onDoubleTap: getImage1,
                  )),
              width: t,
              height: t,
              decoration: BoxDecoration(
                border: Border.all(
                  color: mainColr,
                  width: 10.0,
                ),
              ),
            ),
            getEditable(
                Text(
                  lead.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Red Rose',
                    fontWeight: FontWeight.w100,
                    fontSize: (t / widget.data["littleHeader_tr"].length * 1.6),
                  ),
                ), (localController) {
              setState(() {
                leadText = localController.text;
              });
            }, context),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        CupertinoColors.white, BlendMode.darken),
                    child: GestureDetector(
                      child: (_image3 == null)
                          ? (Image(
                              image: AssetImage("assets/qr.png"),
                              fit: BoxFit.cover,
                            ))
                          : (Image.file(
                              _image3,
                              fit: BoxFit.cover,
                            )),
                      onDoubleTap: getImage3,
                    ),
                  ),
                  width: ((280 - t) > t / 2) ? (t / 2 - 5) : ((280 - t)),
                ),
                SizedBox(width: 10),
                Container(
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(mainColr, BlendMode.darken),
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
                      )),
                  width: ((280 - t) > t / 2) ? (t / 2 - 5) : ((280 - t)),
                ),
                SizedBox(width: 10),
                Column(
                  children: <Widget>[
                    Container(
                      width: ((280 - t + 10) > t / 2)
                          ? (0)
                          : ((t - (280 - t) - (280 - t) - 20)),
                      height: 6,
                      decoration: BoxDecoration(color: mainColr),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        feedback: Column(
          children: <Widget>[
            Container(
              width: t,
              height: (t / topText.length * 1.4) + 2,
              decoration: BoxDecoration(color: CupertinoColors.white),
            ),
            Container(
              width: t,
              height: 200 - (t / topText.length * 1.4) - 2,
              decoration: BoxDecoration(color: mainColr),
            )
          ],
        ),
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          setState(() {
            coordinationsList[1][0] = (dragDetails.offset.dx);
            coordinationsList[1][1] = (dragDetails.offset.dy - 74);
          });
        },
      ),
    );
  }

  Widget rotaredText(coordinations, head) {
    return Positioned(
      left: coordinations[0],
      top: coordinations[1] + (t / topText.length * 2),
      child: Transform.rotate(
        alignment: Alignment.topLeft,
        angle: -pi / -2.0,
        child: Draggable(
          child: getEditable(
              Text(
                head.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Rowdies',
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
            height: (t / topText.length * 2),
            decoration: BoxDecoration(color: mainColr),
          ),
          childWhenDragging: Container(),
          onDragEnd: (dragDetails) {
            setState(() {
              coordinationsList[0][0] = dragDetails.offset.dx;
              coordinationsList[0][1] = (dragDetails.offset.dy - 74.0);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstload) {
      setState(() {
        backgroudImage =
            posterExtraBacks[Random().nextInt(posterExtraBacks.length)];
        firstload = false;
      });
    }
    return CupertinoPageScaffold(
        child: Stack(
      children: <Widget>[
        Center(child: CupertinoActivityIndicator()),
        Container(
          height: double.infinity,
          width: double.infinity,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(mainColr, BlendMode.darken),
            child: Image(
              image: backgroudImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        rotaredText(coordinationsList[0], bigText),
        mainBlock(coordinationsList[1], topText, leadText),
      ],
    ));
  }
}
