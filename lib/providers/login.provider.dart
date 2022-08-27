import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

}