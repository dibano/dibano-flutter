import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_title.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/field_edit.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:provider/provider.dart';

class Fields extends StatefulWidget {
  const Fields({super.key, required this.title});
  final String title;

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  bool _initialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      Provider.of<FieldsViewModel>(context, listen: false).getFields();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    FieldsViewModel fieldsViewModel = Provider.of<FieldsViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<FieldsViewModel>(
        builder: (context, fieldsViewModel, child) {
          Provider.of<FieldsViewModel>(context, listen: false).getFields();
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
                              routeWidget: FieldEdit(
                                title: "Feld bearbeiten",
                                fieldName: field.fieldName,
                                fieldId: field.id,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                CustomButtonLarge(
                  text: 'Feld hinzufügen',
                  onPressed: () async {
                    final result = Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => FieldEdit(
                              title: "Feld erstellen",
                              isCreate: true,
                            ),
                      ),
                    );
                    if (result == true) {
                      await Provider.of<FieldsViewModel>(
                        context,
                        listen: false,
                      ).getFields();
                    }
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
