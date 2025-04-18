import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';

/*
* FormTextfield Widget
*/
class FormTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLine;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  const FormTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.maxLine,
    this.focusNode,
    this.onChanged,
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLine,
          focusNode: focusNode,
          onChanged: onChanged,
          textCapitalization: TextCapitalization.sentences,
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
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
