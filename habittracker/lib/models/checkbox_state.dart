import 'package:flutter/material.dart';

class HabitModel extends ChangeNotifier {
  bool _isChecked;

  HabitModel({bool isCompleted = false}) : _isChecked = isCompleted;

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}
