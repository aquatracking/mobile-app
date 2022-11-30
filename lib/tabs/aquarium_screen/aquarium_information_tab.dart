import 'package:aquatracking/component/aquarium_detail_tile.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/utils/date_tools.dart';
import 'package:flutter/material.dart';

class AquariumInformationTab extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumInformationTab({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Visibility(
                visible: aquarium.description.isNotEmpty,
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          aquarium.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informations',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AquariumDetailTile(metric: 'Volume', value: aquarium.volume.toString(), unit: 'L', icon: Icons.water_drop_rounded),
                      AquariumDetailTile(metric: 'Type d\'eau', value: aquarium.salt ? 'Eau de mer' : 'Eau douce', icon: Icons.water_rounded),
                      AquariumDetailTile(metric: 'Date de création', value: DateTools.convertUTCToLocalHumanString(aquarium.startedDate.toString()), icon: Icons.calendar_today_rounded),
                    ],
                  ),
                )
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Statistiques',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AquariumDetailTile(metric: 'Démarré il y a', value: DateTime.now().difference(aquarium.startedDate).inDays.toString(), unit: ' jours', icon: Icons.timer_rounded),
                    ],
                  ),
                )
              ),
            ],
          ),
        )
    );
  }
}