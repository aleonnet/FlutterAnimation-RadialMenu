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
  final Animation<double> scale;
  final Animation<double> translation;

  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _buildButton(0,
                color: Colors.red, icon: FontAwesomeIcons.thumbtack),
            _buildButton(45,
                color: Colors.green, icon: FontAwesomeIcons.sprayCan),
            _buildButton(90, color: Colors.orange, icon: FontAwesomeIcons.fire),
            _buildButton(135,
                color: Colors.blue, icon: FontAwesomeIcons.kiwiBird),
            _buildButton(180, color: Colors.black, icon: FontAwesomeIcons.cat),
            _buildButton(225, color: Colors.indigo, icon: FontAwesomeIcons.paw),
            _buildButton(270, color: Colors.pink, icon: FontAwesomeIcons.bong),
            _buildButton(315,
                color: Colors.yellow, icon: FontAwesomeIcons.bolt),
            Transform.scale(
              scale: scale.value - 1.5,
              child: FloatingActionButton(
                onPressed: _close,
                child: Icon(FontAwesomeIcons.timesCircle),
                backgroundColor: Colors.red,
              ),
            ),
            Transform.scale(
              scale: scale.value,
              child: FloatingActionButton(
                onPressed: _open,
                child: Icon(FontAwesomeIcons.solidDotCircle),
              ),
            ),
          ],
        );
      },
    );
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
            (translation.value) * cos(rad), (translation.value) * sin(rad)),
      child: FloatingActionButton(
        onPressed: _close,
        child: Icon(icon),
        backgroundColor: color,
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
