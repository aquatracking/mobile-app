import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/screen/add_aquarium_measurement_screen.dart';
import 'package:flutter/material.dart';

class AddAquariumInfoModal {
  static void show({required BuildContext context, required AquariumModel aquarium}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.assessment_rounded),
              title:  const Text('Ajouter un relevé'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAquariumMeasurementScreen(aquarium: aquarium))
                );
              },
            )
          ]
        );
      }
    );
  }
}