import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/custom_iconbutton_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonEdit extends StatelessWidget {
  PersonEdit({super.key, required this.title, this.personName = "", this.personId});

  final String title;
  final String personName;
  final int? personId;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = personName;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Consumer<PersonViewModel>(
        builder: (context, personViewModel, child) {
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
                    child:
                      CustomButtonLarge(
                        text: 'Speichern',
                        onPressed: () async {
                          if(personId == null){
                            personViewModel.add(_descriptionController.text);
                            print("person added");
                          }
                          else{
                            personViewModel.update(personId!, _descriptionController.text);
                            print("person updated");
                          }
                          Navigator.pop(context);
                        },
                      ),
                  ),
                  Flexible(
                    child:
                      CustomIconButtonLarge(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                            personViewModel.remove(personId!);
                            Navigator.pop(context);
                        },
                      ),
                  )
                ],)
              ],
            ),
          );
        },
      ),
    );
  }
}
