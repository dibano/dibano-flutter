import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dibano/data/backup/google_drive.dart';

class BackupFileList extends StatelessWidget {
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          alertText:
              "Hier können Sie Ihre Datenbank wiederherstellen. \nBitte beachten Sie, dass alle bestehenden Daten überschrieben werden.",
          alertType: AlertType.info,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Daten wiederherstellen",
        hasInfo: true,
        onInfoPressed: () => _showInfoDialog(context),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: listBackupFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final files = snapshot.data!;
          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return ListTile(
                title: Text(file['name']),
                trailing: const Icon(Icons.download),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        alertType: AlertType.restore,
                        alertText:
                            "Sollen die Daten des Gerätes gelöscht und durch die Daten des Backups ersetzt werden?",
                        onRestore: () async {
                          bool success = await downloadBackupFile(file['id']);
                          Navigator.of(context).pop();
                          if (success) {
                            print("Datenbank erfolgreich wiederhergestellt.");

                            await restoreDatabase(
                              '/path/to/save/${file['name']}',
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  alertType: AlertType.success,
                                  alertText:
                                      "Datenbank erfolgreich wiederhergestellt.",
                                  backToParent: true,
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  alertType: AlertType.error,
                                  alertText:
                                      "Die Datei konnte nicht heruntergeladen werden.",
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
