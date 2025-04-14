import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:dibano/ui/widgets/GeoAdminViewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FieldEdit extends StatelessWidget {
  FieldEdit({
    super.key,
    required this.title,
    this.fieldName = "",
    this.fieldId,
    this.isCreate = false,
  });

  final String title;
  final String fieldName;
  final int? fieldId;
  bool isCreate;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = fieldName;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<FieldsViewModel>(
          builder: (context, fieldsViewModel, child) {
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
                              shape: CircleBorder(),
                              elevation: 2,
                              padding: const EdgeInsets.all(8.0),
                            ),
                            onPressed: () async {
                              bool? confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Möchtest du dieses Feld wirklich löschen?",
                                    alertType: AlertType.delete,
                                    onDelete: () async {
                                      await fieldsViewModel.remove(fieldId!);
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
                            label: "Feldname",
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
                            final fieldExisting = fieldsViewModel
                                .checkIfExisting(_descriptionController.text);
                            if (_descriptionController.text != "" &&
                                fieldExisting == false) {
                              if (fieldId == null) {
                                await fieldsViewModel.addField(
                                  _descriptionController.text,
                                );
                                Navigator.pop(context, true);
                              } else {
                                await fieldsViewModel.update(
                                  fieldId!,
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
                                fieldExisting == true) {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    alertText:
                                        "Du hast dieses Feld bereits erfasst",
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
                                        "Der Feldname muss ausgefüllt sein!",
                                    alertType: AlertType.error,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      //TEST
                      // Innerhalb deines Row-Widgets, z. B. bei deinen Buttons:
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FieldMap(geoAdminLayer: 'ch.blw.landwirtschaftliche-nutzungsflaechen')),
                          );
                        },
                        child: const Text('Karte anzeigen'),
                      ),
                    Text("© Data: swisstopo"),
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
