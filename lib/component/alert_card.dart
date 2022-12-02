import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;


  const AlertCard({Key? key, required this.title, required this.description, required this.icon, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: this.color, brightness: Theme.of(context).brightness);

    var color = colorScheme.onPrimaryContainer;
    var backgroundColor = colorScheme.primaryContainer;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        //color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFFf57c00) : Colors.white,
        color: backgroundColor,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () => {},
          child: ListTile(
            leading: Icon(
              icon,
              size: 50,
              color: color,
            ),
            title: Text(
              title,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            subtitle: Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: color,
              ),
            ),

          )
        ),
      ),
    );
  }
}