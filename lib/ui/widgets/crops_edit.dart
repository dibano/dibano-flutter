import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_date.dart';
import 'package:dibano/ui/widgets/components/form_dropdown.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/field_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropsEdit extends StatefulWidget {
  const CropsEdit({
    super.key,
    required this.title,
    this.cropName = "",
    this.cropId,
    this.startDate,
    this.fieldId,
    this.endDate,
    this.cropDateId,
    this.isCreate = false,
  });

  final String title;
  final String cropName;
  final int? cropId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? fieldId;
  final int? cropDateId;
  final bool isCreate;

  @override
  State<CropsEdit> createState() => _CropsEditState();
}

class _CropsEditState extends State<CropsEdit> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    Provider.of<FieldsViewModel>(context, listen: false).getFields();

    setState(() {
      _startDate = widget.startDate;
      _endDate = widget.endDate;
      _selectedField = widget.fieldId?.toString() ?? "-1";
      _descriptionController.text = widget.cropName;
    });
  }

  String? _selectedField = "-1";
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
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
      },

      child: Scaffold(
        appBar: CustomAppBar(title: widget.title, messageOnLeave: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<CropsViewModel>(
            builder: (context, cropsViewModel, child) {
              return Center(
                child: Column(
                  children: <Widget>[
                    if (!widget.isCreate)
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
                                          "Möchtest du diese Kultur wirklich löschen?",
                                      alertType: AlertType.delete,
                                      onDelete: () async {
                                        await cropsViewModel.remove(
                                          widget.cropId!,
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
                              label: "Kulturname",
                              controller: _descriptionController,
                              keyboardType: TextInputType.text,
                              focusNode: _focusNode,
                              maxLine: 1,
                            ),
                            FormDate(
                              label: "Startdatum",
                              placeholderDate: _startDate ?? DateTime.now(),
                              dateSelected: (date) {
                                setState(() => _startDate = date);
                              },
                            ),
                            FormDate(
                              label: "Enddatum",
                              placeholderDate: _endDate ?? DateTime.now(),
                              dateSelected: (date) {
                                setState(() => _endDate = date);
                              },
                            ),
                            Consumer<FieldsViewModel>(
                              builder: (context, fieldsViewModel, child) {
                                return FormDropdown(
                                  label: "Feld",
                                  value: _selectedField!,
                                  createNewView: FieldEdit(
                                    title: "Feld erstellen",
                                    isCreate: true,
                                  ),
                                  onCreateNew: (context) async {
                                    await Provider.of<FieldsViewModel>(
                                      context,
                                      listen: false,
                                    ).getFields();
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: "-1",
                                      child: Text("Ort wählen"),
                                    ),
                                    ...fieldsViewModel.fields.map(
                                      (field) => DropdownMenuItem(
                                        value: field.id.toString(),
                                        child: Text(field.fieldName),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(
                                      () => _selectedField = value ?? "",
                                    );
                                  },
                                );
                              },
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
                              if (_descriptionController.text != "" &&
                                  _selectedField != null &&
                                  _selectedField != "-1") {
                                if (widget.cropId == null) {
                                  final inExistingDate = cropsViewModel
                                      .existingCropAtDateAndField(
                                        int.parse(_selectedField.toString()),
                                        _startDate ?? DateTime.now(),
                                        _endDate ?? DateTime.now(),
                                        widget.cropId,
                                      );
                                  final endIsBeforeStart = cropsViewModel
                                      .endIsBeforeStart(
                                        _startDate ?? DateTime.now(),
                                        _endDate ?? DateTime.now(),
                                      );
                                  if (endIsBeforeStart == true) {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          alertText:
                                              "Das Startdatum darf nicht nach dem Enddatum sein.",
                                          alertType: AlertType.error,
                                        );
                                      },
                                    );
                                  } else if (inExistingDate != true) {
                                    int? fieldId = int.tryParse(
                                      _selectedField!,
                                    ); // Konvertiert String zu int
                                    await cropsViewModel.add(
                                      _descriptionController.text,
                                      _startDate ?? DateTime.now(),
                                      _endDate ?? DateTime.now(),
                                      fieldId!,
                                    );
                                    Navigator.pop(context, true);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          alertText: "Erfolgreich gespeichert!",
                                          alertType: AlertType.success,
                                        );
                                      },
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          alertText:
                                              "Auf diesem Feld gibt es zu diesem Datum bereits eine Kultur. Wählen Sie ein anderes Feld oder ein anderes Datum",
                                          alertType: AlertType.error,
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  final inExistingDate = cropsViewModel
                                      .existingCropAtDateAndField(
                                        int.parse(_selectedField.toString()),
                                        _startDate ?? DateTime.now(),
                                        _endDate ?? DateTime.now(),
                                        widget.cropId,
                                      );
                                  final endIsBeforeStart = cropsViewModel
                                      .endIsBeforeStart(
                                        _startDate ?? DateTime.now(),
                                        _endDate ?? DateTime.now(),
                                      );
                                  if (inExistingDate != true) {
                                    int? fieldId = int.tryParse(
                                      _selectedField!,
                                    ); // Konvertiert String zu int
                                    await cropsViewModel.update(
                                      _descriptionController.text,
                                      _startDate!,
                                      _endDate!,
                                      fieldId!,
                                      widget.cropId!,
                                      widget.cropDateId!,
                                    );
                                    Navigator.pop(context, true);
                                  } else if (endIsBeforeStart == true) {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          alertText:
                                              "Das Startdatum darf nicht nach dem Enddatum sein.",
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
                                              "Auf diesem Feld gibt es zu diesem Datum bereits eine Kultur. Wählen Sie ein anderes Feld oder ein anderes Datum",
                                          alertType: AlertType.error,
                                        );
                                      },
                                    );
                                  }
                                }
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
