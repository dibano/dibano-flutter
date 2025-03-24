import 'package:dibano/ui/view_model/components/farm_box.dart';
import 'package:flutter/material.dart';

class FarmBox extends StatelessWidget {
  const FarmBox({super.key, required this.box});

  final FarmContent box;

  @override
  Widget build(BuildContext context) {
    const iconSize = 60.0;
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => box.routeWidget!),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: box.color,
          padding: const EdgeInsets.all(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(box.icon, size: iconSize),
            const SizedBox(height: 8),
            Text(box.title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
