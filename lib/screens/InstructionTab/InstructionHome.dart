import 'package:art/components/textParagraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructionHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Instruction'),
        ),
        child: Column(
          children: <Widget>[
            textParagraph('...Moving...',
                'Drag and drop the element for moving. On some posters you can move only blocks, but in other posters texts are moveable too.'),
            textParagraph('...Editing...',
                'Use double tap for editing the element. You can edit images and text on every poster.'),
          ],
        ));
  }
}
