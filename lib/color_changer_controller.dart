import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColorChangerController extends ChangeNotifier {
  double value = 0.0;
  Color color = Colors.transparent;
  bool isAnimating = false;
  bool shouldStartAnimation = false;

  void setValue(double value) {
    this.value = value;
    notifyListeners();
  }

  void changeColor() {
    this.shouldStartAnimation = true;
    notifyListeners();
  }
}