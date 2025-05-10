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
    this.selectedCropName,
    this.selectedActivity,
    this.selectedPerson,
    this.selectedFertilizer,
    this.selectedPlantProtectionType,
    this.selectedGroundDamage,
    this.description,
    this.workstepActivityId,
    this.workstepId,
    this.activityDate,
    this.quantityPerField,
    this.quantityPerHa,
    this.nPerField,
    this.nPerHa,
    this.pPerField,
    this.pPerHa,
    this.kPerField,
    this.kPerHa,
    this.tractor,
    this.fertilizerSpreader,
    this.seedingDepth,
    this.seedingQuantity,
    this.plantProtectionName,
    this.rowDistance,
    this.seedingDistance,
    this.germinationAbility,
    this.goalQuantity,
    this.spray,
    this.machiningDepth,
    this.usedMachine,
    this.productName,
    this.actualQuantity,
    this.waterQuantityProcentage,
    this.pest,
    this.fungus,
    this.problemWeeds,
    this.countPerPlant,
    this.plantPerQm,
    this.nutrient,
    this.turning,
    this.ptoDriven,
  });

  final String title;
  final String? selectedArea;
  final String? selectedCropName;
  final String? selectedActivity;
  final String? selectedPerson;
  final String? selectedFertilizer;
  final String? selectedPlantProtectionType;
  final String? selectedGroundDamage;
  final String? description;
  final int? workstepActivityId;
  final int? workstepId;
  final DateTime? activityDate;
  final String? quantityPerField;
  final String? quantityPerHa;
  final String? nPerField;
  final String? nPerHa;
  final String? pPerField;
  final String? pPerHa;
  final String? kPerField;
  final String? kPerHa;
  final String? tractor;
  final String? fertilizerSpreader;
  final String? seedingDepth;
  final String? seedingQuantity;
  final String? plantProtectionName;
  final String? rowDistance;
  final String? seedingDistance;
  final String? germinationAbility;
  final String? goalQuantity;
  final String? spray;
  final String? machiningDepth;
  final String? usedMachine;
  final String? productName;
  final String? actualQuantity;
  final String? waterQuantityProcentage;
  final String? pest;
  final String? fungus;
  final String? problemWeeds;
  final String? countPerPlant;
  final String? plantPerQm;
  final String? nutrient;
  final bool? turning;
  final bool? ptoDriven;

  @override
  State<TrackWorksteps> createState() => _TrackWorkstepsState();
}

class _TrackWorkstepsState extends State<TrackWorksteps> {
  late TrackWorkstepsViewModel _trackWorkstepsViewModel;

  bool _fieldSelected = false;

  double? _fieldSize;

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
  final TextEditingController _quantityPerFieldController =
      TextEditingController();
  final TextEditingController _quantityPerHaController =
      TextEditingController();
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
  final TextEditingController _spray = TextEditingController();

  final TextEditingController _machiningDepth = TextEditingController();

  bool _turning = false;
  final TextEditingController _usedMachine = TextEditingController();
  bool _ptoDriven = false;

  final TextEditingController _productName = TextEditingController();

  final TextEditingController _actualQuantity = TextEditingController();
  final TextEditingController _waterQuantityProcentage =
      TextEditingController();

  final TextEditingController _pest = TextEditingController();
  final TextEditingController _fungus = TextEditingController();
  final TextEditingController _problemWeeds = TextEditingController();
  final TextEditingController _countPerPlant = TextEditingController();
  final TextEditingController _plantPerQm = TextEditingController();
  final TextEditingController _nutrient = TextEditingController();

