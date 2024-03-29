import 'package:aquatracking/component/aquarium_card.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/service/authentication_service.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    aquariumsBloc.fetchAquariums();
    measurementTypesBloc.fetchMeasurementTypes();
    AuthenticationService authenticationService = AuthenticationService();
    return ListView(
      children: <Widget>[
        // Welcome message
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour $username',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Bienvenue sur AquaTracking',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Déconnexion',
                onPressed: () {
                  authenticationService.logout(context);
                },
                icon: Icon(
                  Icons.logout_rounded,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        //const M3AlertCard(title: 'Danger', description: 'Température trop élevé sur l\'aquarium Mattew\'s Home', icon: Icons.warning_rounded, color: Colors.orange),
        //const M3AlertCard(title: 'Alerte', description: 'Température trop élevé sur l\'aquarium Mattew\'s Home', icon: Icons.dangerous_rounded, color: Colors.red),
        //const AlertCard(title: 'Information', description: 'Vous n\'avez aucune alerte ou tache à effectuer', icon: Icons.info_rounded, color: Colors.blue),
        //const M3AlertCard(title: 'Succès', description: 'Température trop élevé sur l\'aquarium Mattew\'s Home', icon: Icons.check_circle_rounded, color: Colors.green),
        const SizedBox(height: 15),
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
                  children: [
                    for(AquariumModel aquarium in snapshot.data!) AquariumCard(aquarium: aquarium),
                    const SizedBox(height: 80),
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