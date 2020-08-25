// import 'package:flutter/material.dart';

// class TextUnderline extends StatelessWidget {
//   final String text;
//   final List underline;
//   const TextUnderline({
//     Key key,
//     @required this.text,
//     @required this.underline,
//   }) : super(key: key);
//   Widget makeUnderline(String text, List underline) {
//     if (underline.length == 1) {
//       String textUnderline = underline[0];
//       int index = text.indexOf(textUnderline);
//       return Future<void> _showMyDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('This is a demo alert dialog.'),
//               Text('Would you like to approve of this message?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('Approve'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return makeUnderline(text, underline);
//   }
// }
