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
      body: Consumer<FieldsViewModel>(
        builder: (context, fieldsViewModel, child) {
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 24),
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
                      child: CustomIconButtonLarge(
                        icon: Icon(Icons.save),
                        onPressed: () async {
                          if (fieldId == null) {
                            fieldsViewModel.addField(
                              _descriptionController.text,
                            );
                            print("crop added");
                          } else {
                            fieldsViewModel.update(
                              fieldId!,
                              _descriptionController.text,
                            );
                            print("crop updated");
                          }
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                    if (!isCreate)
                      Flexible(
                        child: CustomIconButtonLarge(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            fieldsViewModel.remove(fieldId!);
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
    );
  }
}
