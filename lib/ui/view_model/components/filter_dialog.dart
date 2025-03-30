import 'package:dibano/ui/widgets/workstep_filtered.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                TextField(decoration: InputDecoration(labelText: 'Datum')),
                TextField(decoration: InputDecoration(labelText: 'Aktivität')),
                TextField(decoration: InputDecoration(labelText: 'Feld')),
                TextField(decoration: InputDecoration(labelText: 'Kultur')),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => WorkstepFiltered(
                                title: "Gefilterte Übersicht",
                              ),
                        ),
                      );
                    },
                    child: Text('Anwenden'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
