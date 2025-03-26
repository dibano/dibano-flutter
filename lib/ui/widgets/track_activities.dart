import 'package:dibano/data/model/field_model.dart';
import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/track_activities.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/components/custom_iconbutton_large.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/form_dropdown.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:dibano/ui/widgets/components/form_textfield_disabled.dart';
import 'package:dibano/ui/widgets/components/warn_card.dart';
import 'package:provider/provider.dart';
import 'package:dibano/ui/widgets/components/form_date.dart';


class TrackActivities extends StatefulWidget {
  const TrackActivities({
    super.key,
    required this.title,
    this.selectedArea,
    this.selectedPerson,
    this.selectedActivity,
    this.description,
    this.workstepActivityId,
    this.workstepId,
    this.activityDate,
  });

  final String title;
  final String? selectedArea;
  final String? selectedActivity;
  final String? selectedPerson;
  final String? description;
  final int? workstepActivityId;
  final int? workstepId;
  final DateTime? activityDate;

  @override
  State<TrackActivities> createState() => _TrackActivitiesState();
}

class _TrackActivitiesState extends State<TrackActivities> {
  bool _fieldSelected = false;
  bool _dateSelected = false;


  TrackActivetiesViewModel trackActivitiesViewModel =
      TrackActivetiesViewModel();
  FieldsViewModel fieldsViewModel = FieldsViewModel();
  CropsViewModel cropsViewModel = CropsViewModel();
  PersonViewModel personViewModel = PersonViewModel();

  //Ort Dropdown
  String? _selectedArea = "-1";
  String? selectedCropName;
  //Beschreibung Textfeld
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();

  //Aktivität Dropdown
  String? _selectedActivity = "-1";

  //Kultur Dropdown
  String? _selectedCulture = "-1";

  //Person Dropdown
  String? _selectedPerson = "-1";

  //Datum Feld
  DateTime? _activityDate;

  final List<Map<String, String>> _entries = [];

  void _addEntry() {
    if (_descriptionController.text.isNotEmpty &&
        _selectedArea != "-1" &&
        _selectedArea != 'Ort wählen' &&
        _selectedActivity != "-1" &&
        _selectedActivity != 'Aktivität wählen' &&
        _selectedPerson != "-1" &&
        _selectedPerson != 'Person wählen') {
      setState(() {
        if (widget.selectedArea == null ||
            widget.selectedActivity == null ||
            widget.selectedPerson == null ||
            widget.description == null) {
          trackActivitiesViewModel.addWorkstepActivity(
            int.parse(_selectedArea.toString()),
            _descriptionController.text,
            int.parse(_selectedPerson.toString()),
            int.parse(_selectedActivity.toString()),
            _activityDate ?? DateTime.now(),
          );
        } else {
          trackActivitiesViewModel.updateWorkStepActivity(
            int.parse(_selectedArea.toString()),
            _descriptionController.text,
            int.parse(_selectedPerson.toString()),
            int.parse(_selectedActivity.toString()),
            widget.workstepActivityId!,
            widget.workstepId!,
            _activityDate ?? DateTime.now(),
          );
        }

        _descriptionController.clear();
        _selectedArea = "-1";
        _selectedActivity = "-1";
        _selectedCulture = "-1";
        _selectedPerson = "-1";
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                SizedBox(height: 16),
                Text(
                  "Erfolgreich gespeichert!",
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

  Future<void> _loadCropsName() async {
    await cropsViewModel.getCompleteCrops();
    selectedCropName = cropsViewModel.getCropName(
      int.parse(_selectedArea.toString()),
      _activityDate!,
    );
    _cropController.text = selectedCropName.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.activityDate != null) {
      _dateSelected = true;
      _activityDate = widget.activityDate;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FieldsViewModel>(context, listen: false).getFields();
      Provider.of<PersonViewModel>(context, listen: false).getPerson();
      Provider.of<CropsViewModel>(context, listen: false).getCrops();
      Provider.of<CropsViewModel>(context, listen: false).getCompleteCrops();
      Provider.of<ActivitiesViewModel>(context, listen: false).getActivities();

        if (widget.selectedArea != null) {
          _fieldSelected = true;
          _selectedArea = widget.selectedArea;
          _loadCropsName();
        }
        if (widget.selectedActivity != null) {
          _selectedActivity = widget.selectedActivity;
        }
        if (widget.selectedPerson != null) {
          _selectedPerson = widget.selectedPerson;
        }
        if (widget.description != null) {
          _descriptionController.text = widget.description.toString();
        }
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
                  builder: (context, fieldsViewModel, child) {
                    return FormDropdown(
                      label: "Feld",
                      value: _selectedArea!,
                      items: [
                        DropdownMenuItem(
                          value: "-1",
                          child: Text("Ort wählen"),
                        ),
                        ...fieldsViewModel.fields.map(
                          (fields) => DropdownMenuItem(
                            value: fields.id.toString(),
                            child: Text(fields.fieldName),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedArea = value ?? "-1";
                          if(_selectedArea != "-1"){
                            _fieldSelected = true;
                          }else{
                            _fieldSelected = false;
                          }

                          if(_fieldSelected && _dateSelected){
                            selectedCropName = cropsViewModel.getCropName(
                              int.parse(_selectedArea.toString()),
                              _activityDate!,
                            );
                            _cropController.text = selectedCropName.toString();
                          } 
                        });
                      },
                    );
                  },
                ),
                Consumer<CropsViewModel>(
                  builder: (context, cropsViewModel, child) {
                    return FormDate(
                          label: "Datum",
                          placeholderDate: _activityDate,
                          dateSelected: (date) {
                            setState((){
                              _activityDate = date!;
                              _dateSelected = true;
                              if(_fieldSelected && _dateSelected){
                                selectedCropName = cropsViewModel.getCropName(
                                  int.parse(_selectedArea.toString()),
                                  _activityDate!,
                                );
                                _cropController.text = selectedCropName.toString();
                              }
                            });
                          },
                        );
                  },
                ),
                if(_activityDate != null && _selectedArea != "-1" && _cropController.text == "unbekannt")...[
                  Warn(warnText: "Keine Kultur zur Feldauswahl und Datumauswahl gefunden!"),
                ],

                if(_activityDate != null && _selectedArea != "-1" && _cropController.text != "unbekannt")...[
                  FormTextfield(
                    label: "Beschreibung",
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    maxLine: 5,
                  ),

                  Consumer<CropsViewModel>(
                    builder: (context, cropsViewModel, child) {
                      return FormTextfieldDisabled(
                        label: "Kultur",
                        textController: _cropController,
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
                        label: "Person",
                        value: _selectedPerson!,
                        items: [
                          DropdownMenuItem(
                            value: "-1",
                            child: Text("Person wählen"),
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
                  CustomButtonLarge(onPressed: _addEntry, text: "Speichern"),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
