import 'package:art/components/inputComponentPoster.dart';
import 'package:art/screens/RandomTab/ArtHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../configs/Palette.dart';

class RandomPosterHome extends StatefulWidget {
  @override
  _RandomPosterHomeState createState() => _RandomPosterHomeState();
}

class _RandomPosterHomeState extends State<RandomPosterHome> {
  List<String> headligs = [
    "Largest headline (5-12 symbols)",
    "Medium headline (8-17 symbols)",
    'Heading (8-17 symbols)',
    'Small heading (<6 symbols)'
  ];
  List<TextEditingController> controller;
  @override
  void initState() {
    super.initState();
    controller = List.generate(4, (i) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Random generator"),
        ),
        child: Scaffold(
            backgroundColor: CupertinoColors.black,
            body: CupertinoScrollbar(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      for (var i = 0; i < 4; i++)
                        inputComponentPoster(headligs[i], controller[i]),
                      FlatButton(
                        child: Text(
                          '...Generate...',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              backgroundColor: mainThemeColor,
                              fontFamily: "RedRose",
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return ArtHome(
                                controlls: controller,
                              );
                            },
                          ));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
