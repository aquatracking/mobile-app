import 'package:aquatracking/globals.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/screen/aquarium_screen.dart';
import 'package:flutter/material.dart';

class M3AquariumCard extends StatelessWidget {
  final AquariumModel aquarium;

  const M3AquariumCard({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Card(
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AquariumScreen(aquarium: aquarium))),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image(
                          image: (aquarium.image != null) ? Image.memory(aquarium.image!).image : imagePlaceholder,
                          fit: BoxFit.fill
                      )
                  ),
                ),
                // title of card
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        aquarium.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                         aquarium.volume.toString() + 'L' + ' - ' + (aquarium.salt ? 'Eau salée' : 'Eau douce'),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
