import 'package:dibano/data/model/person_model.dart';
import 'package:dibano/ui/view_model/People.dart';
import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/person_edit.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:provider/provider.dart';

class People extends StatelessWidget {
  const People({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    FieldsViewModel peopleViewModel = Provider.of<FieldsViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Consumer<FieldsViewModel>(
        builder: (context, peopleViewModel, child) {
          //  peopleViewModel.get();
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 24),
                        CustomTitle(text: 'Personen konfigurieren'),
                        for (var person in peopleViewModel.fields)
                          DetailCard(
                            detail: Detail(
                              name: person.fieldName,
                              routeWidget: PersonEdit(
                                title: "Person bearbeiten",
                                name: person.fieldName,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                CustomButtonLarge(
                  text: 'Person hinzufügen',
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PersonEdit(title: "Person erstellen"),
                      ),
                    );
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
