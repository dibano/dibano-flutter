import 'package:flutter/widgets.dart';

class Detail {
  final String name;
  final String? description;
  final Widget? routeWidget;
  final bool isInfo;

  Detail({
    required this.name,
    this.description,
    this.routeWidget,
    this.isInfo = false,
  });
}
