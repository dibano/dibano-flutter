import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/form_dropdown.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:provider/provider.dart';

class TrackActivities extends StatefulWidget {
  const TrackActivities({super.key, required this.title});

  final String title;

  @override
  State<TrackActivities> createState() => _TrackActivitiesState();
}

class _TrackActivitiesState extends State<TrackActivities> {
  FieldsViewModel fieldsViewModel = FieldsViewModel();
  CropsViewModel cropsViewModel = CropsViewModel();
  PersonViewModel personViewModel = PersonViewModel();

  //Ort Dropdown
  String? _selectedArea = "-1";

  //Beschreibung Textfeld
  final TextEditingController _descriptionController = TextEditingController();

  //Aktivität Dropdown
  String? _selectedActivity = "-1";

  //Kultur Dropdown
  String? _selectedCulture = "-1";

  //Person Dropdown
  String? _selectedPerson = "-1";

  /*
  Additional Fields
  */
  //Düngemittel Dropdown
  String _selectedFertilizers = 'Düngemittel wählen';

  //Ausbringmenge Textfeld
  final TextEditingController _fertilizerAmountController =
      TextEditingController();

  //Ausbringmenge Textfeld
  final TextEditingController _fertilizerAmountPerHaController =
      TextEditingController();

  final List<Map<String, String>> _entries = [];

  void _addEntry() {
    if (_descriptionController.text.isNotEmpty &&
        _selectedArea!="-1" &&
        _selectedArea != 'Ort wählen' &&
        _selectedActivity!="-1" &&
        _selectedActivity != 'Aktivität wählen' &&
        _selectedCulture!="-1"&&
        _selectedCulture != 'Kultur wählen' &&
        _selectedPerson!= "-1" &&
        _selectedPerson != 'Person wählen') {
      setState(() {
        _entries.add({
          'area': _selectedArea!,
          'description': _descriptionController.text,
          'activity': _selectedActivity!,
          'culture': _selectedCulture!,
          'person': _selectedPerson!,
          'fertilizerType': _selectedFertilizers,
          'fertilizerAmount': _fertilizerAmountController.text,
          'fertilizerAmountPerHa': _fertilizerAmountPerHaController.text,
        });
        _descriptionController.clear();
        _selectedArea = 'Ort wählen';
        _selectedActivity = 'Aktivität wählen';
        _selectedCulture = 'Kultur wählen';
        _selectedPerson = 'Person wählen';
        _selectedFertilizers = 'Düngemittel wählen';
        _fertilizerAmountController.clear();
        _fertilizerAmountPerHaController.clear();
      });
    }
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<FieldsViewModel>(context,listen: false).getFields();
      Provider.of<PersonViewModel>(context,listen: false).getPerson();
      Provider.of<CropsViewModel>(context,listen: false).getCrops();
      Provider.of<ActivitiesViewModel>(context,listen: false).getActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: widget.title),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<FieldsViewModel>(
                          builder:(context,fieldsViewModel,child){
                            return FormDropdown(
                              label: "Feld",
                              value: _selectedArea!,
                              items: [
                                DropdownMenuItem(
                                  value: "-1",
                                  child: Text("Ort wählen"),
                                ),
                                ...fieldsViewModel.fields.map((field) => DropdownMenuItem(
                                  value:field.id.toString(),
                                  child: Text(field.fieldName),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedArea = value ?? "");
                              },
                            );
                          }),
                FormTextfield(
                  label: "Beschreibung",
                  controller: _descriptionController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  maxLine: 5,
                ),

                Consumer<CropsViewModel>(
                          builder:(context,cropsViewModel,child){
                            return FormDropdown(
                              label: "Kultur",
                              value: _selectedCulture!,
                              items: [
                                DropdownMenuItem(
                                  value: "-1",
                                  child: Text("Kultur wählen"),
                                ),
                                ...cropsViewModel.cropList.map((crop) => DropdownMenuItem(
                                  value:crop.id.toString(),
                                  child: Text(crop.cropName),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedCulture = value ?? "");
                              },
                            );
                          }),

                Consumer<ActivitiesViewModel>(
                          builder:(context,activitiesViewModel,child){
                            return FormDropdown(
                              label: "Aktivität",
                              value: _selectedActivity!,
                              items: [
                                DropdownMenuItem(
                                  value: "-1",
                                  child: Text("Aktivität wählen"),
                                ),
                                ...activitiesViewModel.activities.map((activity) => DropdownMenuItem(
                                  value:activity.id.toString(),
                                  child: Text(activity.activityName),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedActivity = value ?? "");
                              },
                            );
                          }),

                Consumer<PersonViewModel>(
                          builder:(context,personViewModel,child){
                            return FormDropdown(
                              label: "Person",
                              value: _selectedPerson!,
                              items: [
                                DropdownMenuItem(
                                  value: "-1",
                                  child: Text("Person wählen"),
                                ),
                                ...personViewModel.personList.map((person) => DropdownMenuItem(
                                  value:person.id.toString(),
                                  child: Text(person.personName),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedPerson = value ?? "");
                              },
                            );
                          }),
                

                /*if (_selectedActivity == "Aktivität 1") ...[
                  FormDropdown(
                    label: "Düngemittel",
                    value: _selectedFertilizers,
                    items: ["Düngemittel wählen", "Düngemittel 1", "Düngemittel 2", "Düngemittel 3"],
                    onChanged: (value) {
                      setState(() => _selectedFertilizers = value!);
                    },
                  ),

                  FormTextfield(
                    label: "Ausbringmenge (in kg)",
                    controller: _fertilizerAmountController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    maxLine: 1,
                  ),

                  FormTextfield(
                    label: "Ausbringmenge pro ha (in kg)",
                    controller: _fertilizerAmountPerHaController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    maxLine: 1,
                  ),
                ],*/
                  
                ElevatedButton(
                  onPressed: _addEntry,
                  child: const Text("Hinzufügen"),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    itemCount: _entries.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Aktivität: ${_entries[index]['activity']}',
                        ),
                        subtitle: Text(
                          'Ort ${_entries[index]['area']}\n'
                          'Beschreibung ${_entries[index]['description']}\n'
                          'Kultur ${_entries[index]['culture']}\n'
                          'Person ${_entries[index]['person']}\n',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
