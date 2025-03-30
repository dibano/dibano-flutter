import 'package:dibano/ui/view_model/workstep_summary.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:dibano/ui/widgets/track_worksteps.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/activity_card.dart';
import 'package:provider/provider.dart';

class WorkstepFiltered extends StatefulWidget {
  const WorkstepFiltered({super.key, required this.title});

  final String title;

  @override
  State<WorkstepFiltered> createState() => _WorkstepFilteredState();
}

class _WorkstepFilteredState extends State<WorkstepFiltered> {
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
                PopupMenuButton<int>(
                  icon: Icon(Icons.share),
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
                                    isCheckable: true,
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
