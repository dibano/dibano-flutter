import 'package:dibano/ui/view_model/components/farm_box.dart';
import 'package:flutter/material.dart';

class FarmBox extends StatelessWidget {
  const FarmBox({super.key, required this.box});

  final FarmContent box;

  @override
  Widget build(BuildContext context) {
    const iconSize = 60.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
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
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(box.icon, size: iconSize, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  box.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
