import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
