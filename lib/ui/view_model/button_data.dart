import 'package:flutter/widgets.dart';

class ButtonData {
  final IconData icon;
  final String title;
  final Widget routeWidget;
  final Color? color;

  ButtonData({
    required this.icon,
    required this.title,
    required this.routeWidget,
    this.color,
  });
}
