import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nure_schedule/pages/groups.dart';
import 'package:nure_schedule/pages/home.dart';
import 'package:nure_schedule/pages/splash.dart';
import 'package:nure_schedule/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

String appName = 'ScheduleNure';

log(String className, String method, [String message]) {
  print('${DateTime.now()} [$className][${method ?? ''}] ${message ?? ''}');
}

class MyApp extends StatelessWidget {
  final MainModel model = MainModel();
  void forcePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    forcePortrait();

    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            display1: TextStyle(color: Color(0xffaaaaaa)),
            body1: TextStyle(color: Color(0xff333333)),
            body2: TextStyle(fontSize: 12, color: Color(0xffaaaaaa)),
          ),
          accentTextTheme: TextTheme(
            display1: TextStyle(color: Color(0xffeeeeee)),
          ),
        ),
        home: SplashPage(),
        routes: {
          '/home': (BuildContext context) => HomePage(),
          '/groups': (BuildContext context) => GroupsPage(),
        },
      ),
    );
  }
}
