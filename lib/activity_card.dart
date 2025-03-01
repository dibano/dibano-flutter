import 'package:flutter/material.dart';
import 'package:dibano/activity.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({super.key, required this.activity});

  final Activity activity;

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool checkboxState = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.activity.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Checkbox(
                  value: checkboxState,
                  onChanged: (bool? newValue) {
                    setState(() {
                      checkboxState = newValue ?? false;
                    });
                  },
                ),
                IconButton(
                  onPressed: () {
                    // To do: Handle button press
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
