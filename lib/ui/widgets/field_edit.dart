import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:dibano/ui/widgets/components/form_numberfield.dart';
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

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          alertText:
              "Sie können hier ein Feld erfassen. Geben Sie einen Feldnamen ein. Anschliessend können Sie entweder einfach die grösse des Feldes eintragen, oder sie können über \"Karte anzeigen\" anschliessend auf ein Feld klicken. Die grösse wird dann automatisch erfasst und kann bei bedarf noch angepasst werden.",
          alertType: AlertType.info,
        );
      },
    );
  }


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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if(!didPop){
          showDialog(
            context: context,
            builder:
                (context) => CustomAlertDialog(
                  alertText:
                      "Möchten Sie die Seite verlassen, ohne zu speichern?",
                  alertType: AlertType.shouldLeave,
                  onDelete: () {
                    Navigator.of(context).pop();
                  },
                ),
          );
        }
      },

      child: Scaffold(
        appBar: CustomAppBar(
          title: title, 
          messageOnLeave: true,
          hasInfo: true,
          onInfoPressed: () => _showInfoDialog(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<FieldsViewModel>(
            builder: (context, fieldsViewModel, child) {
              double? lastLatitude;
              double? lastLongitude;
              if(fieldsViewModel.fieldCoordinates.isNotEmpty){
                lastLatitude = fieldsViewModel.fieldCoordinates.last["latitude"];
                lastLongitude = fieldsViewModel.fieldCoordinates.last["longitude"];
              }
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
                                Expanded(
                                  child: FormNumberField(
                                    label: "Feldgrösse in ha",
                                    controller: _fieldSizeController,
                                    maxLine: 1,
                                    onChanged: (value){ 
                                      final replacedValue = value.replaceAll(',', '.');
                                      _fieldSizeController.text = replacedValue;
                                      _fieldSizeController.selection = TextSelection.fromPosition(TextPosition(offset: replacedValue.length),);
                                    }

                                  ),
                                ),
                                if(lastLatitude != null && lastLongitude != null && lastLatitude != 0 && lastLongitude != 0)...{
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          FarmColors.darkGreenIntense,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 12.0,
                                      ),
                                    ),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => FieldMap(
                                                geoAdminLayer:
                                                    'ch.blw.landwirtschaftliche-nutzungsflaechen',
                                                    latitude: fieldsViewModel.fieldCoordinates.last["latitude"],
                                                    longitude: fieldsViewModel.fieldCoordinates.last["longitude"],
                                
                                              ),
                                        ),
                                      );
                                      if (result != null) {
                                        longitude =
                                            result['longitude'].toString();
                                        latitude = result['latitude'].toString();
                                        fieldSize =
                                            result['flaecheHa'].toString();
                                        _fieldSizeController.text = fieldSize;
                                      }
                                  },
                                    child: const Text('Karte anzeigen'),
                                  ),
                                }else...{
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          FarmColors.darkGreenIntense,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 12.0,
                                      ),
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
                                        longitude =
                                            result['longitude'].toString();
                                        latitude = result['latitude'].toString();
                                        fieldSize =
                                            result['flaecheHa'].toString();
                                        _fieldSizeController.text = fieldSize;
                                      }
                                  },
                                    child: const Text('Karte anzeigen'),
                                  ),
                                }
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
      ),
    );
  }
}
