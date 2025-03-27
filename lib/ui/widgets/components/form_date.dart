import 'package:flutter/material.dart';

/*
* Dropdown Widget
*/
class FormDate extends StatefulWidget{
  final String label;
  final DateTime? placeholderDate;
  final Function(DateTime) dateSelected;

  const FormDate({
    super.key,
    required this.label,
    required this.placeholderDate,
    required this.dateSelected
  });

  @override
  _FormDateState createState() => _FormDateState();
}

class _FormDateState extends State<FormDate>{
  late DateTime? selectedDate;

  @override
  void initState(){
    super.initState();
    selectedDate = widget.placeholderDate;
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
                                context: context, 
                                initialDate: selectedDate,
                                firstDate: DateTime(2020), 
                                lastDate: DateTime(2100),
                                );
    
    if(selected != null && selected != selectedDate){
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
            fontSize: 14,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(
          height: 5
        ),
        TextFormField(
          readOnly: true, 
          controller: TextEditingController(
            text: (selectedDate?.day == null||selectedDate?.month == null|| selectedDate?.year == null)
            ? " "
            : "${selectedDate?.day}.${selectedDate?.month}.${selectedDate?.year}",
          ),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_view_month)
          ),
          onTap: () => _selectDate(context),
          ),
        const SizedBox(
          height: 15
        ),
      ],
    );
  }
}