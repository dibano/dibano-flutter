import 'package:dibano/ui/view_model/components/detail_card.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.detail});

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          if (detail.routeWidget != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => detail.routeWidget!),
            );
          }
        },
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
                    ],
                  ),
                ),
                if (detail.routeWidget != null)
                  Icon(detail.isInfo ? Icons.visibility : Icons.edit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
