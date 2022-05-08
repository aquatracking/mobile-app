import 'package:aquatracking/globals.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:flutter/material.dart';

class AquariumCard extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumCard({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF3C3F41),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(
                    image: (aquarium.image != null) ? Image.memory(aquarium.image!).image : imagePlaceholder,
                    fit: BoxFit.fill)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aquarium.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: aquarium.salt
                            ? const Color(0xFF08829C)
                            : const Color(0xFF9ED3F6),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        aquarium.salt ? 'Eau salée' : 'Eau douce',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
