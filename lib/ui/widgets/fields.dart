import 'dart:math';

import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/field_edit.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:provider/provider.dart';


class Fields extends StatelessWidget {
  const Fields({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    FieldsViewModel fieldsViewModel = Provider.of<FieldsViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Consumer<FieldsViewModel>(
        builder:(context,fieldsViewModel,child){
          fieldsViewModel.getFields();
          return Center(
            child: Column(
            children: <Widget>[
              SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 24),
                      CustomTitle(text: 'Felder konfigurieren'),
                      for (var field in fieldsViewModel.fields)
                        DetailCard(
                          detail: Detail(
                            name: field.fieldName,
                            routeWidget: FieldEdit(), //to do: add route
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              CustomButtonLarge(
                text: 'Feld hinzufügen',
                onPressed: () async{
                  await fieldsViewModel.addField("Test${Random().nextInt(10)}");
                  await fieldsViewModel.getFields();
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
