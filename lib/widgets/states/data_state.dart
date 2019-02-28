import 'package:flutter/material.dart';

part 'load_data_helper.dart';
part 'send_data_helper.dart';

abstract class DataState<TWidget extends StatefulWidget> extends State<TWidget> {
  String _errorText;

  bool get hasError => _errorText != null;
  String get errorText => _errorText;
}
