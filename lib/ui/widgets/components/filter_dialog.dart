import 'package:dibano/ui/view_model/fertilizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/widgets/workstep_summary.dart';
import 'package:dibano/ui/widgets/components/form_date.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _selectedFields = [];
  final List<String> _selectedActivities = [];
  final List<String> _selectedPersons = [];
  final List<String> _selectedCrops = [];
  final List<String> _selectedFertilizers = [];

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
    final fertilizersViewModel = Provider.of<FertilizerViewModel>(
      context,
      listen: false,
    );

    await Future.wait([
      fieldsViewModel.getFields(),
      personViewModel.getPerson(),
      cropsViewModel.getCrops(),
      cropsViewModel.getCompleteCrops(),
      activitiesViewModel.getActivities(),
      fertilizersViewModel.getFertilizer(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: DefaultTabController(
        length: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.grass)), // Felder
                Tab(icon: Icon(Icons.eco)), // Kulturen
                Tab(icon: Icon(Icons.agriculture)), // Aktivitäten
                Tab(icon: Icon(Icons.person)), // Mitarbeiter
                Tab(icon: Icon(Icons.water_drop)), // Düngemittel
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
                  _buildCheckboxList<FertilizerViewModel>(
                    (viewModel) => viewModel.fertilizerList,
                    _selectedFertilizers,
                    (item) => item.fertilizerName,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormDate(
                          key: ValueKey(_startDate),
                          label: "Datum von",
                          placeholderDate: _startDate,
                          dateSelected: (date) {
                            setState(() {
                              _startDate = date;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _startDate = null;
                          });
                        },
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: FormDate(
                          key: ValueKey(_endDate),
                          label: "Datum bis",
                          placeholderDate: _endDate,
                          dateSelected: (date) {
                            setState(() {
                              _endDate = date;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _endDate = null;
                          });
                        },
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
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
                  final fertilizersViewModel = Provider.of<FertilizerViewModel>(
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
                                      (activity) =>
                                          activity.id.toString() == id,
                                    )
                                    .activityName,
                          )
                          .toList();

                  final selectedFertilizerNames =
                      _selectedFertilizers
                          .map(
                            (id) =>
                                fertilizersViewModel.fertilizerList
                                    .firstWhere(
                                      (fertilizer) =>
                                          fertilizer.id.toString() == id,
                                    )
                                    .fertilizerName,
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

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WorkstepSummary(
                            title: "Tätigkeiten gefiltert",
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
                            selectedFertilizers:
                                selectedFertilizerNames.isEmpty
                                    ? null
                                    : selectedFertilizerNames,
                            startDate: _startDate,
                            endDate: _endDate,
                            isFiltered: true,
                          ),
                    ),
                  );
                },
                child: const Text(
                  "Filter anwenden",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FormDate(
            label: "Datum von",
            placeholderDate: null,
            dateSelected: (date) {
              setState(() {
                _startDate = date;
              });
            },
          ),
          const SizedBox(height: 16),
          FormDate(
            label: "Datum bis",
            placeholderDate: null,
            dateSelected: (date) {
              setState(() {
                _endDate = date;
              });
            },
          ),
        ],
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
