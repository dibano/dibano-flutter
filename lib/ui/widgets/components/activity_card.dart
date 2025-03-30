import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/ui/view_model/components/activity_card.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    super.key,
    required this.workstep,
    this.onTap,
    this.onDelete,
    this.isCheckable = false,
    this.isDeletable = false,
  });

  final CompleteWorkstep workstep;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isCheckable;
  final bool isDeletable;

  @override
  ActivityCardState createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  bool checkboxState = false;
  @override
  Widget build(BuildContext context) {
    Activity activity = Activity(
      description: widget.workstep.description,
      fieldName: widget.workstep.fieldName,
      cropName: widget.workstep.cropName,
      activityName: widget.workstep.activityName,
      date: DateTime.tryParse(widget.workstep.date)!,
    );
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
                  if (widget.isCheckable)
                    Checkbox(
                      value: checkboxState,
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkboxState = newValue ?? false;
                        });
                      },
                    ),
                  Icon(Icons.edit),
                  if (widget.isDeletable)
                    IconButton(
                      onPressed: () async {
                        bool? confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              alertText:
                                  "Möchtest du diesen Eintrag wirklich löschen?",
                              alertType: AlertType.delete,
                              onDelete: () async {
                                widget.onDelete!();
                              },
                            );
                          },
                        );
                        if (confirmDelete == true) {
                          Navigator.pop(context, true);
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
