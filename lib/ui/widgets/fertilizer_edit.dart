import 'package:dibano/ui/view_model/fertilizer.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_numberfield.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FertilizerEdit extends StatelessWidget {
  FertilizerEdit({
    super.key,
    required this.title,
    this.fertilizerName = "",
    this.n = "",
    this.p = "",
    this.k = "",
    this.fertilizerId,
    this.isCreate = false,
  });

  final String title;
  final String fertilizerName;
  final String n;
  final String p;
  final String k;
  final int? fertilizerId;
  final bool isCreate;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nController = TextEditingController();
  final TextEditingController _pController = TextEditingController();
  final TextEditingController _kController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = fertilizerName;
    String? _actualFertilizerName = fertilizerName;
    _nController.text = n;
    _pController.text = p;
    _kController.text = k;

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
        appBar: CustomAppBar(title: title, messageOnLeave: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<FertilizerViewModel>(
            builder: (context, fertilizerViewModel, child) {
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
                                          "Möchtest du dieses Düngmittel wirklich löschen?",
                                      alertType: AlertType.delete,
                                      onDelete: () async {
                                        await fertilizerViewModel.remove(
                                          fertilizerId!,
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
                              label: "Düngmittelname",
                              controller: _descriptionController,
                              keyboardType: TextInputType.text,
                              maxLine: 1,
                              focusNode: _focusNode,
                            ),
                            FormNumberField(
                              label: "Stickstoffkonzentration (N)",
                              controller: _nController,
                              maxLine: 1,
                              onChanged: (value){ 
                                      final replacedValue = value.replaceAll(',', '.');
                                      _nController.text = replacedValue;
                                      _nController.selection = TextSelection.fromPosition(TextPosition(offset: replacedValue.length),);
                                    }
                            ),
                            FormNumberField(
                              label: "Phosphorkonzentration (P)",
                              controller: _pController,
                              maxLine: 1,
                              onChanged: (value){ 
                                      final replacedValue = value.replaceAll(',', '.');
                                      _pController.text = replacedValue;
                                      _pController.selection = TextSelection.fromPosition(TextPosition(offset: replacedValue.length),);
                                    }

                            ),
                            FormNumberField(
                              label: "Kalikonzentration (K)",
                              controller: _kController,
                              maxLine: 1,
                              onChanged: (value){ 
                                      final replacedValue = value.replaceAll(',', '.');
                                      _kController.text = replacedValue;
                                      _kController.selection = TextSelection.fromPosition(TextPosition(offset: replacedValue.length),);
                                    }
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
                              final fertilizerExisting = fertilizerViewModel
                                  .checkIfExisting(_descriptionController.text);
                              if (_descriptionController.text != "" &&
                                  _nController.text != "" &&
                                  _pController.text != "" &&
                                  _kController.text != "" &&
                                  (fertilizerExisting == false ||
                                      _actualFertilizerName ==
                                          _descriptionController.text)) {
                                if (fertilizerId == null) {
                                  await fertilizerViewModel.addFertilizer(
                                    _descriptionController.text,
                                    _nController.text,
                                    _pController.text,
                                    _kController.text,
                                  );
                                  Navigator.pop(context, true);
                                } else {
                                  await fertilizerViewModel.update(
                                    fertilizerId!,
                                    _descriptionController.text,
                                    _nController.text,
                                    _pController.text,
                                    _kController.text,
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
                                  _nController.text != "" &&
                                  _pController.text != "" &&
                                  _kController.text != "" &&
                                  fertilizerExisting == true) {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialog(
                                      alertText:
                                          "Du hast dieses Düngemittel bereits erfasst",
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
