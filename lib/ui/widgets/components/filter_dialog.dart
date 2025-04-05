import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/widgets/workstep_summary.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  DateTime? _startDate;
  DateTime? _endDate;

  List<String> _selectedFields = [];
  List<String> _selectedActivities = [];
  List<String> _selectedPersons = [];
  List<String> _selectedCrops = [];

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
      child: DefaultTabController(
        length: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.grass)), // Felder
                Tab(icon: Icon(Icons.eco)), // Kulturen
                Tab(icon: Icon(Icons.agriculture)), // Aktivitäten
                Tab(icon: Icon(Icons.person)), // Mitarbeiter
              ],
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [
                  _buildCheckboxList<FieldsViewModel>(
                    (viewModel) => viewModel.fields,
                    _selectedFields,
                    (item) => item.fieldName,
                  ),
                  _buildCheckboxList<CropsViewModel>(
                    (viewModel) => viewModel.cropList,
                    _selectedCrops,
                    (item) => item.cropName,
                  ),
                  _buildCheckboxList<ActivitiesViewModel>(
                    (viewModel) => viewModel.activities,
                    _selectedActivities,
                    (item) => item.activityName,
                  ),
                  _buildCheckboxList<PersonViewModel>(
                    (viewModel) => viewModel.personList,
                    _selectedPersons,
                    (item) => item.personName,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final fieldsViewModel = Provider.of<FieldsViewModel>(
                  context,
                  listen: false,
                );
                final activitiesViewModel = Provider.of<ActivitiesViewModel>(
                  context,
                  listen: false,
                );
                final cropsViewModel = Provider.of<CropsViewModel>(
                  context,
                  listen: false,
                );

                final selectedFieldNames =
                    _selectedFields
                        .map(
                          (id) =>
                              fieldsViewModel.fields
                                  .firstWhere(
                                    (field) => field.id.toString() == id,
                                  )
                                  .fieldName,
                        )
                        .toList();

                final selectedActivityNames =
                    _selectedActivities
                        .map(
                          (id) =>
                              activitiesViewModel.activities
                                  .firstWhere(
                                    (activity) => activity.id.toString() == id,
                                  )
                                  .activityName,
                        )
                        .toList();

                final selectedCropNames =
                    _selectedCrops
                        .map(
                          (id) =>
                              cropsViewModel.cropList
                                  .firstWhere(
                                    (crop) => crop.id.toString() == id,
                                  )
                                  .cropName,
                        )
                        .toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WorkstepSummary(
                          title: "Gefilterte Übersicht",
                          selectedFields:
                              selectedFieldNames.isEmpty
                                  ? null
                                  : selectedFieldNames,
                          selectedActivities:
                              selectedActivityNames.isEmpty
                                  ? null
                                  : selectedActivityNames,
                          selectedPersons:
                              _selectedPersons.isEmpty
                                  ? null
                                  : _selectedPersons,
                          selectedCrops:
                              selectedCropNames.isEmpty
                                  ? null
                                  : selectedCropNames,
                          startDate: _startDate,
                          endDate: _endDate,
                          isFiltered: true,
                        ),
                  ),
                );
              },
              child: Text("Filter anwenden"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxList<T>(
    List<dynamic> Function(T viewModel) getItems,
    List<String> selectedItems,
    String Function(dynamic item) getName,
  ) {
    return Consumer<T>(
      builder: (context, viewModel, child) {
        final items = getItems(viewModel);
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final id = item.id.toString();
            final name = getName(item);
            return CheckboxListTile(
              title: Text(name),
              value: selectedItems.contains(id),
              onChanged: (isSelected) {
                setState(() {
                  if (isSelected == true) {
                    selectedItems.add(id);
                  } else {
                    selectedItems.remove(id);
                  }
                });
              },
            );
          },
        );
      },
    );
  }
}
