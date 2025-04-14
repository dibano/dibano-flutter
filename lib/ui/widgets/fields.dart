import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/detail_card.dart';
import 'package:dibano/ui/widgets/field_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fields extends StatefulWidget {
  const Fields({super.key, required this.title});
  final String title;

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<FieldsViewModel>(context,listen: false).getFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<FieldsViewModel>(
        builder: (context, fieldsViewModel, child) {
          return Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        for (var field in fieldsViewModel.fields)
                          DetailCard(
                            detail: Detail(
                              name: field.fieldName,
                              toEdit: true,
                            ),
                          onTap: () async{
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FieldEdit(
                                      title: "Felder bearbeiten",
                                      fieldId: field.id,
                                      fieldName: field.fieldName,
                                      fieldSize: field.fieldSize.toString(),
                                      longitude: field.longitude.toString(),
                                      latitude: field.latitude.toString(),
                                      isCreate: true,
                                    ),
                              ),
                            );
                            if (result == true) {
                              await Provider.of<FieldsViewModel>(context,listen: false,).getFields();
                            }
                          },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      FieldEdit(title: "Feld erstellen", isCreate: true),
            ),
          );
          if (result == true) {
            await Provider.of<FieldsViewModel>(
              context,
              listen: false,
            ).getFields();
          }
        },
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
