import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as speech;
import 'package:permission_handler/permission_handler.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';

/*
* FormTextfield Widget
*/
class FormTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLine;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool? enableMic;
  const FormTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.maxLine,
    this.focusNode,
    this.onChanged,
    this.enableMic = false,
  });
  @override
  _FormTextFieldState createState() => new _FormTextFieldState();
}

  class _FormTextFieldState extends State<FormTextfield>{
  late speech.SpeechToText _speechToText;
  bool? _isListeningMoment = false;
  String? permissionStatus;

  @override
  void initState(){
    super.initState();
    if(widget.enableMic == true){
      _speechToText = speech.SpeechToText();
      _initSpeech();
    }
  }

  Future<void> _initSpeech() async{
    var permissionState = await Permission.microphone.status;
    permissionStatus = permissionState.toString();
    if(!permissionState.isGranted){
      permissionState = await Permission.microphone.request();
    }
    bool open = await _speechToText.initialize(
      onStatus: (status){
        if(status=="notListening" || status == "done"){
          setState(() {
            _isListeningMoment = false;
          });
        }
      },
      onError: (e){
        setState(() {
            _isListeningMoment = false;
          });
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alertText:"Beim Verwenden des Mikrofones gab es einen Fehler.",
            alertType: AlertType.error,
          );
        },
      );
      }
    );
    var locales = await _speechToText.locales();
    debugPrint('Supported locales: $locales');
  }

  void _startListening(){
    if(permissionStatus != "PermissionStatus.denied" && permissionStatus != null){
      _speechToText.listen(
        localeId: 'de_DE',
        onResult: (result){
          setState((){
            widget.controller.text = result.recognizedWords;
            if(widget.onChanged!=null){
              widget.onChanged!(widget.controller.text);
            }
          });
        },
      );
      setState(() => _isListeningMoment = true);
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alertText:"Sie müssen in ihren Telefoneinstellungen das Mikrofon für Dibano freigeben, bevor Sie es verwenden können.",
            alertType: AlertType.error,
          );
        },
      );
    }
  }

  void _stopListening(){
    _speechToText.stop();
    setState(() => _isListeningMoment = false);
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
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLine,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          textCapitalization: TextCapitalization.sentences,
          maxLength: 500,
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
            suffixIcon: widget.enableMic!?IconButton(
              icon:Icon(
                _isListeningMoment! ? Icons.mic : Icons.mic_none,
                color: FarmColors.darkGreenIntense,
              ),
              onPressed: _isListeningMoment!?_stopListening:_startListening,
            ) :null,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
