import 'package:dibano/data/backup/google_drive.dart';
import 'package:dibano/ui/widgets/components/backup_file_list.dart';
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';
import 'package:dibano/ui/widgets/components/farm_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasInfo;
  final Function()? onInfoPressed;
  final bool messageOnLeave;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasInfo = false,
    this.onInfoPressed,
    this.messageOnLeave = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isHome = title == "Home";
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: isHome ? Colors.white : Colors.transparent,
        ),
        child: AppBar(
          backgroundColor: isHome ? Colors.white : Colors.transparent,
          elevation: 0,
          leading:
              !isHome
                  ? IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(32, 0, 77, 0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF004d00),
                      ),
                    ),
                    onPressed: () async {
                      if (messageOnLeave) {
                        final shouldLeave = await showDialog(
                          context: context,
                          builder:
                              (context) => CustomAlertDialog(
                                alertText:
                                    "Möchten Sie die Seite verlassen, ohne zu speichern?",
                                alertType: AlertType.shouldLeave,
                                onDelete: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                        );

                        if (shouldLeave == true) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                  : null,
          iconTheme: const IconThemeData(color: Color(0xFF004d00)),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF004d00),
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            if (isHome)
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(32, 0, 77, 0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.settings, color: Color(0xFF004d00)),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Icon(
                          Icons.settings,
                          color: Colors.grey,
                          size: 48,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FarmColors.darkGreenIntense,
                                  iconColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                ),
                                icon: const Icon(Icons.cloud_upload, size: 28),
                                label: const Text(
                                  "Backup erstellen",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  bool success = await uploadToGoogleDrive();
                                  Navigator.of(context).pop();

                                  if (success) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertDialog(
                                          alertType: AlertType.success,
                                          alertText:
                                              "Das Backup wurde erfolgreich hochgeladen!",
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
                                              "Das Backup konnte nicht hochgeladen werden. Versuchen Sie es bitte später erneut.",
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FarmColors.darkGreenIntense,
                                  iconColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.cloud_download,
                                  size: 28,
                                ),
                                label: const Text(
                                  "Daten wiederherstellen",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BackupFileList(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Abbrechen",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            if (hasInfo)
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(32, 0, 77, 0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.info, color: Color(0xFF004d00)),
                ),
                onPressed: onInfoPressed ?? () {},
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
