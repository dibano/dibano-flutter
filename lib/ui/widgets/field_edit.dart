import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/custom_iconbutton_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
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
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              fieldsViewModel.remove(fieldId!);
                              Navigator.pop(context, true);
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
                            if (fieldId == null) {
                              fieldsViewModel.addField(
                                _descriptionController.text,
                              );
                              print("field added");
                            } else {
                              fieldsViewModel.update(
                                fieldId!,
                                _descriptionController.text,
                              );
                              print("field updated");
                            }
                            Navigator.pop(context, true);
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
