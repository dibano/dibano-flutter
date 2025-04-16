import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/view_model/fertilizer.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/track_worksteps.dart';
import 'package:dibano/ui/widgets/activities_edit.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/custom_button_large.dart';
import 'package:dibano/ui/widgets/fertilizer_edit.dart';
import 'package:dibano/ui/widgets/person_edit.dart';
import 'package:dibano/ui/widgets/workstep_summary.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/form_dropdown.dart';
import 'package:dibano/ui/widgets/components/form_textfield.dart';
import 'package:dibano/ui/widgets/components/form_textfield_disabled.dart';
import 'package:dibano/ui/widgets/components/warn_card.dart';
import 'package:provider/provider.dart';
import 'package:dibano/ui/widgets/components/form_date.dart';

class TrackWorksteps extends StatefulWidget {
  const TrackWorksteps({
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
  State<TrackWorksteps> createState() => _TrackWorkstepsState();
}

class _TrackWorkstepsState extends State<TrackWorksteps> {
  late TrackWorkstepsViewModel _trackWorkstepsViewModel;

  bool _fieldSelected = false;

  String? _selectedArea = "-1";
  String? selectedCropName;

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _cropController = TextEditingController();

  String? _selectedActivity = "-1";

  String? _selectedCulture = "-1";

  String? _selectedPerson = "-1";

  String? _selectedFertilizer = "-1";

  String? _selectedPlantProtectionType = "-1";

  String? _selectedGroundDamage = "-1";

  DateTime? _activityDate;


// Zusätzliche Felder
  final TextEditingController _quantityPerFieldController = TextEditingController();
  final TextEditingController _quantityPerHaController = TextEditingController();
  final TextEditingController _nPerField = TextEditingController();
  final TextEditingController _nPerHa = TextEditingController();
  final TextEditingController _pPerField = TextEditingController();
  final TextEditingController _pPerHa = TextEditingController();
  final TextEditingController _kPerField = TextEditingController();
  final TextEditingController _kPerHa = TextEditingController();
  final TextEditingController _tractor = TextEditingController();
  final TextEditingController _fertilizerSpreader = TextEditingController();

  final TextEditingController _seedingDepth = TextEditingController();
  final TextEditingController _seedingQuantity = TextEditingController();
  final TextEditingController _plantProtectionName = TextEditingController();
  final TextEditingController _rowDistance = TextEditingController();
  final TextEditingController _seedingDistance = TextEditingController();
  final TextEditingController _germinationAbility = TextEditingController();
  final TextEditingController _goalQuantity = TextEditingController();
  final TextEditingController _spray= TextEditingController();

  final TextEditingController _machiningDepth = TextEditingController();

  //final bool _turning;
  final TextEditingController _usedMachine = TextEditingController();
  //final bool _ptoDriven;

  final TextEditingController _productName = TextEditingController();

  final TextEditingController _actualQuantity = TextEditingController();
  final TextEditingController _waterQuantityProcentage = TextEditingController();

  final TextEditingController _pest = TextEditingController();
  final TextEditingController _fungus = TextEditingController();
  final TextEditingController _problemWeeds = TextEditingController();
  final TextEditingController _countPerPlant = TextEditingController();
  final TextEditingController _plantPerQm = TextEditingController();
  final TextEditingController _nutrient = TextEditingController();

  final List<Map<String, String>> _entries = [];

  void _addEntry() {
    if (_descriptionController.text.isNotEmpty &&
        _selectedArea != "-1" &&
        _selectedActivity != "-1" &&
        _selectedPerson != "-1") {
      setState(() {
        if (widget.selectedArea == null ||
            widget.selectedActivity == null ||
            widget.selectedPerson == null ||
            widget.description == null) {
            _trackWorkstepsViewModel.addWorkstepActivity(
            int.parse(_selectedArea.toString()),
            _descriptionController.text,
            int.parse(_selectedPerson.toString()),
            int.parse(_selectedActivity.toString()),
            _activityDate ?? DateTime.now(),
            double.tryParse(_quantityPerFieldController.text),
            double.tryParse(_quantityPerHaController.text),
            double.tryParse(_nPerField.text),
            double.tryParse(_nPerHa.text),
            double.tryParse(_pPerField.text),
            double.tryParse(_pPerHa.text),
            double.tryParse(_kPerField.text),
            double.tryParse(_kPerHa.text),
            _fertilizerSpreader.text,
            double.tryParse(_seedingDepth.text),
            double.tryParse(_seedingQuantity.text),
            _plantProtectionName.text,
            double.tryParse(_rowDistance.text),
            double.tryParse(_seedingDistance.text),
            _germinationAbility.text,
            double.tryParse(_goalQuantity.text),
            _spray.text,
            double.tryParse(_machiningDepth.text),
            _productName.text,
            _selectedPlantProtectionType,
            double.tryParse(_actualQuantity.text),
            double.tryParse(_waterQuantityProcentage.text),
            _selectedGroundDamage,
            _pest.text,
            _fungus.text,
            _problemWeeds.text,
            _nutrient.text,
            double.tryParse(_countPerPlant.text),
            double.tryParse(_plantPerQm.text),
            int.parse(_selectedFertilizer!),
          );
        } else {
          _trackWorkstepsViewModel.updateWorkStepActivity(
            int.parse(_selectedArea.toString()),
            _descriptionController.text,
            int.parse(_selectedPerson.toString()),
            int.parse(_selectedActivity.toString()),
            widget.workstepActivityId!,
            widget.workstepId!,
            _activityDate ?? DateTime.now(),
            double.tryParse(_quantityPerFieldController.text),
            double.tryParse(_quantityPerHaController.text),
            double.tryParse(_nPerField.text),
            double.tryParse(_nPerHa.text),
            double.tryParse(_pPerField.text),
            double.tryParse(_pPerHa.text),
            double.tryParse(_kPerField.text),
            double.tryParse(_kPerHa.text),
            _fertilizerSpreader.text,
            double.tryParse(_seedingDepth.text),
            double.tryParse(_seedingQuantity.text),
            _plantProtectionName.text,
            double.tryParse(_rowDistance.text),
            double.tryParse(_seedingDistance.text),
            _germinationAbility.text,
            double.tryParse(_goalQuantity.text),
            _spray.text,
            double.tryParse(_machiningDepth.text),
            _productName.text,
            _selectedPlantProtectionType,
            double.tryParse(_actualQuantity.text),
            double.tryParse(_waterQuantityProcentage.text),
            _selectedGroundDamage,
            _pest.text,
            _fungus.text,
            _problemWeeds.text,
            _nutrient.text,
            double.tryParse(_countPerPlant.text),
            double.tryParse(_plantPerQm.text),
            int.parse(_selectedFertilizer!),
          );
        }
        _descriptionController.clear();
        _cropController.clear();

        _quantityPerFieldController.clear();
        _quantityPerHaController.clear();
        _nPerField.clear();
        _nPerHa.clear();
        _pPerField.clear();
        _pPerHa.clear();
        _kPerField.clear();
        _kPerHa.clear();

        _tractor.clear();
        _fertilizerSpreader.clear();

        _seedingDepth.clear();
        _seedingQuantity.clear();
        _plantProtectionName.clear();
        _rowDistance.clear();
        _seedingDistance.clear();
        _germinationAbility.clear();
        _goalQuantity.clear();
        _spray.clear();

        _machiningDepth.clear();
        _usedMachine.clear();

        _productName.clear();
        _actualQuantity.clear();
        _waterQuantityProcentage.clear();

        _pest.clear();
        _fungus.clear();
        _problemWeeds.clear();
        _countPerPlant.clear();
        _plantPerQm.clear();
        _nutrient.clear();
        _descriptionController.clear();
        _selectedArea = "-1";
        _selectedActivity = "-1";
        _selectedCulture = "-1";
        _selectedPerson = "-1";
        _selectedFertilizer = "-1";

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkstepSummary(title: "Meine Tätigkeiten"),
          ),
        );
      });

      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertText: "Erfolgreich gespeichert!",
            alertType: AlertType.success,
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alertText: "Alle Felder müssen ausgefüllt sein!",
            alertType: AlertType.error,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _trackWorkstepsViewModel = Provider.of<TrackWorkstepsViewModel>(
      context,
      listen: false,
    );
    if (widget.activityDate != null) {
      _activityDate = widget.activityDate;
    } else {
      _activityDate = DateTime.now();
    }

    _initData();
  }

  Future<void> _initData() async {
    final fieldsViewModel = Provider.of<FieldsViewModel>(
      context,
      listen: false,
    );
    final fertilizerViewModel = Provider.of<FertilizerViewModel>(
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
      fertilizerViewModel.getFertilizer(),
    ]);

    setState(() {
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
    if (_fieldSelected && _activityDate != null) {
      await _loadCropsName();
    }
  }

  Future<void> _loadCropsName() async {
    final cropsViewModel = Provider.of<CropsViewModel>(context, listen: false);
    await cropsViewModel.getCompleteCrops();
    selectedCropName = cropsViewModel.getCropName(
      int.parse(_selectedArea.toString()),
      _activityDate!,
    );
    _cropController.text = selectedCropName.toString();
    setState(() {});
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
                          final cropsViewModel = Provider.of<CropsViewModel>(
                            context,
                            listen: false,
                          );
                          _selectedArea = value ?? "-1";
                          if (_selectedArea != "-1") {
                            _fieldSelected = true;
                          } else {
                            _fieldSelected = false;
                          }
                          if (_fieldSelected) {
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
                        setState(() {
                          _activityDate = date;
                          if (_fieldSelected) {
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
                if (_activityDate != null &&
                    _selectedArea != "-1" &&
                    _cropController.text == "unbekannt") ...[
                  Warn(
                    warnText:
                        "Keine Kultur zur Feldauswahl und Datumauswahl gefunden!",
                  ),
                ],

                if (_activityDate != null &&
                    _selectedArea != "-1" &&
                    _cropController.text != "unbekannt") ...[
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
                        createNewView: ActivitiesEdit(
                          title: "Aktivität erstellen",
                          isCreate: true,
                        ),
                        onCreateNew: (context) async {
                          await Provider.of<ActivitiesViewModel>(
                            context,
                            listen: false,
                          ).getActivities();
                        },
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

                  Builder(
                    builder: (context) {
                      Widget additionalWidget;
                      switch (_selectedActivity) {
                        case "1": // Düngen körner
                        case "2":
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Ausbringmenge pro Feld (kg)", controller: _quantityPerFieldController, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Ausbringmenge pro Ha (kg)", controller: _quantityPerHaController, keyboardType: TextInputType.number, maxLine: 1),
                                Consumer<FertilizerViewModel>(
                                  builder: (context, fertilizerViewModel, child) {
                                    return FormDropdown(
                                      label: "Düngemittel", 
                                      value: _selectedFertilizer!, 
                                      createNewView: FertilizerEdit(
                                        title: "Düngemittel erstellen",
                                        isCreate: true,
                                      ),
                                      onCreateNew: (context) async {
                                        await Provider.of<FertilizerViewModel>(
                                          context,
                                          listen: false,
                                        ).getFertilizer();
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: "-1",
                                          child: Text("Düngemittel wählen"),
                                        ),
                                        ...fertilizerViewModel.fertilizerList.map(
                                          (fertilizer) => DropdownMenuItem(
                                            value: fertilizer.id.toString(),
                                            child: Text(fertilizer.fertilizerName),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() => _selectedFertilizer = value ?? "-1");
                                      },
                                    );
                                  },
                                ),
                                FormTextfieldDisabled(label: "N pro Feld", textController: _nPerField),
                                FormTextfieldDisabled(label: "N pro Ha", textController: _nPerHa),
                                FormTextfieldDisabled(label: "K pro Feld", textController: _pPerField),
                                FormTextfieldDisabled(label: "K pro Ha", textController: _pPerHa),
                                FormTextfieldDisabled(label: "P pro Feld", textController: _kPerField),
                                FormTextfieldDisabled(label: "P pro Ha", textController: _kPerHa),
                                FormTextfield(label: "Verwendeter Traktor", controller: _tractor, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Verwendeter Düngerstreuer", controller: _fertilizerSpreader, keyboardType: TextInputType.text, maxLine: 1),
                              ],
                            ),
                          );
                        case "3": //saat
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Saattiefe (cm)", controller: _seedingDepth, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Saatmenge (Körner / Quadratmeter)", controller: _seedingQuantity, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Beizung", controller: _plantProtectionName, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Reihenabstand (cm)", controller: _rowDistance, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Abstand Körner in einer Reihe (cm)", controller: _seedingDistance, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Keimfähigkeit", controller: _germinationAbility, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Ziel Auflaufmenge", controller: _goalQuantity, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Verwendeter Traktor", controller: _tractor, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Verwendete Spritze", controller: _spray, keyboardType: TextInputType.text, maxLine: 1),
                              ],
                            ),
                          );
                        case "4": //bodenbearbeitung
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Bearbeittiefe", controller: _machiningDepth, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Verwendeter Traktor", controller: _seedingQuantity, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Verwendete Maschine", controller: _seedingDepth, keyboardType: TextInputType.text, maxLine: 1),
                                //TODO Bool Feld
                              ],
                            ),
                          );

                        case "5": //Saatbeetbearbeitung 
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Bearbeittiefe", controller: _machiningDepth, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Verwendeter Traktor", controller: _tractor, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Verwendete Maschine", controller: _usedMachine, keyboardType: TextInputType.text, maxLine: 1),
                                //TODO Bool Feld
                              ],
                            ),
                          );
                        case "6": //PSM
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Wirkstoff", controller: _plantProtectionName, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Produktname", controller: _productName, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Ausbringmenge pro Feld (kg)", controller: _quantityPerFieldController, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Ausbringmenge pro Ha (kg)", controller: _quantityPerHaController, keyboardType: TextInputType.number, maxLine: 1),
                                FormDropdown(
                                  label: "Beizungstyp", 
                                  value: _selectedPlantProtectionType!,                                   
                                  items: [
                                    DropdownMenuItem(
                                      value: "-1",
                                      child: Text("Beizungstyp wählen"),
                                    ),
                                  ],                              
                                  onChanged: (value) {
                                    setState(() => _selectedPlantProtectionType = value ?? "-1");
                                  },
                                ),
                              ],
                            ),
                          );
                        
                        case "7": //Ernte
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Ertrag (dt/ha)", controller: _actualQuantity, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Wassergehalt (%)", controller: _waterQuantityProcentage, keyboardType: TextInputType.number, maxLine: 1),
                                FormDropdown(
                                  label: "Bodenschaden", 
                                  value: _selectedGroundDamage!,                                   
                                  items: [
                                    DropdownMenuItem(
                                      value: "-1",
                                      child: Text("Bodenschaden wählen"),
                                    ),
                                  ],                              
                                  onChanged: (value) {
                                    setState(() => _selectedGroundDamage = value ?? "-1");
                                  },
                                ),
                              ],
                            ),
                          );
                        case "8": //Kontrolle
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextfield(label: "Gesichtete Schädlinge", controller: _pest, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Gesichtete Pilzkrankheit", controller: _fungus, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Gesichtetes Unkraut", controller: _problemWeeds, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Gesichtete Nährstoffmängel", controller: _nutrient, keyboardType: TextInputType.text, maxLine: 1),
                                FormTextfield(label: "Anzahl pro Pflanzen", controller: _countPerPlant, keyboardType: TextInputType.number, maxLine: 1),
                                FormTextfield(label: "Befallene Pflanzen pro Quadratmeter", controller: _plantPerQm, keyboardType: TextInputType.number, maxLine: 1),
                              ],
                            ),
                          );
                        default:
                          additionalWidget = const SizedBox.shrink();
                          break;
                      }
                      return additionalWidget;
                    },
                  ),

                  Consumer<PersonViewModel>(
                    builder: (context, personViewModel, child) {
                      return FormDropdown(
                        label: "Person",
                        value: _selectedPerson!,
                        createNewView: PersonEdit(
                          title: "Person erstellen",
                          isCreate: true,
                        ),
                        onCreateNew: (context) async {
                          await Provider.of<PersonViewModel>(
                            context,
                            listen: false,
                          ).getPerson();
                        },
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
