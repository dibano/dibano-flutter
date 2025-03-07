import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormTextfield extends StatelessWidget{
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLine;

  const FormTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.maxLine
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLine,
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