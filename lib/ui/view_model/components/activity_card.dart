class Activity {
  final String description;
  final String fieldName;
  final String cropName;
  final String activityName;

  Activity({required this.description, required this.fieldName, required this.cropName, required this.activityName});

  @override
  String toString() {
    return '$description\n$fieldName $cropName $activityName';
  }
}
