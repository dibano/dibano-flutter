import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/custom_iconbutton_large.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiesEdit extends StatelessWidget {
  ActivitiesEdit({super.key, required this.title, this.activityName = "", this.activityId});

  final String title;
  final String activityName;
  final int? activityId;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _descriptionController.text = activityName;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Consumer<ActivitiesViewModel>(
        builder: (context, activitiesViewModel, child) {
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
                          if(activityId == null){
                            activitiesViewModel.add(_descriptionController.text);
                            print("activity added");
                          }
                          else{
                            activitiesViewModel.update(activityId!, _descriptionController.text);
                            print("activity updated");
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
                            activitiesViewModel.remove(activityId!);
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
