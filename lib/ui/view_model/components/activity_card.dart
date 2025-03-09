class Activity {
  final String activity;
  final String date;
  final String field;

  Activity({required this.activity, required this.date, required this.field});

  @override
  String toString() {
    return '$activity\n$date $field';
  }
}
