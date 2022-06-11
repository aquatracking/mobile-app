import 'package:flutter/material.dart';

class SoloMetric extends StatelessWidget {
  final String metric;
  final String value;
  final String unit;

  const SoloMetric({Key? key, required this.metric, required this.value, this.unit = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).highlightColor,
              ),
            ),
            Text(
              unit,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).highlightColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          metric,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}