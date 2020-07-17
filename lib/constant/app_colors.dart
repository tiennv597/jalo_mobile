import 'package:flutter/material.dart';

///https://api.flutter.dev/flutter/material/Colors-class.html
//import 'package:shinro_int2/constant/app_colors.dart' as COLORS;

const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentPurple = Color.fromRGBO(205, 0, 205, 0.7);
const Color transparentWhite = Color.fromRGBO(198, 255, 254, 0.7);

const Color white = Colors.white;
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

//green  colors constant
const Color green50 = Color(0xFFE8F5E9);
const Color green100 = Color(0xFFC8E6C9);
const Color green200 = Color(0xFFA5D6A7);
const Color green300 = Color(0xFF81C784);
const Color green400 = Color(0xFF66BB6A);
const Color green500 = Colors.green;
const Color green600 = Color(0xFF43A047);
const Color green700 = Color(0xFF388E3C);
const Color green800 = Color(0xFF2E7D32);
const Color green900 = Color(0xFF1B5E20);

//cyan colors constant
const Color cyan50 = Color(0xFFE0F7FA);
const Color cyan100 = Color(0xFFB2EBF2);
const Color cyan200 = Color(0xFF80DEEA);
const Color cyan300 = Color(0xFF4DD0E1);
const Color cyan400 = Color(0xFF26C6DA);
const Color cyan500 = Colors.cyan;
const Color cyan600 = Color(0xFF00ACC1);
const Color cyan700 = Color(0xFF0097A7);
const Color cyan800 = Color(0xFF00838F);
const Color cyan900 = Color(0xFF006064);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(60, 150, 90, 1),
  Color.fromRGBO(60, 150, 90, 1),
  Color.fromRGBO(60, 205, 170, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

const LinearGradient colorOrange = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[
    Color(0xFFFFA726),
    Color(0xFFFB8C00),
    Color(0xFFF57C00),
  ],
);
const LinearGradient colorBlue = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[
    Color(0xFF42A5F5),
    Color(0xFF1E88E5),
    Color(0xFF1976D2),
  ],
);
const LinearGradient colorGreen = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[
    Color(0xFF66BB6A),
    Color(0xFF43A047),
    Color(0xFF388E3C),
  ],
);
const LinearGradient colorPurple = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[
    Color(0xFFAB47BC),
    Color(0xFF8E24AA),
    Color(0xFF7B1FA2),
  ],
);

const RadialGradient colorBlue2 = RadialGradient(
  colors: <Color>[
    Color(0xFF42A5F5),
    Color(0xFF1E88E5),
    Color(0xFF1976D2),
  ],
);

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
