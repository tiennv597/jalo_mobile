import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/splash_screen.dart';
import 'network/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: MaterialApp(
        title: 'Japanese Love Me',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat",
        ),
        home: SplashScreen(),
      ),
    );
  }
}
