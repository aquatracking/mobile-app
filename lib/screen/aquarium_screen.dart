import 'package:aquatracking/component/layout.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/tabs/aquarium_screen/aquarium_information_tab.dart';
import 'package:flutter/material.dart';

class AquariumScreen extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Layout(
        canGoBack: true,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                        image: (aquarium.image != null)
                            ? MemoryImage(aquarium.image!)
                            : imagePlaceholder,
                        fit: BoxFit.fill
                    )
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.0),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: aquarium.salt
                              ? const Color(0xFF08829C)
                              : const Color(0xFF9ED3F6),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          aquarium.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
            TabBar(
              indicatorColor: Theme.of(context).highlightColor,
              labelColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(icon: Icon(Icons.info_rounded)),
                Tab(icon: Icon(Icons.assessment_rounded)),
                Tab(icon: Icon(Icons.sailing_rounded)),
                Tab(icon: Icon(Icons.grass_rounded)),
                Tab(icon: Icon(Icons.clean_hands_rounded)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AquariumInformationTab(aquarium: aquarium),
                  Container(
                    child: const Center(child: Text('Analyse')),
                    color: Colors.redAccent,
                  ),
                  Container(
                    child: const Center(child: Text('Poisson')),
                    color: Colors.lightBlueAccent,
                  ),
                  Container(
                    child: const Center(child: Text('Végatation')),
                    color: Colors.greenAccent,
                  ),
                  Container(
                    child: const Center(child: Text('Maintenance')),
                    color: Colors.orange,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}