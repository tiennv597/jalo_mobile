import 'package:flutter/material.dart';

class TextUnderline extends StatelessWidget {
  final String text;
  final List underline;
  const TextUnderline({
    Key key,
    @required this.text,
    @required this.underline,
  }) : super(key: key);
  Widget makeUnderline(String text, List underline) {
    if (underline.length == 1) {
      String textUnderline = underline[0];
      int index = text.indexOf(textUnderline);
      return SelectableText.rich(
        TextSpan(
          text: text.substring(0, index),
          style: TextStyle(fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: textUnderline,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                )),
            TextSpan(
              text: text.substring(index + textUnderline.length),
            ),
            // can add more TextSpans here...
          ],
        ),
      );
    } else {
      return Text(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return makeUnderline(text, underline);
  }
}
