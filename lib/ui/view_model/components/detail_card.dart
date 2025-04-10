class Detail {
  final String name;
  final String? description;
  final bool isInfo;
  final bool toEdit;
  final DateTime? startDate;
  final DateTime? endDate;

  Detail({
    required this.name,
    this.description,
    this.isInfo = false,
    this.toEdit = false,
    this.startDate,
    this.endDate,
  });
}
