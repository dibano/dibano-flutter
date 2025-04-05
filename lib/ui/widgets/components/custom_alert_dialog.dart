import 'package:flutter/material.dart';

enum AlertType { info, error, success, delete }

class CustomAlertDialog extends StatelessWidget {
  final String alertText;
  final AlertType alertType;
  final VoidCallback? onDelete;

  const CustomAlertDialog({
    super.key,
    required this.alertText,
    required this.alertType,
    this.onDelete,
  });

  Icon getAlertIcon() {
    switch (alertType) {
      case AlertType.info:
        return Icon(Icons.info, color: Colors.blue, size: 48);
      case AlertType.error:
        return Icon(
          Icons.error,
          color: Color.fromARGB(255, 175, 76, 76),
          size: 48,
        );
      case AlertType.success:
        return Icon(Icons.check_circle, color: Colors.green, size: 48);
      case AlertType.delete:
        return Icon(Icons.delete, color: Colors.grey, size: 48);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getAlertIcon(),
          SizedBox(height: 16),
          Text(
            alertText,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (alertType == AlertType.delete)
              TextButton(
                onPressed: () {
                  if (alertType == AlertType.delete && onDelete != null) {
                    onDelete!();
                  }
                  Navigator.of(context).pop();
                },
                child: Text("Löschen"),
              ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(alertType == AlertType.delete ? "Abbrechen" : "OK"),
            ),
          ],
        ),
      ],
    );
  }
}
