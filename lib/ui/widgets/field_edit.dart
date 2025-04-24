import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:dibano/ui/widgets/GeoAdminViewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FieldEdit extends StatelessWidget {
  FieldEdit({
    super.key,
    required this.title,
    this.fieldName = "",
    this.fieldSize = "",
    this.latitude = "",
    this.longitude = "",
    this.fieldId,
    this.isCreate = false,
  });

  final String title;
  String fieldName;
  String fieldSize;
  String latitude;
  String longitude;
  int? fieldId;
  bool isCreate;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fieldSizeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    /*String? _longitude = longitude;
    String? _latitude = latitude;*/
    String? actualFieldName = fieldName;
    _descriptionController.text = fieldName;
    _fieldSizeController.text = fieldSize;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

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
                            focusNode: _focusNode,
                          ),
                          Row(
                            children: [
                              FormTextfield(
                                label: "Feldgrösse in ha",
                                controller: _fieldSizeController,
                                keyboardType: TextInputType.number,
                                maxLine: 1,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FarmColors.darkGreenIntense,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => FieldMap(
                                            geoAdminLayer:
                                                'ch.blw.landwirtschaftliche-nutzungsflaechen',
                                          ),
                                    ),
                                  );
                                  if (result != null) {
                                    longitude = result['longitude'].toString();
                                    latitude = result['latitude'].toString();
                                    fieldSize = result['flaecheHa'].toString();
                                    _fieldSizeController.text = fieldSize;
                                  }
                                },
                                child: const Text('Karte anzeigen'),
                              ),
                            ],
                          ),
                          Text("Daten: © geo.admin.ch"),
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
                                _fieldSizeController.text != "" &&
                                (fieldExisting == false ||
                                    actualFieldName ==
                                        _descriptionController.text)) {
                              if (fieldId == null) {
                                await fieldsViewModel.addField(
                                  _descriptionController.text,
                                  _fieldSizeController.text,
                                  longitude,
                                  latitude,
                                );
                                Navigator.pop(context, true);
                              } else {
                                await fieldsViewModel.update(
                                  fieldId!,
                                  _descriptionController.text,
                                  _fieldSizeController.text,
                                  longitude,
                                  latitude,
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
                                _fieldSizeController.text != "" &&
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
                                        "Alle Felder müssen ausgefüllt sein!",
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
