import 'package:dibano/ui/widgets/workstep_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/widgets/components/form_date.dart';
import 'package:dibano/ui/widgets/components/form_dropdown.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedField = "-1";
  String? _selectedActivity = "-1";
  String? _selectedPerson = "-1";
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            FormDate(
              label: 'Datum von',
              placeholderDate: DateTime.now(),
              dateSelected: (selectedDate) {
                setState(() {
                  _startDate = selectedDate;
                });
              },
            ),
            FormDate(
              label: 'Datum bis',
              placeholderDate: DateTime.now(),
              dateSelected: (selectedDate) {
                setState(() {
                  _endDate = selectedDate;
                });
              },
            ),
            Consumer<FieldsViewModel>(
              builder: (context, fieldsViewModel, child) {
                return FormDropdown(
                  label: "Feld",
                  value: _selectedField!,
                  items: [
                    DropdownMenuItem(value: "-1", child: Text("Feld wählen")),
                    ...fieldsViewModel.fields.map(
                      (field) => DropdownMenuItem(
                        value: field.id.toString(),
                        child: Text(field.fieldName),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedField = value ?? "-1");
                  },
                );
              },
            ),
            Consumer<ActivitiesViewModel>(
              builder: (context, activitiesViewModel, child) {
                return FormDropdown(
                  label: "Aktivität",
                  value: _selectedActivity!,
                  items: [
                    DropdownMenuItem(
                      value: "-1",
                      child: Text("Aktivität wählen"),
                    ),
                    ...activitiesViewModel.activities.map(
                      (activity) => DropdownMenuItem(
                        value: activity.id.toString(),
                        child: Text(activity.activityName),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedActivity = value ?? "-1");
                  },
                );
              },
            ),
            Consumer<PersonViewModel>(
              builder: (context, personViewModel, child) {
                return FormDropdown(
                  label: "Mitarbeiter",
                  value: _selectedPerson!,
                  items: [
                    DropdownMenuItem(
                      value: "-1",
                      child: Text("Mitarbeiter wählen"),
                    ),
                    ...personViewModel.personList.map(
                      (person) => DropdownMenuItem(
                        value: person.id.toString(),
                        child: Text(person.personName),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedPerson = value ?? "-1");
                  },
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Extrahiere die Namen für Field und Activity basierend auf den ausgewählten IDs
                final selectedFieldName =
                    _selectedField != "-1"
                        ? Provider.of<FieldsViewModel>(context, listen: false)
                            .fields
                            .firstWhere(
                              (field) => field.id.toString() == _selectedField,
                            )
                            .fieldName
                        : null;

                final selectedActivityName =
                    _selectedActivity != "-1"
                        ? Provider.of<ActivitiesViewModel>(
                              context,
                              listen: false,
                            ).activities
                            .firstWhere(
                              (activity) =>
                                  activity.id.toString() == _selectedActivity,
                            )
                            .activityName
                        : null;

                // Logge die ausgewählten Werte in der Konsole
                print("Filterwerte:");
                print("Feld: $selectedFieldName");
                print("Aktivität: $selectedActivityName");
                print("Mitarbeiter: $_selectedPerson");
                print("Startdatum: $_startDate");
                print("Enddatum: $_endDate");

                // Navigiere zur WorkstepSummary-View mit den Namen für Field und Activity
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WorkstepSummary(
                          title: "Gefilterte Übersicht",
                          selectedField: selectedFieldName,
                          selectedActivity: selectedActivityName,
                          selectedPerson: _selectedPerson, // ID bleibt erhalten
                          startDate: _startDate,
                          endDate: _endDate,
                          isFiltered: true,
                        ),
                  ),
                );
              },
              child: Text("Anwenden"),
            ),
          ],
        ),
      ),
    );
  }
}
