import 'package:aquatracking/component/m3_aquarium_card.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    aquariumsBloc.fetchAquariums();
    measurementTypesBloc.fetchMeasurementTypes();
    return ListView(
      children: <Widget>[
        // Welcome message
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Bonjour',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Bienvenue sur AquaTracking',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        //const SizedBox(height: 5),
        //const M3AlertCard(title: 'Danger', description: 'Température trop élevé sur l\'aquarium Mattew\'s Home', icon: Icons.warning_rounded, color: Colors.orange),
        //const M3AlertCard(title: 'Alerte', description: 'Température trop élevé sur l\'aquarium Mattew\'s Home', icon: Icons.dangerous_rounded, color: Colors.red),
        //const M3AlertCard(title: 'Information', description: 'Vous n\'avez aucune alerte ou tache à effectuer', icon: Icons.info_rounded, color: Colors.blue),
        //const M3AlertCard(title: 'Succès', description: 'Température trop élevé sur l\'aquarium Mattew\'s Home', icon: Icons.check_circle_rounded, color: Colors.green),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Mes aquariums',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        StreamBuilder<List<AquariumModel>>(
            stream: aquariumsBloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return (snapshot.data!.isEmpty) ?
                const Text('Vous n\'avez aucun aquarium') :
                Column(
                  children:  <M3AquariumCard>[
                    for(AquariumModel aquarium in snapshot.data!) M3AquariumCard(aquarium: aquarium),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        )
      ],
    );
  }
}