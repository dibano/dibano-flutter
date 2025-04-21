import 'package:flutter/material.dart';

enum AlertType { info, error, success, delete, restore }

class CustomAlertDialog extends StatelessWidget {
  final String alertText;
  final AlertType alertType;
  final VoidCallback? onDelete;
  final VoidCallback? onRestore;
  final bool backToParent;

  const CustomAlertDialog({
    super.key,
    required this.alertText,
    required this.alertType,
    this.onDelete,
    this.onRestore,
    this.backToParent = false,
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
      case AlertType.restore:
        return Icon(Icons.cloud_download, color: Colors.grey, size: 48);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getAlertIcon(),
          const SizedBox(height: 16),
          Text(
            alertText,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (alertType == AlertType.restore)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onPressed: () {
                    if (alertType == AlertType.restore && onRestore != null) {
                      onRestore!();
                    }
                  },
                  child: const Text(
                    "Überschreiben",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (alertType == AlertType.delete)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onPressed: () {
                    if (alertType == AlertType.delete && onDelete != null) {
                      onDelete!();
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Löschen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (backToParent) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  alertType == AlertType.delete ? "Abbrechen" : "OK",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
