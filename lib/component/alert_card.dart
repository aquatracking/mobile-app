import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const AlertCard({Key? key, required this.title, required this.description, required this.icon, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.9;

    return Container(
      height: 100,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: width*0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}