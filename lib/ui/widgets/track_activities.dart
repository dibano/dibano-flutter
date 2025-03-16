import 'package:dibano/ui/view_model/track_activities.dart';
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
  TrackActivetiesViewModel trackActiveties = TrackActivetiesViewModel();
  //Ort Dropdown
  String _selectedArea = 'Ort wählen';

  //Beschreibung Textfeld
  final TextEditingController _descriptionController = TextEditingController();

  //Aktivität Dropdown
  String _selectedActivity = 'Aktivität wählen';

  //Kultur Dropdown
  String _selectedCulture = 'Kultur wählen';

  //Person Dropdown
  String _selectedPerson = 'Person wählen';

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
        _selectedArea.isNotEmpty &&
        _selectedArea != 'Ort wählen' &&
        _selectedActivity.isNotEmpty &&
        _selectedActivity != 'Aktivität wählen' &&
        _selectedCulture.isNotEmpty &&
        _selectedCulture != 'Kultur wählen' &&
        _selectedPerson.isNotEmpty &&
        _selectedPerson != 'Person wählen') {
      setState(() {
        _entries.add({
          'area': _selectedArea,
          'description': _descriptionController.text,
          'activity': _selectedActivity,
          'culture': _selectedCulture,
          'person': _selectedPerson,
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
      Provider.of<TrackActivetiesViewModel>(context,listen: false).getFields();
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
                Consumer<TrackActivetiesViewModel>(
                  builder:(context,trackActiveties,child){
                    return FormDropdown(
                      label: "Feld",
                      value: _selectedArea,
                      items: ["Ort wählen", ...trackActiveties.fieldsList],
                      onChanged: (value) {
                        setState(() => _selectedArea = value!);
                      },
                    );
                  }),
                FormTextfield(
                  label: "Beschreibung",
                  controller: _descriptionController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  maxLine: 5,
                ),

                FormDropdown(
                  label: "Aktivität",
                  value: _selectedActivity,
                  items: ["Aktivität wählen", "Aktivität 1", "Aktivität 2", "Aktivität 3"],
                  onChanged: (value) {
                    setState(() => _selectedActivity = value!);
                  },
                ),

                if (_selectedActivity == "Aktivität 1") ...[
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
                ],

                FormDropdown(
                  label: "Kultur",
                  value: _selectedCulture,
                  items: ["Kultur wählen", "Kultur 1", "Kultur 2", "Kultur 3"],
                  onChanged: (value) {
                    setState(() => _selectedCulture = value!);
                  },
                ),

                FormDropdown(
                  label: "Person",
                  value: _selectedPerson,
                  items: ["Person wählen", "Person 1", "Person 2", "Person 3"],
                  onChanged: (value) {
                    setState(() => _selectedPerson = value!);
                  },
                ),

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
