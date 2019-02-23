import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nure_schedule/pages/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void forcePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    forcePortrait();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nure Schedule',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          display1: TextStyle(
            color: Color(0xffaaaaaa),
          ),
          body1: TextStyle(
            color: Color(0xff333333),
          ),
        ),
        accentTextTheme: TextTheme(
          display1: TextStyle(
            color: Color(0xffeeeeee),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
