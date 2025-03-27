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
                              cropsViewModel.remove(widget.cropId!);
                              Navigator.pop(context);
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
                            if (widget.cropId == null) {
                              int? fieldId = int.tryParse(
                                _selectedField!,
                              ); // Konvertiert String zu int
                              cropsViewModel.add(
                                _descriptionController.text,
                                _startDate ?? DateTime.now(),
                                _endDate ?? DateTime.now(),
                                fieldId!,
                              );
                            } else {
                              int? fieldId = int.tryParse(
                                _selectedField!,
                              ); // Konvertiert String zu int
                              cropsViewModel.update(
                                _descriptionController.text,
                                _startDate!,
                                _endDate!,
                                fieldId!,
                                widget.cropId!,
                                widget.cropDateId!,
                              );
                            }
                            Navigator.pop(context);
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
