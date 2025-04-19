import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormDate extends StatefulWidget {
  final String label;
  final DateTime? placeholderDate;
  final Function(DateTime) dateSelected;

  const FormDate({
    super.key,
    required this.label,
    required this.placeholderDate,
    required this.dateSelected,
  });

  @override
  FormDateState createState() => FormDateState();
}

class FormDateState extends State<FormDate> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.placeholderDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
      widget.dateSelected(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: FarmColors.darkGreenIntense,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(
            text:
                selectedDate != null
                    ? "${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}"
                    : "",
          ),
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
            suffixIcon: const Icon(
              Icons.edit_calendar,
              color: FarmColors.darkGreenIntense,
            ),
          ),
          onTap: () => _selectDate(context),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
