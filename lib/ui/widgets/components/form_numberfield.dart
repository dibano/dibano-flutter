import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as speech;
import 'package:permission_handler/permission_handler.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';

/*
* FormTextfield Widget
*/
class FormNumberField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final int maxLine;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  const FormNumberField({
    super.key,
    required this.label,
    required this.controller,
    required this.maxLine,
    this.focusNode,
    this.onChanged,
    this.maxLength = 10,
  });
  @override
  _FormNumberFieldState createState() => new _FormNumberFieldState();
}

class _FormNumberFieldState extends State<FormNumberField> {

  @override
  void initState() {
    super.initState();
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
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*([.,]\d*)?$'))
          ],
          maxLines: widget.maxLine,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          textCapitalization: TextCapitalization.sentences,
          maxLength: widget.maxLength,
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
