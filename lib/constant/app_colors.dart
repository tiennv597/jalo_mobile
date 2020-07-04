import 'package:flutter/material.dart';
//https://api.flutter.dev/flutter/material/Colors-class.html
//import 'package:shinro_int2/constant/app_colors.dart' as COLORS;

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

//colors style 1
const Color tiColor11 = Color(0xffFCE183);
const Color tiColor12 = Color(0xffF68D7F);

//colors style 2
const Color tiColor21 = Color(0xff00E9DA);
const Color tiColor22 = Color(0xff5189EA);

//colors style 3
const Color tiColor31 = Color(0xffF749A2);
const Color tiColor32 = Color(0xffFF7375);

//colors style 4
const Color tiColor41 = Color(0xffAF2D68);
const Color tiColor42 = Color(0xff632376);

//colors style 5
const Color tiColor51 = Color(0xff36E892);
const Color tiColor52 = Color(0xff33B2B9);

//colors style 6
const Color tiColor61 = Color(0xffF123C4);
const Color tiColor62 = Color(0xff668CEA);

//teal colors constant

const Color teal50 = Color(0xFFE0F2F1);
const Color teal100 = Color(0xFFB2DFDB);
const Color teal200 = Color(0xFF80CBC4);
const Color teal300 = Color(0xFF4DB6AC);
const Color teal400 = Color(0xFF26A69A);
const Color teal500 = Colors.teal;
const Color teal600 = Color(0xFF00897B);
const Color teal700 = Color(0xFF00796B);
const Color teal800 = Color(0xFF00695C);
const Color teal900 = Color(0xFF004D40);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(60, 150, 90, 1),
  Color.fromRGBO(60, 150, 90, 1),
  Color.fromRGBO(60, 205, 170, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

const LinearGradient colorOrange = LinearGradient(
  colors: <Color>[
    Color(0xFFFFA726),
    Color(0xFFFB8C00),
    Color(0xFFF57C00),
  ],
);
const LinearGradient colorBlue = LinearGradient(
  colors: <Color>[
    Color(0xFF42A5F5),
    Color(0xFF1E88E5),
    Color(0xFF1976D2),
  ],
);
const LinearGradient colorGreen = LinearGradient(
  colors: <Color>[
    Color(0xFF66BB6A),
    Color(0xFF43A047),
    Color(0xFF388E3C),
  ],
);
const LinearGradient colorPurple = LinearGradient(
  colors: <Color>[
    Color(0xFFAB47BC),
    Color(0xFF8E24AA),
    Color(0xFF7B1FA2),
  ],
);

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
