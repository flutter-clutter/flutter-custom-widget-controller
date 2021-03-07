import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_controller/color_changer.dart';
import 'package:flutter_custom_controller/color_changer_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter custom controller demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorChangerTest(),
    );
  }
}

class ColorChangerTest extends StatefulWidget {
  @override
  _ColorChangerTestState createState() => _ColorChangerTestState();
}

class _ColorChangerTestState extends State<ColorChangerTest> {
  ScrollController textEditingController = ScrollController();
  ColorChangerController controller = ColorChangerController();
  int value = 0;
  Color? color = Colors.transparent;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        value = (controller.value * 100).round();
        color = controller.color;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColorChanger(
              controller: controller
            ),
            SizedBox(height: 8,),
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: color,
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color,
                  ),
                ),
                Transform.rotate(
                  angle: 0.25 * pi,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Text(
              'Now we can make every widget inherit this color animation',
              style: TextStyle(
                color: this.color
              ),
            ),
            SizedBox(height: 8,),
            Container(
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color?>(color),
                value: value.toDouble() / 100,
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(
              value < 100 ? '$value %' : 'Done',
              style: TextStyle(
                  color: this.color
              ),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () => controller.changeColor(),
              child: Text('Animate'),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => color!)
              ),
            )
          ],
        ),
      ),
    );
  }
}