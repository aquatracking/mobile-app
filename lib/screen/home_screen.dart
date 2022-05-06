import 'package:aquatracking/blocs/aquariums_bloc.dart';
import 'package:aquatracking/component/alert_card.dart';
import 'package:aquatracking/component/aquarium_card.dart';
import 'package:aquatracking/component/layout.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AquariumsService aquariumsService = AquariumsService();

    AquariumsBloc aquariumsBloc = AquariumsBloc(aquariumsService);



    return Layout(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AlertCard(title: 'Tout va bien', description: 'Vous n\'avez aucune alerte ou tache à effectuer', icon: Icons.check_circle_rounded, color: Colors.green),
            ),
            /*SizedBox(height: 20),
            AlertCard(title: 'Attention', description: 'Vous avez une alerte', icon: Icons.warning, color: Colors.orange),
            SizedBox(height: 20),
            AlertCard(title: 'Danger', description: 'Vous avez une alerte', icon: Icons.error, color: Colors.red),*/
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Mes aquariums',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<List<AquariumModel>>(
                stream: aquariumsBloc.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return (snapshot.data!.isEmpty) ?
                      const Text('Vous n\'avez aucun aquarium') :
                     CarouselSlider(
                      items:  <AquariumCard>[
                        for(AquariumModel aquarium in snapshot.data!) AquariumCard(aquarium: aquarium),
                      ],
                      options: CarouselOptions(height: ((MediaQuery.of(context).size.width*0.8-32)/16)*9+62),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}