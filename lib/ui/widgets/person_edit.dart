import 'package:dibano/ui/view_model/People.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonEdit extends StatelessWidget {
  PersonEdit({super.key, required this.title, this.name = ""});

  final String title;
  final String name;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Consumer<FieldsViewModel>(
        builder: (context, peopleViewModel, child) {
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
                          label: "Name",
                          controller: _descriptionController,
                          keyboardType: TextInputType.text,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButtonLarge(
                  text: 'Speichern',
                  onPressed: () async {
                    // To do save field
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
