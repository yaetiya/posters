import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getEditable(widgetChild, changer, context) {
  return GestureDetector(
    child: widgetChild,
    onDoubleTap: () {
      TextEditingController localController = TextEditingController();
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Edit this text"),
            content: Center(
              child: CupertinoTextField(
                controller: localController,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Ok'),
                onPressed: () {
                  changer(localController);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
