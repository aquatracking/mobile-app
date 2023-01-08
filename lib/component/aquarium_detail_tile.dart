import 'package:flutter/material.dart';

class AquariumDetailTile extends StatelessWidget {
  final String metric;
  final String value;
  final String unit;
  final IconData? icon;
  final String? warning;

  const AquariumDetailTile({Key? key, required this.metric, required this.value, this.unit = "", this.icon, this.warning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: icon != null,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
              Text(
                value + unit,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
            ],
          ),
          const Spacer(),
          Visibility(
            visible: warning != null,
            child: IconButton(
              icon: Icon(Icons.warning_rounded, color: Theme.of(context).colorScheme.onSurfaceVariant),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Attention'),
                      content: Text(warning!),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}