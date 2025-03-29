import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/ui/view_model/components/activity_card.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({super.key, required this.workstep, this.onTap, this.onDelete});

  final CompleteWorkstep workstep;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  ActivityCardState createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    Activity activity = Activity(description: widget.workstep.description, fieldName: widget.workstep.fieldName, cropName: widget.workstep.cropName, activityName: widget.workstep.activityName, date: DateTime.tryParse(widget.workstep.date)!);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: widget.onTap,
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
                    activity.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.edit),
                IconButton(
                  onPressed: () {
                    if(widget.onDelete != null){
                      widget.onDelete!();
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
