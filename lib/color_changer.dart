import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_custom_controller/color_changer_controller.dart';


class ColorChanger extends StatefulWidget {
  ColorChanger({
    @required this.controller,
  });

  final ColorChangerController controller;

  @override
  _ColorChangerState createState() => _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Color currentColor;
  Animation<Color> colorAnimation;

  @override
  void initState() {
    widget.controller.color = _getRandomColor();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this
    );

    widget.controller.addListener(() {
      if (widget.controller.shouldStartAnimation && !widget.controller.isAnimating)
        _startAnimation();
    });

    super.initState();
  }

  void _startAnimation() {
    Color nextColor = _getRandomColor();

    colorAnimation = ColorTween(
      begin: widget.controller.color,
      end: nextColor
    ).animate(_animationController);

    widget.controller.shouldStartAnimation = false;
    widget.controller.isAnimating = true;

    _animationController.reset();
    _animationController.forward();

    colorAnimation.addListener(() {
      widget.controller.color = colorAnimation.value;
      widget.controller.setValue(_animationController.value);

      if (colorAnimation.isCompleted) {
        widget.controller.isAnimating = false;
      }
    });
  }

  Color _getRandomColor() => Color(
    (Random().nextDouble() * 0xFFFFFF).toInt()
  ).withOpacity(1.0);

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}