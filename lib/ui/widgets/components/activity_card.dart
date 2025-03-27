import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/ui/view_model/components/activity_card.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({super.key, required this.workstep});

  final CompleteWorkstep workstep;

  @override
  ActivityCardState createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  bool checkboxState = false;
  @override
  Widget build(BuildContext context) {
    Activity activity = Activity(description: widget.workstep.description, fieldName: widget.workstep.fieldName, cropName: widget.workstep.cropName, activityName: widget.workstep.activityName, date: DateTime.tryParse(widget.workstep.date)!);
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
                    activity.toString(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TrackWorksteps(
                              title: "Aktivität bearbeiten", 
                              selectedArea: widget.workstep.id.toString(), 
                              selectedActivity: widget.workstep.activityId.toString(), 
                              selectedPerson: widget.workstep.personId.toString(), 
                              description: widget.workstep.description, 
                              workstepActivityId: widget.workstep.workstepActivityId, 
                              workstepId: widget.workstep.workstepId, 
                              activityDate: DateTime.tryParse(widget.workstep.date)),
                      ),
                    );
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
