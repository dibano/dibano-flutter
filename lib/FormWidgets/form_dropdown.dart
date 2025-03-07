import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormDropdown extends StatelessWidget{
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const FormDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(
          height: 5
        ),
        DropdownButtonFormField(
          value: value, 
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item){
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 15
        )
      ],
    );
  }
}