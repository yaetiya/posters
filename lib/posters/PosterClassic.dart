import 'dart:io';

import 'package:art/configs/Palette.dart';
import 'package:art/functions/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class PosterClassic extends StatefulWidget {
  final data;
  const PosterClassic({
    Key key,
    this.data,
  }) : super(key: key);
  @override
  _PosterClassicState createState() => _PosterClassicState();
}

class _PosterClassicState extends State<PosterClassic> {
  AssetImage backImage =
      posterClassicBacks[Random().nextInt(posterClassicBacks.length)];
  Color tColor = classicColorsList[Random().nextInt(classicColorsList.length)];
  List coords = [];
  String bigText;
  String descrText;
  File _image1;
  File _image2;
  String leadText;
  String topText;
  final picker = ImagePicker();
  bool firstLoad;
  @override
  void initState() {
    super.initState();
    firstLoad = true;
    coords = [
      [10.0, 20.0],
      [10.0, 10.0],
      [10.0, 10.0],
      [10.0, 10.0],
    ];

    descrText = widget.data["desctiption_tr"];
    topText = (Random().nextInt(2) == 0)
        ? (widget.data["topHeader_tr"])
        : ("--------");
    bigText = widget.data["h1_tr"];
    leadText = widget.data["littleHeader_tr"];
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

  Widget head2(head2) {
    return Positioned(
      left: coords[2][0],
      bottom: coords[2][1],
      child: Draggable(
        child: getEditable(
            Text(
              head2,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'NotoSansTC',
                fontWeight: FontWeight.w200,
                fontSize: 30,
              ),
            ), (localController) {
          setState(() {
            topText = localController.text;
          });
        }, context),
        feedback: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(color: Colors.black38),
        ),
        childWhenDragging: Container(),
        onDragEnd: (dragDetails) {
          setState(() {
            firstLoad = false;
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

  Widget head1(head1) {
    return Positioned(
      left: coords[0][0],
      bottom: coords[0][1],
      child: Draggable(
        child: getEditable(
            Text(
              head1,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'NotoSansTC',
                fontWeight: FontWeight.w300,
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
            firstLoad = false;
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

  Widget littleHead(head4, head3) {
    return Positioned(
      left: coords[3][0],
      top: coords[3][1],
      child: Draggable(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(tColor, BlendMode.hue),
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
                      head3,
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'NotoSansTC',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ), (localController) {
                  setState(() {
                    leadText = localController.text;
                  });
                }, context),
                getEditable(
                    Text(
                      head4,
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'NotoSansTC',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ), (localController) {
                  setState(() {
                    descrText = localController.text;
                  });
                }, context)
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
            firstLoad = false;
            coords[3][0] = dragDetails.offset.dx;
            coords[3][1] = dragDetails.offset.dy - 74;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      setState(() {
        coords[0][1] = MediaQuery.of(context).size.width;
        coords[2][1] = MediaQuery.of(context).size.width + 46;
      });
    }

    return CupertinoPageScaffold(
        child: ColorFiltered(
      colorFilter: ColorFilter.mode(tColor, BlendMode.softLight),
      child: Stack(
        children: <Widget>[
          Center(child: CupertinoActivityIndicator()),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(Colors.black12, BlendMode.hardLight),
              child: Image(
                image: backImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          littleHead(descrText, leadText),
          head2(topText),
          head1(bigText),
          Positioned(
            left: coords[1][0],
            bottom: coords[1][1],
            child: Draggable(
              child: Container(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.hue),
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
                  ),
                ),
                width: (MediaQuery.of(context).size.width - 20),
                height: (MediaQuery.of(context).size.width - 20),
              ),
              feedback: Container(
                width: (MediaQuery.of(context).size.width - 20),
                height: (MediaQuery.of(context).size.width - 20),
                decoration: BoxDecoration(color: CupertinoColors.white),
              ),
              childWhenDragging: Container(),
              onDragEnd: (dragDetails) {
                setState(() {
                  firstLoad = false;
                  coords[1][0] = (dragDetails.offset.dx);
                  coords[1][1] = (MediaQuery.of(context).size.height -
                          dragDetails.offset.dy) -
                      (MediaQuery.of(context).size.width - 20) -
                      53;
                });
              },
            ),
          ),
        ],
      ),
    ));
  }
}
