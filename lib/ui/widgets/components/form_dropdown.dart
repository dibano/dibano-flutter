import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final Widget? createNewView;

  const FormDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.createNewView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: value,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (selectedValue) {
            if (selectedValue == 'new') {
              if (createNewView != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createNewView!),
                );
              }
            } else {
              onChanged(selectedValue);
            }
          },
          items: [
            ...items,
            DropdownMenuItem(
              value: 'new',
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.green),
                  const SizedBox(width: 8),
                  Text('$label hinzufügen'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
