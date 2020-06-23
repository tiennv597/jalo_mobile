import 'package:flutter/material.dart';

const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentPurple = Color.fromRGBO(205, 0, 205, 0.7);
const Color transparentWhite = Color.fromRGBO(198, 255, 254, 0.7);
const Color darkGrey = Color(0xff202020);
const Color purple = Color(0xff202020);

const Color blueTypeOne = Color(0xff009966);
const Color whiteTypeOne = Color(0xFFFFFF);
const Color blueTypeTwo = Color(0xff669966);
const Color blueTypeThree = Color(0xFF33FF);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(60, 150, 90, 1),
  Color.fromRGBO(60, 150, 90, 1),
  Color.fromRGBO(60, 205, 170, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
