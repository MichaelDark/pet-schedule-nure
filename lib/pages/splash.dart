import 'package:flutter/material.dart';
import 'package:nure_schedule/scoped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScopedModel.of<MainModel>(context).initModel().then((_) {
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
