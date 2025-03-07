import 'package:flutter/material.dart';
import 'package:dibano/ui/view_model/activity_summary.dart';
import 'package:dibano/ui/widgets/components/activity_card.dart';

class ActivitySummary extends StatefulWidget {
  const ActivitySummary({super.key, required this.title});

  final String title;

  @override
  State<ActivitySummary> createState() => _ActivitySummaryState();
}

class _ActivitySummaryState extends State<ActivitySummary> {
  @override
  Widget build(BuildContext context) {
    var activity = Activity(
      activity: "Dügung mit 250kg Harnstoff",
      date: "23.05.2025",
      field: "Feld A Ost",
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title, style: TextStyle(fontSize: 42)),
        ),
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    // To do: Handle button press
                  },
                  icon: Icon(Icons.sort),
                ),
                SizedBox(width: 8), // Abstand zwischen den Buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // To do: Handle button press
                    },
                    child: Text(
                      'Nach Feld filtern',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Abstand zwischen den Buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // To do: Handle button press
                    },
                    child: Text(
                      'Nach Aktivität filtern',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  for (int i = 0; i < 20; i++) // simulate 20 activities
                    ActivityCard(activity: activity),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // To do: Handle button press
                  },
                  child: Text('Alle auswählen', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Teilen', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 8),
                  Text('PDF übertragen', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // To do: Handle button press
                    },
                    child: Text('E-Mail', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(width: 8), // Abstand zwischen den Buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // To do: Handle button press
                    },
                    child: Text(
                      'Herunterladen',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Abstand zwischen den Buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // To do: Handle button press
                    },
                    child: Text(
                      'Cloud-Dienste',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  // To do: Handle button press
                },
                child: Text(
                  'Per Schnittstelle weiterleiten',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
