import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.detail, this.onTap});

  final Detail detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String? formattedStartDate;
    String? formattedEndDate;
    if (detail.startDate != null && detail.endDate != null) {
      formattedStartDate = DateFormat('dd.MM.yyyy').format(detail.startDate!);
      formattedEndDate = DateFormat('dd.MM.yyyy').format(detail.endDate!);
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detail.name, style: TextStyle(fontSize: 16)),
                      if (detail.description != null)
                        Text(
                          detail.description!,
                          style: TextStyle(fontSize: 12),
                        ),
                      if (detail.startDate != null && detail.endDate != null)
                        Text(
                          ('$formattedStartDate - $formattedEndDate'),
                          style: TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
                Icon(
                  detail.isInfo
                      ? Icons.arrow_forward
                      : detail.toEdit
                      ? Icons.edit
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
