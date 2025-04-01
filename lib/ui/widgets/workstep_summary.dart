import 'package:dibano/ui/widgets/components/filter_dialog.dart';
import 'package:dibano/ui/view_model/workstep_summary.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/activity_card.dart';
import 'package:provider/provider.dart';

class WorkstepSummary extends StatefulWidget {
  const WorkstepSummary({super.key, required this.title});

  final String title;

  @override
  State<WorkstepSummary> createState() => _WorkstepSummaryState();
}

class _WorkstepSummaryState extends State<WorkstepSummary> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkstepSummaryViewModel>(
        context,
        listen: false,
      ).getCompleteWorksteps();
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
            padding: const EdgeInsets.all(8.0),
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
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterDialog();
                      },
                    );
                  },

                  icon: Icon(Icons.filter_alt),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<WorkstepSummaryViewModel>(
                builder: (context, workstepSummaryViewModel, child) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 24),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                for (var workstep
                                    in workstepSummaryViewModel
                                        .completeWorksteps)
                                  ActivityCard(
                                    isDeletable: true,
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
