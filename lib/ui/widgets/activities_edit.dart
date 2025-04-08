import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiesEdit extends StatelessWidget {
  ActivitiesEdit({
    super.key,
    required this.title,
    this.activityName = "",
    this.activityId,
    this.isCreate = false,
  });

  final String title;
  final String activityName;
  final int? activityId;
  bool isCreate;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = activityName;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ActivitiesViewModel>(
          builder: (context, activitiesViewModel, child) {
            return Center(
              child: Column(
                children: <Widget>[
                  if (!isCreate)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: const CircleBorder(),
                              elevation: 2,
                              padding: const EdgeInsets.all(8.0),
                            ),
                            onPressed: () async {
                              bool? confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Möchtest du diese Aktivität wirklich löschen?",
                                    alertType: AlertType.delete,
                                    onDelete: () async {
                                      await activitiesViewModel.remove(
                                        activityId!,
                                      );
                                      Navigator.pop(context, true);
                                    },
                                  );
                                },
                              );
                              if (confirmDelete == true) {
                                Navigator.pop(context, true);
                              }
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 24),
                          FormTextfield(
                            label: "Name der Aktivität",
                            controller: _descriptionController,
                            keyboardType: TextInputType.text,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: CustomButtonLarge(
                          text: "Speichern",
                          onPressed: () async {
                            final activityExisting = activitiesViewModel
                                .checkIfExisting(_descriptionController.text);
                            if (_descriptionController.text != "" &&
                                activityExisting == false) {
                              if (activityId == null) {
                                await activitiesViewModel.add(
                                  _descriptionController.text,
                                );
                                Navigator.pop(context, true);
                              } else {
                                await activitiesViewModel.update(
                                  activityId!,
                                  _descriptionController.text,
                                );
                                Navigator.pop(context, true);
                              }
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    alertText: "Erfolgreich gespeichert!",
                                    alertType: AlertType.success,
                                  );
                                },
                              );
                            } else if (_descriptionController.text != "" &&
                                activityExisting == true) {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Du hast diese Aktivität bereits erfasst",
                                    alertType: AlertType.error,
                                  );
                                },
                              );
                            } else {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Der Aktivitätenname muss ausgefüllt sein!",
                                    alertType: AlertType.error,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
