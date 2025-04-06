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
  late List<CompleteWorkstep> _completeWorksteps;
  late List<String> _personNames;

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
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Suchen...',
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
                  icon: Icon(Icons.sort),
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
                        PopupMenuItem(
                          value: 1,
                          child: Text('Nach Feld sortieren'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text('Nach Aktivität sortieren'),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Text('Nach Datum sortieren'),
                        ),
                      ],
                ),
                if (!widget.isFiltered)
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterDialog();
                        },
                      );
                    },
                    child: Text("Filtern und Teilen"),
                  ),
                if (widget.isFiltered)
                  PopupMenuButton<int>(
                    icon: Icon(Icons.share),
                    onSelected: (value) async {
                      switch (value) {
                        case 1:
                          // Aktion für "Per Email senden"
                          break;
                        case 2:
                          final pdf = await PdfApi.generateTablePdf(_completeWorksteps, widget.selectedActivities, widget.selectedCrops, widget.selectedFields, _personNames);
                          SavePdf.openPdf(pdf);
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
                          PopupMenuItem(
                            value: 1,
                            child: Text('Per Email senden'),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text('Als PDF speichern'),
                          ),
                          PopupMenuItem(value: 3, child: Text('Cloud-Dienste')),
                          PopupMenuItem(
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
                  _completeWorksteps = workstepSummaryViewModel.filteredWorksteps;
                  if(widget.selectedPersons != null){
                    _personNames = workstepSummaryViewModel.getPersonNameById(widget.selectedPersons!);
                  }else{
                    _personNames =[];
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
                                                title: "Kultur bearbeiten",
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
    );
  }
}
