import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:dibano/data/pdf/pdf_api.dart';
import 'package:dibano/data/pdf/save_pdf.dart';
import 'package:dibano/ui/widgets/components/filter_dialog.dart';
import 'package:dibano/ui/view_model/workstep_summary.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/warn_card.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/activity_card.dart';
import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:provider/provider.dart';

class WorkstepSummary extends StatefulWidget {
  final String title;
  final List<String?>? selectedFields;
  final List<String?>? selectedActivities;
  final List<String?>? selectedPersons;
  final List<String?>? selectedCrops;
  final DateTime? startDate;
  final DateTime? endDate;
  bool isFiltered;
  final String? searchString;
  final List<String?>? selectedFertilizers;

  WorkstepSummary({
    super.key,
    required this.title,
    this.selectedFields = const [],
    this.selectedActivities = const [],
    this.selectedPersons = const [],
    this.selectedCrops = const [],
    this.selectedFertilizers = const [],
    this.startDate,
    this.endDate,
    this.isFiltered = false,
    this.searchString,
  });

  @override
  State<WorkstepSummary> createState() => _WorkstepSummaryState();
}

class _WorkstepSummaryState extends State<WorkstepSummary> {
  late List<CompleteWorkstep> _completeWorksteps;
  late List<String?> _personNames;
  final Map<int, bool> _checkedWorksteps = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isFiltered == true) {
        if (widget.searchString != null && widget.searchString!.isNotEmpty) {
          Provider.of<WorkstepSummaryViewModel>(
            context,
            listen: false,
          ).searchWorksteps(widget.searchString!);
        } else {
          Provider.of<WorkstepSummaryViewModel>(
            context,
            listen: false,
          ).filterCompleteWorkstepsByIds(
            selectedFields: widget.selectedFields,
            selectedCrops: widget.selectedCrops,
            selectedActivities: widget.selectedActivities,
            selectedPersonIds: widget.selectedPersons,
            selectedFertilizers: widget.selectedFertilizers,
            selectedStartDate: widget.startDate,
            selectedEndDate: widget.endDate,
          );
        }
      } else {
        Provider.of<WorkstepSummaryViewModel>(
          context,
          listen: false,
        ).getCompleteWorksteps();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 10.0,
              right: 10.0,
              bottom: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: FarmColors.darkGreenIntense,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: FarmColors.darkGreenIntense,
                    width: 2.0,
                  ),
                ),
                labelText: 'Suchen...',
                labelStyle: const TextStyle(color: FarmColors.darkGreenIntense),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (String query) {
                setState(() {
                  if (query.isNotEmpty) {
                    widget.isFiltered = true;
                    Provider.of<WorkstepSummaryViewModel>(
                      context,
                      listen: false,
                    ).searchWorksteps(query);

                    _completeWorksteps =
                        Provider.of<WorkstepSummaryViewModel>(
                          context,
                          listen: false,
                        ).filteredWorksteps;
                  } else {
                    widget.isFiltered = false;
                    Provider.of<WorkstepSummaryViewModel>(
                      context,
                      listen: false,
                    ).getCompleteWorksteps();

                    _completeWorksteps =
                        Provider.of<WorkstepSummaryViewModel>(
                          context,
                          listen: false,
                        ).completeWorksteps;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
              bottom: 0.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PopupMenuButton<int>(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: FarmColors.darkGreenIntense,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.sort,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                  onSelected: (value) {
                    WorkstepSummaryViewModel workstepSummaryViewModel =
                        Provider.of<WorkstepSummaryViewModel>(
                          context,
                          listen: false,
                        );
                    workstepSummaryViewModel.sortCompleteWorksteps(value);
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Nach Feld sortieren'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('Nach Aktivität sortieren'),
                        ),
                        const PopupMenuItem(
                          value: 3,
                          child: Text('Nach Datum sortieren'),
                        ),
                      ],
                ),
                if (!widget.isFiltered)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FarmColors.darkGreenIntense,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterDialog();
                        },
                      );
                    },
                    child: const Text(
                      "Filtern und Exportieren",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                if (widget.isFiltered)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FarmColors.darkGreenIntense,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    onPressed: () async {
                      final checkedWorksteps =
                          _completeWorksteps
                              .where(
                                (workstep) =>
                                    _checkedWorksteps[workstep.workstepId] ??
                                    true,
                              )
                              .toList();
                      final pdf = await PdfApi.generateTablePdf(
                        checkedWorksteps,
                        widget.selectedActivities,
                        widget.selectedCrops,
                        widget.selectedFields,
                        _personNames,
                      );
                      SavePdf.openPdf(pdf);
                    },
                    child: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                      size: 32.0,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<WorkstepSummaryViewModel>(
                builder: (context, workstepSummaryViewModel, child) {
                  final worksteps =
                      widget.isFiltered
                          ? workstepSummaryViewModel.filteredWorksteps
                          : workstepSummaryViewModel.completeWorksteps;
                  _completeWorksteps =
                      workstepSummaryViewModel.filteredWorksteps;
                  if (widget.selectedPersons != null) {
                    _personNames = workstepSummaryViewModel.getPersonNameById(
                      widget.selectedPersons!,
                    );
                  } else {
                    _personNames = [];
                  }
                  return Center(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 24),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                if (worksteps.isEmpty && widget.isFiltered) ...[
                                  Warn(
                                    warnText:
                                        "Keine Einträge für die aktuelle Filterung oder Suche gefunden",
                                  ),
                                ],
                                for (var workstep in worksteps)
                                  ActivityCard(
                                    checkboxState:
                                        _checkedWorksteps[workstep
                                            .workstepId] ??
                                        true,
                                    isDeletable: !widget.isFiltered,
                                    isCheckable: widget.isFiltered,
                                    workstep: workstep,
                                    checkValueChanged: (bool checkValue) {
                                      setState(() {
                                        _checkedWorksteps[workstep.workstepId] =
                                            checkValue;
                                      });
                                    },
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => TrackWorksteps(
                                                title: "Tätigkeit bearbeiten",
                                                selectedArea:
                                                    workstep.id.toString(),
                                                selectedCropName:
                                                    workstep.cropName,
                                                selectedActivity:
                                                    workstep.activityId
                                                        .toString(),
                                                selectedPerson:
                                                    workstep.personId
                                                        .toString(),
                                                selectedFertilizer:
                                                    workstep.fertilizerId
                                                        ?.toString(),
                                                selectedPlantProtectionType:
                                                    workstep
                                                        .plantProtectionType,
                                                selectedGroundDamage:
                                                    workstep.groundDamage,
                                                description:
                                                    workstep.description,
                                                workstepActivityId:
                                                    workstep.workstepActivityId,
                                                workstepId: workstep.workstepId,
                                                activityDate: DateTime.tryParse(
                                                  workstep.date,
                                                ),
                                                quantityPerField:
                                                    workstep.quantityPerField
                                                        ?.toString(),
                                                quantityPerHa:
                                                    workstep.quantityPerHa
                                                        ?.toString(),
                                                nPerField:
                                                    workstep.nPerField
                                                        ?.toString(),
                                                nPerHa:
                                                    workstep.nPerHa?.toString(),
                                                pPerField:
                                                    workstep.pPerField
                                                        ?.toString(),
                                                pPerHa:
                                                    workstep.pPerHa?.toString(),
                                                kPerField:
                                                    workstep.kPerField
                                                        ?.toString(),
                                                kPerHa:
                                                    workstep.kPerHa?.toString(),
                                                tractor: workstep.tractor,
                                                fertilizerSpreader:
                                                    workstep.fertilizerSpreader,
                                                seedingDepth:
                                                    workstep.seedingDepth
                                                        ?.toString(),
                                                seedingQuantity:
                                                    workstep.seedingQuantity
                                                        ?.toString(),
                                                plantProtectionName:
                                                    workstep
                                                        .plantProtectionName,
                                                rowDistance:
                                                    workstep.rowDistance
                                                        ?.toString(),
                                                seedingDistance:
                                                    workstep.seedingDistance
                                                        ?.toString(),
                                                germinationAbility:
                                                    workstep.germinationAbility
                                                        ?.toString(),
                                                goalQuantity:
                                                    workstep.goalQuantity
                                                        ?.toString(),
                                                spray: workstep.spray,
                                                machiningDepth:
                                                    workstep.machiningDepth
                                                        ?.toString(),
                                                usedMachine:
                                                    workstep.usedMachine,
                                                productName:
                                                    workstep.productName,
                                                actualQuantity:
                                                    workstep.actualQuantity
                                                        ?.toString(),
                                                waterQuantityProcentage:
                                                    workstep
                                                        .waterQuantityProcentage
                                                        ?.toString(),
                                                pest: workstep.pest,
                                                fungus: workstep.fungal,
                                                problemWeeds:
                                                    workstep.problemWeeds,
                                                countPerPlant:
                                                    workstep.countPerPlant
                                                        ?.toString(),
                                                plantPerQm:
                                                    workstep.plantPerQm
                                                        ?.toString(),
                                                nutrient: workstep.nutrient,
                                                turning:
                                                    workstep.turning == 1
                                                        ? true
                                                        : false,
                                                ptoDriven:
                                                    workstep.ptoDriven == 1
                                                        ? true
                                                        : false,
                                              ),
                                        ),
                                      );
                                      if (result == true) {
                                        await Provider.of<
                                          WorkstepSummaryViewModel
                                        >(
                                          context,
                                          listen: false,
                                        ).getCompleteWorksteps();
                                      }
                                    },
                                    onDelete: () {
                                      setState(() {
                                        workstepSummaryViewModel.remove(
                                          workstep.workstepId,
                                        );
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackWorksteps(title: "Tätigkeit erfassen"),
            ),
          );
          if (result == true) {
            await Provider.of<WorkstepSummaryViewModel>(
              context,
              listen: false,
            ).getCompleteWorksteps();
          }
        },
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 36.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
