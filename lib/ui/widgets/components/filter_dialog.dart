import 'package:dibano/ui/view_model/crops.dart';
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
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final fieldsViewModel = Provider.of<FieldsViewModel>(
      context,
      listen: false,
    );
    final personViewModel = Provider.of<PersonViewModel>(
      context,
      listen: false,
    );
    final cropsViewModel = Provider.of<CropsViewModel>(context, listen: false);
    final activitiesViewModel = Provider.of<ActivitiesViewModel>(
      context,
      listen: false,
    );

    await Future.wait([
      fieldsViewModel.getFields(),
      personViewModel.getPerson(),
      cropsViewModel.getCrops(),
      cropsViewModel.getCompleteCrops(),
      activitiesViewModel.getActivities(),
    ]);
  }

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
              placeholderDate: null,
              dateSelected: (selectedDate) {
                setState(() {
                  _startDate = selectedDate;
                });
              },
            ),
            FormDate(
              label: 'Datum bis',
              placeholderDate: null,
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
                    DropdownMenuItem(value: "-1", child: Text("Alle Felder")),
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
                      child: Text("Alle Aktivitäten"),
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
                      child: Text("Alle Mitarbeiter"),
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

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WorkstepSummary(
                          title: "Gefilterte Übersicht",
                          selectedField: selectedFieldName,
                          selectedActivity: selectedActivityName,
                          selectedPerson: _selectedPerson,
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
