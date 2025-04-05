import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonEdit extends StatelessWidget {
  PersonEdit({
    super.key,
    required this.title,
    this.personName = "",
    this.personId,
    this.isCreate = false,
  });

  final String title;
  final String personName;
  final int? personId;
  bool isCreate;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = personName;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<PersonViewModel>(
          builder: (context, personViewModel, child) {
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
                              bool? confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Möchtest du diesen Mitarbeiter wirklich löschen?",
                                    alertType: AlertType.delete,
                                    onDelete: () async {
                                      await personViewModel.remove(personId!);
                                      Navigator.pop(context, true);
                                    },
                                  );
                                },
                              );
                              if (confirmDelete == true) {
                                Navigator.pop(context, true);
                              }
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
                            label: "Name des Mitarbeiters",
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
                            final personExisting = personViewModel
                                .checkIfExisting(_descriptionController.text);
                            if (_descriptionController.text != "" &&
                                personExisting == false) {
                              if (personId == null) {
                                await personViewModel.add(
                                  _descriptionController.text,
                                );
                                Navigator.pop(context, true);
                              } else {
                                await personViewModel.update(
                                  personId!,
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
                                personExisting == true) {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Du hast diese Person bereits erfasst",
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
                                        "Der Personenname muss ausgefüllt sein!",
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
