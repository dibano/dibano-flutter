import 'package:dibano/ui/view_model/activities.dart';
import 'package:dibano/ui/view_model/fields.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
* Dropdown Widget
*/
class FormDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final Widget? createNewView;
  final Future<void> Function(BuildContext context)? onCreateNew;

  const FormDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.createNewView,
    this.onCreateNew,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: FarmColors.darkGreenIntense,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: FarmColors.darkGreenIntense,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: FarmColors.darkGreenIntense,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: FarmColors.darkGreenIntense,
          ),
          onChanged: (selectedValue) async {
            if (selectedValue == 'new') {
              if (createNewView != null) {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createNewView!),
                );
                if (result == true && onCreateNew != null) {
                  await onCreateNew!(context);
                }
              }
            } else {
              onChanged(selectedValue);
            }
          },
          items: [
            ...items,
            if (createNewView != null)
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
