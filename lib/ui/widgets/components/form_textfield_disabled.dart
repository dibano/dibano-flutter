import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormTextfieldDisabled extends StatelessWidget{
  final String label;
  final TextEditingController textController;

  const FormTextfieldDisabled({
    super.key,
    required this.label,
    required this.textController,
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
        TextFormField(
          controller: textController,
          enabled: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 15
        )
      ],
    );
  }
}