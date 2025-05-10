import 'package:intl/intl.dart';

class Activity {
  final String description;
  final String fieldName;
  final String cropName;
  final String activityName;
  final String? fertilizerName;
  final DateTime date;

  Activity({
    required this.description,
    required this.fieldName,
    required this.cropName,
    required this.activityName,
    this.fertilizerName,
    required this.date,
  });

  @override
  String toString() {
    final formattedDate = DateFormat('dd.MM.yyyy').format(date);

    final List<String> parts = [];

    if (activityName.isNotEmpty) {
      parts.add(activityName);
    }

    if (description.isNotEmpty) {
      parts.add(description);
    }
    if (cropName.isNotEmpty) {
      parts.add('$cropName auf $fieldName');
    }

    if (fertilizerName != null && fertilizerName!.isNotEmpty) {
      parts.add(fertilizerName!);
    }

    parts.add(formattedDate);

    return parts.join('\n');
  }
}
