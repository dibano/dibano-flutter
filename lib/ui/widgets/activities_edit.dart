import 'package:dibano/ui/view_model/activities.dart';
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
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              activitiesViewModel.remove(activityId!);
                              Navigator.pop(context);
                            },
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
                            if (activityId == null) {
                              activitiesViewModel.add(
                                _descriptionController.text,
                              );
                            } else {
                              activitiesViewModel.update(
                                activityId!,
                                _descriptionController.text,
                              );
                            }
                            Navigator.pop(context);
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
