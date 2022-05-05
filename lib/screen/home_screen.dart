import 'package:aquatracking/component/alert_card.dart';
import 'package:aquatracking/component/aquarium_card.dart';
import 'package:aquatracking/component/layout.dart';
import 'package:aquatracking/model/aquarium_model.dart';
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
            CarouselSlider(
                items:  <Widget>[
                  AquariumCard(aquarium: AquariumModel(id: "eae", name: "La bulle",imageUrl: "https://blog.manomano.fr/wp-content/uploads/2021/09/Aquarium-deau-de-mer-scaled.jpg", salt: true)),
                  AquariumCard(aquarium: AquariumModel(id: "ede", name: "Blop",imageUrl: "https://download.vikidia.org/vikidia/fr/images/a/a8/Amaterske_akvarium.jpg"))
                ],
                options: CarouselOptions(height: ((MediaQuery.of(context).size.width*0.8-32)/16)*9+62),
            ),
          ],
        ),
      ),
    );
  }
}