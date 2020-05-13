import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: SizedBox.expand(child: RadialMenu())),
    );
  }
}

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  RadialAnimation({this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Stack(alignment: Alignment.center, children: [
          FloatingActionButton(
            onPressed: _close,
            child: Icon(FontAwesomeIcons.timesCircle),
            backgroundColor: Colors.red,
          ),
          FloatingActionButton(
            onPressed: _open,
            child: Icon(FontAwesomeIcons.solidDotCircle),
          )
        ]);
      },
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