  void _addEntry() {
    if (_selectedArea != "-1") {
      setState(() {
        if (widget.selectedArea == null) {
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
            _tractor.text,
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
            _usedMachine.text,
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
            _turning,
            _ptoDriven,
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
            _tractor.text,
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
            _usedMachine.text,
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
            _turning,
            _ptoDriven,
          );
        }
        _descriptionController.clear();
        _cropController.clear();
        _descriptionController.clear();
        _selectedArea = "-1";
        _selectedActivity = "-1";
        _selectedCulture = "-1";
        _selectedPerson = "-1";
        clearFields();
        Navigator.pushReplacement(
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
    }
  }

  void clearFields() {
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
    _turning = false;
    _ptoDriven = false;
    _pest.clear();
    _fungus.clear();
    _problemWeeds.clear();
    _countPerPlant.clear();
    _plantPerQm.clear();
    _nutrient.clear();
    _selectedFertilizer = "-1";
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
      if (widget.selectedCropName != null) {
        _selectedCulture = widget.selectedCropName;
        _cropController.text = widget.selectedCropName!;
      }
      if (widget.selectedActivity != null) {
        _selectedActivity = widget.selectedActivity;
      }
      if (widget.selectedPerson != null) {
        _selectedPerson = widget.selectedPerson;
      }
      if (widget.selectedFertilizer != null) {
        _selectedFertilizer = widget.selectedFertilizer;
      }
      if (widget.selectedPlantProtectionType != null) {
        _selectedPlantProtectionType = widget.selectedPlantProtectionType;
      }
      if (widget.selectedGroundDamage != null) {
        _selectedGroundDamage = widget.selectedGroundDamage;
      }
      if (widget.description != null) {
        _descriptionController.text = widget.description!;
      }
      if (widget.activityDate != null) {
        _activityDate = widget.activityDate;
      }
      if (widget.quantityPerField != null) {
        _quantityPerFieldController.text = widget.quantityPerField!;
      }
      if (widget.quantityPerHa != null) {
        _quantityPerHaController.text = widget.quantityPerHa!;
      }
      if (widget.nPerField != null) {
        _nPerField.text = widget.nPerField!;
      }
      if (widget.nPerHa != null) {
        _nPerHa.text = widget.nPerHa!;
      }
      if (widget.pPerField != null) {
        _pPerField.text = widget.pPerField!;
      }
      if (widget.pPerHa != null) {
        _pPerHa.text = widget.pPerHa!;
      }
      if (widget.kPerField != null) {
        _kPerField.text = widget.kPerField!;
      }
      if (widget.kPerHa != null) {
        _kPerHa.text = widget.kPerHa!;
      }
      if (widget.tractor != null) {
        _tractor.text = widget.tractor!;
      }
      if (widget.usedMachine != null) {
        _usedMachine.text = widget.usedMachine!;
      }
      if (widget.fertilizerSpreader != null) {
        _fertilizerSpreader.text = widget.fertilizerSpreader!;
      }
      if (widget.seedingDepth != null) {
        _seedingDepth.text = widget.seedingDepth!;
      }
      if (widget.seedingQuantity != null) {
        _seedingQuantity.text = widget.seedingQuantity!;
      }
      if (widget.rowDistance != null) {
        _rowDistance.text = widget.rowDistance!;
      }
      if (widget.seedingDistance != null) {
        _seedingDistance.text = widget.seedingDistance!;
      }
      if (widget.germinationAbility != null) {
        _germinationAbility.text = widget.germinationAbility!;
      }
      if (widget.goalQuantity != null) {
        _goalQuantity.text = widget.goalQuantity!;
      }
      if (widget.plantProtectionName != null) {
        _plantProtectionName.text = widget.plantProtectionName!;
      }
      if (widget.spray != null) {
        _spray.text = widget.spray!;
      }
      if (widget.productName != null) {
        _productName.text = widget.productName!;
      }
      if (widget.machiningDepth != null) {
        _machiningDepth.text = widget.machiningDepth!;
      }
      if (widget.actualQuantity != null) {
        _actualQuantity.text = widget.actualQuantity!;
      }
      if (widget.waterQuantityProcentage != null) {
        _waterQuantityProcentage.text = widget.waterQuantityProcentage!;
      }
      if (widget.pest != null) {
        _pest.text = widget.pest!;
      }
      if (widget.fungus != null) {
        _fungus.text = widget.fungus!;
      }
      if (widget.problemWeeds != null) {
        _problemWeeds.text = widget.problemWeeds!;
      }
      if (widget.nutrient != null) {
        _nutrient.text = widget.nutrient!;
      }
      if (widget.countPerPlant != null) {
        _countPerPlant.text = widget.countPerPlant!;
      }
      if (widget.plantPerQm != null) {
        _plantPerQm.text = widget.plantPerQm!;
      }
      if (widget.turning != null) {
        _turning = widget.turning!;
      }
      if (widget.ptoDriven != null) {
        _ptoDriven = widget.ptoDriven!;
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

  void reloadCalculatedFields(
    String? value,
    FertilizerViewModel fertilizerViewModel,
  ) {
    _selectedFertilizer = value ?? "-1";
    if (value != "-1") {
      if (_fieldSize != null) {
        if (double.tryParse(_quantityPerFieldController.text) != null &&
            double.tryParse(_quantityPerFieldController.text)! > 0) {
          _nPerField.text =
              (fertilizerViewModel.calcNPerField(value!) *
                      double.parse(_quantityPerFieldController.text))
                  .toString();
          _pPerField.text =
              (fertilizerViewModel.calcPPerField(value) *
                      double.parse(_quantityPerFieldController.text))
                  .toString();
          _kPerField.text =
              (fertilizerViewModel.calcKPerField(value) *
                      double.parse(_quantityPerFieldController.text))
                  .toString();
        }
        if (double.tryParse(_quantityPerHaController.text) != null &&
            double.tryParse(_quantityPerHaController.text)! > 0) {
          _nPerHa.text =
              (fertilizerViewModel.getN(value!) *
                      double.parse(_quantityPerHaController.text))
                  .toString();
          _pPerHa.text =
              (fertilizerViewModel.getP(value) *
                      double.parse(_quantityPerHaController.text))
                  .toString();
          _kPerHa.text =
              (fertilizerViewModel.getK(value) *
                      double.parse(_quantityPerHaController.text))
                  .toString();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        showDialog(
          context: context,
          builder:
              (context) => CustomAlertDialog(
                alertText:
                    "Möchten Sie die Seite verlassen, ohne zu speichern?",
                alertType: AlertType.shouldLeave,
                onDelete: () {
                  Navigator.of(context).pop();
                },
              ),
        );
      },

      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(title: widget.title, messageOnLeave: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FieldsViewModel>(
                    builder: (context, fieldsViewModel, child) {
                      if (fieldsViewModel.fields.isEmpty) {
                        return const Center(
                          child: Warn(
                            warnText:
                                "Keine Felder gefunden! Bitte erfassen Sie zuerst Felder und Kulturen unter \"Mein Bauernhof\".",
                          ),
                        );
                      }
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
                              _fieldSize = cropsViewModel.getFieldSize(
                                _selectedArea!,
                              );
                            } else {
                              _fieldSelected = false;
                            }
                            if (_fieldSelected) {
                              selectedCropName = cropsViewModel.getCropName(
                                int.parse(_selectedArea.toString()),
                                _activityDate!,
                              );
                              _cropController.text =
                                  selectedCropName.toString();
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
                              _cropController.text =
                                  selectedCropName.toString();
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
                          "Keine Kultur zur Feldauswahl und Datumauswahl gefunden! Bitte erfassen Sie zuerst eine Kultur zum gewählten Feld und Datum unter \"Mein Bauernhof\".",
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
                      enableMic: true,
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
                            clearFields();
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
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Ausbringmenge pro Feld (kg)",
                                    controller: _quantityPerFieldController,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedFertilizer = "-1";
                                        if (_quantityPerFieldController.text !=
                                                "" &&
                                            _quantityPerFieldController.text !=
                                                null &&
                                            _fieldSize != "0" &&
                                            _fieldSize != null) {
                                          _quantityPerHaController.text =
                                              (double.parse(
                                                        _quantityPerFieldController
                                                            .text,
                                                      ) /
                                                      _fieldSize!)
                                                  .toString();
                                        } else {
                                          _quantityPerFieldController.text = "";
                                          _quantityPerHaController.text = "";
                                        }
                                        _nPerField.text = "";
                                        _nPerHa.text = "";
                                        _pPerField.text = "";
                                        _pPerHa.text = "";
                                        _kPerField.text = "";
                                        _kPerHa.text = "";
                                      });
                                    },
                                  ),
                                  FormTextfieldDisabled(
                                    label: "Ausbringmenge pro Ha (kg)",
                                    textController: _quantityPerHaController,
                                  ),
                                  Consumer<FertilizerViewModel>(
                                    builder: (
                                      context,
                                      fertilizerViewModel,
                                      child,
                                    ) {
                                      return FormDropdown(
                                        label: "Düngemittel",
                                        value: _selectedFertilizer!,
                                        createNewView: FertilizerEdit(
                                          title: "Düngemittel erstellen",
                                          isCreate: true,
                                        ),
                                        onCreateNew: (context) async {
                                          await Provider.of<
                                            FertilizerViewModel
                                          >(
                                            context,
                                            listen: false,
                                          ).getFertilizer();
                                        },
                                        items: [
                                          DropdownMenuItem(
                                            value: "-1",
                                            child: Text("Düngemittel wählen"),
                                          ),
                                          ...fertilizerViewModel.fertilizerList
                                              .map(
                                                (
                                                  fertilizer,
                                                ) => DropdownMenuItem(
                                                  value:
                                                      fertilizer.id.toString(),
                                                  child: Text(
                                                    fertilizer.fertilizerName,
                                                  ),
                                                ),
                                              ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            reloadCalculatedFields(
                                              value,
                                              fertilizerViewModel,
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  FormTextfieldDisabled(
                                    label: "N pro Feld",
                                    textController: _nPerField,
                                  ),
                                  FormTextfieldDisabled(
                                    label: "N pro Ha",
                                    textController: _nPerHa,
                                  ),
                                  FormTextfieldDisabled(
                                    label: "K pro Feld",
                                    textController: _pPerField,
                                  ),
                                  FormTextfieldDisabled(
                                    label: "K pro Ha",
                                    textController: _pPerHa,
                                  ),
                                  FormTextfieldDisabled(
                                    label: "P pro Feld",
                                    textController: _kPerField,
                                  ),
                                  FormTextfieldDisabled(
                                    label: "P pro Ha",
                                    textController: _kPerHa,
                                  ),
                                  FormTextfield(
                                    label: "Verwendeter Traktor",
                                    controller: _tractor,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendeter Düngerstreuer",
                                    controller: _fertilizerSpreader,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                ],
                              ),
                            );
                          case "3": //saat
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Saattiefe (cm)",
                                    controller: _seedingDepth,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Saatmenge (Körner / Quadratmeter)",
                                    controller: _seedingQuantity,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Beizung",
                                    controller: _plantProtectionName,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Reihenabstand (cm)",
                                    controller: _rowDistance,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Abstand Körner in einer Reihe (cm)",
                                    controller: _seedingDistance,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Keimfähigkeit",
                                    controller: _germinationAbility,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Ziel Auflaufmenge (Anzahl)",
                                    controller: _goalQuantity,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendeter Traktor",
                                    controller: _tractor,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendete Spritze",
                                    controller: _spray,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                ],
                              ),
                            );
                          case "4": //bodenbearbeitung
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Bearbeittiefe (cm)",
                                    controller: _machiningDepth,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendeter Traktor",
                                    controller: _tractor,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendete Maschine",
                                    controller: _usedMachine,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text("Wendend"),
                                    value: _turning,
                                    onChanged: (bool? newTurningValue) {
                                      setState(() {
                                        _turning = newTurningValue ?? false;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            );
                          case "5": //Saatbeetbearbeitung
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Bearbeittiefe (cm)",
                                    controller: _machiningDepth,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendeter Traktor",
                                    controller: _tractor,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Verwendete Maschine",
                                    controller: _usedMachine,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text("Zapftriebwellenbetrieben"),
                                    value: _ptoDriven,
                                    onChanged: (bool? newPtoValue) {
                                      setState(() {
                                        _ptoDriven = newPtoValue ?? false;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            );
                          case "6": //PSM
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Wirkstoff",
                                    controller: _plantProtectionName,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Produktname",
                                    controller: _productName,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Ausbringmenge pro Feld (l)",
                                    controller: _quantityPerFieldController,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        if (_quantityPerFieldController != "" &&
                                            _quantityPerFieldController !=
                                                null &&
                                            _fieldSize != "0" &&
                                            _fieldSize != null) {
                                          _quantityPerHaController.text =
                                              (double.parse(
                                                        _quantityPerFieldController
                                                            .text,
                                                      ) /
                                                      _fieldSize!)
                                                  .toString();
                                        } else {
                                          _quantityPerHaController.text = "";
                                        }
                                      });
                                    },
                                  ),
                                  FormTextfieldDisabled(
                                    label: "Ausbringmenge pro Ha (l)",
                                    textController: _quantityPerHaController,
                                  ),
                                  FormDropdown(
                                    label: "Beizungstyp",
                                    value: _selectedPlantProtectionType!,
                                    items: [
                                      DropdownMenuItem(
                                        value: "-1",
                                        child: Text("Beizungstyp wählen"),
                                      ),
                                      DropdownMenuItem(
                                        value: "0",
                                        child: Text("Fungizid"),
                                      ),
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Text("Insektizid"),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Text("Herbizid"),
                                      ),
                                      DropdownMenuItem(
                                        value: "3",
                                        child: Text("Kombination"),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(
                                        () =>
                                            _selectedPlantProtectionType =
                                                value ?? "-1",
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );

                          case "7": //Ernte
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Ertrag (dt/ha)",
                                    controller: _actualQuantity,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Wassergehalt (%)",
                                    controller: _waterQuantityProcentage,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormDropdown(
                                    label: "Bodenschaden",
                                    value: _selectedGroundDamage!,
                                    items: [
                                      DropdownMenuItem(
                                        value: "-1",
                                        child: Text("Bodenschaden wählen"),
                                      ),
                                      DropdownMenuItem(
                                        value: "0",
                                        child: Text("Kein Schaden vorhanden"),
                                      ),
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Text(
                                          "Kleine Schäden (kaum sichtbar) ",
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Text(
                                          "Mittlere Schädem (gut sichtbar)",
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "3",
                                        child: Text(
                                          "Grosse Schäden (tiefe Gräben)",
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(
                                        () =>
                                            _selectedGroundDamage =
                                                value ?? "-1",
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          case "8": //Kontrolle
                            //clearFields();
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextfield(
                                    label: "Gesichtete Schädlinge (Art)",
                                    controller: _pest,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Gesichtete Pilzkrankheit (Art)",
                                    controller: _fungus,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Gesichtetes Unkraut (Art)",
                                    controller: _problemWeeds,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Gesichtete Nährstoffmängel (Art)",
                                    controller: _nutrient,
                                    keyboardType: TextInputType.text,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label: "Anzahl pro Pflanzen (Anzahl)",
                                    controller: _countPerPlant,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                  FormTextfield(
                                    label:
                                        "Befallene Pflanzen pro Quadratmeter (Anzahl)",
                                    controller: _plantPerQm,
                                    keyboardType: TextInputType.number,
                                    maxLine: 1,
                                  ),
                                ],
                              ),
                            );
                          default:
                            //clearFields();
                            additionalWidget = const SizedBox.shrink();
                            break;
                        }
                        return additionalWidget;
                      },
                    ),

                    Consumer<PersonViewModel>(
                      builder: (context, personViewModel, child) {
                        return FormDropdown(
                          label: "Mitarbeiter",
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
                    CustomButtonLarge(onPressed: _addEntry, text: "Speichern"),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
