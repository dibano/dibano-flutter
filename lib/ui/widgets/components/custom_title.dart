import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;

  const CustomTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 24, color: FarmColors.darkGreenIntense),
    );
  }
}
