import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:dibano/ui/widgets/components/filter_dialog.dart';
import 'package:dibano/ui/view_model/workstep_summary.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/components/warn_card.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/activity_card.dart';
import 'package:provider/provider.dart';

class WorkstepSummary extends StatefulWidget {
  final String title;
  final List<String>? selectedFields;
  final List<String>? selectedActivities;
  final List<String>? selectedPersons;
  final List<String>? selectedCrops;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isFiltered;

  const WorkstepSummary({
    super.key,
    required this.title,
    this.selectedFields,
    this.selectedActivities,
    this.selectedPersons,
    this.selectedCrops,
    this.startDate,
    this.endDate,
    this.isFiltered = false,
  });
  @override
  State<WorkstepSummary> createState() => _WorkstepSummaryState();
}

class _WorkstepSummaryState extends State<WorkstepSummary> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isFiltered == true) {
        Provider.of<WorkstepSummaryViewModel>(
          context,
          listen: false,
        ).filterCompleteWorkstepsByIds(
          selectedFields: widget.selectedFields,
          selectedCrops: widget.selectedCrops,
          selectedActivities: widget.selectedActivities,
          selectedPersonIds: widget.selectedPersons,
          selectedStartDate: widget.startDate,
          selectedEndDate: widget.endDate,
        );
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
                      size: 28,
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
                    child: const Text("Filtern und Teilen"),
                  ),
                if (widget.isFiltered)
                  PopupMenuButton<int>(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: FarmColors.darkGreenIntense,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          // Aktion für "Per Email senden"
                          break;
                        case 2:
                          // Aktion für "Als PDF speichern"
                          break;
                        case 3:
                          // Aktion für "Cloud-Dienste"
                          break;
                        case 4:
                          // Aktion für "Per Schnittstelle weiterleiten"
                          break;
                        default:
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Per Email senden'),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text('Als PDF speichern'),
                          ),
                          const PopupMenuItem(
                            value: 3,
                            child: Text('Cloud-Dienste'),
                          ),
                          const PopupMenuItem(
                            value: 4,
                            child: Text('Per Schnittstelle weiterleiten'),
                          ),
                        ],
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
                      widget.isFiltered == true
                          ? workstepSummaryViewModel.filteredWorksteps
                          : workstepSummaryViewModel.completeWorksteps;

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
                                        "Keine Einträge für die aktuelle Filterung gefunden",
                                  ),
                                ],
                                for (var workstep in worksteps)
                                  ActivityCard(
                                    isDeletable: !widget.isFiltered,
                                    isCheckable: widget.isFiltered,
                                    workstep: workstep,
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => TrackWorksteps(
                                                title: "Tätigkeit bearbeiten",
                                                selectedArea:
                                                    workstep.id.toString(),
                                                selectedPerson:
                                                    workstep.personId
                                                        .toString(),
                                                selectedActivity:
                                                    workstep.activityId
                                                        .toString(),
                                                description:
                                                    workstep.description
                                                        .toString(),
                                                workstepActivityId:
                                                    workstep.workstepActivityId,
                                                workstepId: workstep.workstepId,
                                                activityDate: DateTime.tryParse(
                                                  workstep.date,
                                                ),
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
