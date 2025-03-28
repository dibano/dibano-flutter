import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

class LLMTest extends StatefulWidget {
  const LLMTest({super.key, required this.title});

  final String title;

  @override
  LLMTestState createState() => LLMTestState();
}

class LLMTestState extends State<LLMTest> {

  final _gemma = FlutterGemmaPlugin.instance;

  @override
  void initState() {
    super.initState();
    final modelManager = _gemma.modelManager;

    modelManager.installModelFromAssetWithProgress('model.bin', loraPath: 'lora_weights.bin').listen(
          (progress) { print('Loading progress: $progress%');},
      onDone: () { print('Model loading complete.'); },
      onError: (error) { print('Error loading model: $error');},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
