import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormTextfieldDisabled extends StatelessWidget {
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: FarmColors.darkGreenIntense,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: textController,
          enabled: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(172, 159, 157, 157),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: FarmColors.darkGreenIntense,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: FarmColors.darkGreenIntense,
                width: 1.5,
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
