import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/form_date.dart';
import 'package:dibano/ui/widgets/components/form_dropdown.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropsEdit extends StatefulWidget {
  CropsEdit({
    super.key,
    required this.title,
    this.cropName = "",
    this.cropId,
    this.startDate,
    this.fieldId,
    this.endDate,
    this.cropDateId,
    this.isCreate = false,
  });

  final String title;
  final String cropName;
  final int? cropId;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? fieldId;
  final int? cropDateId;
  bool isCreate;

  @override
  State<CropsEdit> createState() => _CropsEditState();
}

class _CropsEditState extends State<CropsEdit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FieldsViewModel>(context, listen: false).getFields();
    });

    setState(() {
      _startDate = widget.startDate;
      _endDate = widget.endDate;
      _selectedField = widget.fieldId?.toString() ?? "-1";
      _descriptionController.text = widget.cropName;
    });
  }

  String? _selectedField = "-1";
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<CropsViewModel>(
          builder: (context, cropsViewModel, child) {
            return Center(
              child: Column(
                children: <Widget>[
                  if (!widget.isCreate)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await cropsViewModel.remove(widget.cropId!);
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
                            label: "Kulturname",
                            controller: _descriptionController,
                            keyboardType: TextInputType.text,
                            maxLine: 1,
                          ),
                          FormDate(
                            label: "Startdatum",
                            placeholderDate: _startDate ?? DateTime.now(),
                            dateSelected: (date) {
                              setState(() => _startDate = date!);
                            },
                          ),
                          FormDate(
                            label: "Enddatum",
                            placeholderDate: _endDate ?? DateTime.now(),
                            dateSelected: (date) {
                              setState(() => _endDate = date!);
                            },
                          ),
                          Consumer<FieldsViewModel>(
                            builder: (context, fieldsViewModel, child) {
                              return FormDropdown(
                                label: "Feld",
                                value: _selectedField!,
                                items: [
                                  DropdownMenuItem(
                                    value: "-1",
                                    child: Text("Ort wählen"),
                                  ),
                                  ...fieldsViewModel.fields.map(
                                    (field) => DropdownMenuItem(
                                      value: field.id.toString(),
                                      child: Text(field.fieldName),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() => _selectedField = value ?? "");
                                },
                              );
                            },
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
                            if(_descriptionController.text != "" && _selectedField != null && _selectedField != "-1"){
                              if (widget.cropId == null) {
                                final inExistingDate = cropsViewModel.existingCropAtDateAndField(int.parse(_selectedField.toString()), _startDate??DateTime.now(), _endDate??DateTime.now(), widget.cropId);
                                final endIsBeforeStart = cropsViewModel.endIsBeforeStart(_startDate??DateTime.now(), _endDate??DateTime.now());
                                if(inExistingDate != true){
                                  int? fieldId = int.tryParse(
                                    _selectedField!,
                                  ); // Konvertiert String zu int
                                  await cropsViewModel.add(
                                    _descriptionController.text,
                                    _startDate ?? DateTime.now(),
                                    _endDate ?? DateTime.now(),
                                    fieldId!,
                                  );
                                  Navigator.pop(context, true);
                                }else if (endIsBeforeStart == true){
                                  await showDialog(
                                    context:context,
                                    builder:(BuildContext context){
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.error, color: const Color.fromARGB(255, 175, 76, 76), size: 48),
                                            SizedBox(height: 16),
                                            Text(
                                              "Das Startdatum darf nicht nach dem Enddatum sein.",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () { 
                                              Navigator.of(context).pop();                                   
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  await showDialog(
                                    context:context,
                                    builder:(BuildContext context){
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.error, color: const Color.fromARGB(255, 175, 76, 76), size: 48),
                                            SizedBox(height: 16),
                                            Text(
                                              "Auf diesem Feld gibt es zu diesem Datum bereits eine Kultur. Wählen Sie ein anderes Feld oder ein anderes Datum",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () { 
                                              Navigator.of(context).pop();                                   
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                final inExistingDate = cropsViewModel.existingCropAtDateAndField(int.parse(_selectedField.toString()), _startDate??DateTime.now(), _endDate??DateTime.now(), widget.cropId);
                                final endIsBeforeStart = cropsViewModel.endIsBeforeStart(_startDate??DateTime.now(), _endDate??DateTime.now());
                                if(inExistingDate != true){
                                  int? fieldId = int.tryParse(
                                    _selectedField!,
                                  ); // Konvertiert String zu int
                                  await cropsViewModel.update(
                                    _descriptionController.text,
                                    _startDate!,
                                    _endDate!,
                                    fieldId!,
                                    widget.cropId!,
                                    widget.cropDateId!,
                                  );
                                  Navigator.pop(context, true);
                                }else if(endIsBeforeStart==true){
                                  await showDialog(
                                    context:context,
                                    builder:(BuildContext context){
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.error, color: const Color.fromARGB(255, 175, 76, 76), size: 48),
                                            SizedBox(height: 16),
                                            Text(
                                              "Das Startdatum darf nicht nach dem Enddatum sein.",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () { 
                                              Navigator.of(context).pop();                                   
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  await showDialog(
                                    context:context,
                                    builder:(BuildContext context){
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.error, color: const Color.fromARGB(255, 175, 76, 76), size: 48),
                                            SizedBox(height: 16),
                                            Text(
                                              "Auf diesem Feld gibt es zu diesem Datum bereits eine Kultur. Wählen Sie ein anderes Feld oder ein anderes Datum",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () { 
                                              Navigator.of(context).pop();                                   
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            }else{
                              await showDialog(
                                context:context,
                                builder:(BuildContext context){
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.error, color: const Color.fromARGB(255, 175, 76, 76), size: 48),
                                        SizedBox(height: 16),
                                        Text(
                                          "Alle Felder müssen ausgefüllt sein!",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () { 
                                          Navigator.of(context).pop();                                   
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
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
    );
  }
}
