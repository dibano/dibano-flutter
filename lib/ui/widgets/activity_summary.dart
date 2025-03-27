import 'package:dibano/ui/view_model/activity_summary.dart';
import 'package:dibano/ui/view_model/crops.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dibano/ui/widgets/components/activity_card.dart';
import 'package:provider/provider.dart';

class ActivitySummary extends StatefulWidget {
  const ActivitySummary({super.key, required this.title});

  final String title;

  @override
  State<ActivitySummary> createState() => _ActivitySummaryState();
}

class _ActivitySummaryState extends State<ActivitySummary> {
  @override
  void initState() {
    super.initState();
    Provider.of<ActivitySummaryViewModel>(
      context,
      listen: false,
    ).getCompleteWorksteps();
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
                IconButton(
                  onPressed: () {
                    // To do: Handle button press
                  },
                  icon: Icon(Icons.check_box_rounded),
                ),
                PopupMenuButton<int>(
                  icon: Icon(Icons.sort),
                  onSelected: (value) {
                    ActivitySummaryViewModel activitySummaryViewModel = Provider.of<ActivitySummaryViewModel>(context,listen: false);
                    activitySummaryViewModel.sortCompleteWorksteps(value);
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
                        print("Per Email senden ausgewählt");
                        break;
                      case 2:
                        // Aktion für "Als PDF speichern"
                        print("Als PDF speichern ausgewählt");
                        break;
                      case 3:
                        // Aktion für "Cloud-Dienste"
                        print("Cloud-Dienste ausgewählt");
                        break;
                      case 4:
                        // Aktion für "Per Schnittstelle weiterleiten"
                        print("Per Schnittstelle weiterleiten ausgewählt");
                        break;
                      default:
                        print("Keine Aktion ausgewählt");
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
                IconButton(
                  onPressed: () {
                    // To do: Handle button press
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ActivitySummaryViewModel>(
                builder: (context, activitySummaryViewModel, child) {
                  final workstepList =
                      activitySummaryViewModel.completeWorksteps;
                  return ListView.builder(
                    itemCount: workstepList.length,
                    itemBuilder: (context, index) {
                      return ActivityCard(workstep: workstepList[index]);
                    },
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
