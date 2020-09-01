import 'dart:io';

import 'package:art/components/horizontalBackgroundLine.dart';
import 'package:art/components/verticalBackgroundLine.dart';
import 'package:art/configs/Palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class Collage extends StatefulWidget {
  final imageBg;
  final int oneLine;
  final d;
  const Collage({
    Key key,
    this.d,
    this.oneLine,
    this.imageBg,
  }) : super(key: key);
  @override
  _CollageState createState() => _CollageState();
}

class _CollageState extends State<Collage> {
  double bgWidth = Random().nextInt(300).toDouble() + 10;
  double leftBgOff = Random().nextInt(300).toDouble();
  double bgHeight = Random().nextInt(400).toDouble() + 10;
  double topBgOff = Random().nextInt(300).toDouble();

  Color bgColor = defaultColorsList[Random().nextInt(defaultColorsList.length)];
  String bigText;
  String descrText;
  String leadText;
  String topText;

  List coords = [];
  bool firstLoad;
  List<File> _image;
  final picker = ImagePicker();

  Future getImage(i) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image[i] = File(pickedFile.path);
    });
  }

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
    _image = List.generate(widget.d, (index) => null);
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      firstLoad = false;
      setState(() {
        coords[0][1] = MediaQuery.of(context).size.width;
        coords[2][1] = MediaQuery.of(context).size.width + 46;
        // coords[3][1] = MediaQuery.of(context).size.width + 76;
      });
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
          (widget.imageBg != null)
              ? (Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image(
                    image: widget.imageBg,
                    fit: BoxFit.cover,
                  ),
                ))
              : (horizontalBackgroundLine(bgColor)),
          (widget.imageBg != null)
              ? (SizedBox())
              : (verticalBackgroundLine(bgColor)),
          Center(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisCount: widget.oneLine,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    for (var i = 0; i < widget.d; i++)
                      GestureDetector(
                        child: (_image[i] == null)
                            ? (Image(
                                image: AssetImage("assets/qr.png"),
                                fit: BoxFit.cover,
                              ))
                            : (Image.file(
                                _image[i],
                                fit: BoxFit.cover,
                              )),
                        onDoubleTap: () {
                          getImage(i);
                        },
                      )
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          )
        ],
      ),
    );
  }
}
