import 'package:aquatracking/component/dialogs/new_measurement_dialog.dart';
import 'package:aquatracking/component/image_placeholder.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/screen/aquarium_measurement_settings_screen.dart';
import 'package:aquatracking/tabs/aquarium_screen/aquarium_analyse_tab.dart';
import 'package:aquatracking/tabs/aquarium_screen/aquarium_information_tab.dart';
import 'package:flutter/material.dart';

import 'update_aquarium_screen.dart';

class AquariumScreen extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    aquarium.measurementSettingsBloc.fetchMeasurementSettings();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0x90000000),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0x90000000),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_rounded, color: Colors.white),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAquariumScreen(aquarium: aquarium))),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_rounded, color: Colors.white),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AquariumMeasurementSettingsScreen(aquarium: aquarium))),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Ajouter une mesure'),
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => NewMeasurementDialog(aquarium: aquarium),
            )
            //Navigator.push(context, MaterialPageRoute(builder: (context) => AddAquariumMeasurementScreen(aquarium: aquarium)))
          },
        ),
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: (aquarium.image == null) ? const ImagePlaceholder() : Image(image: MemoryImage(aquarium.image!), fit: BoxFit.fill)
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
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
              indicatorWeight: 3,
              tabs: const [
                Tab(icon: Icon(Icons.info_rounded, semanticLabel: 'Information',)),
                Tab(icon: Icon(Icons.science_rounded, semanticLabel: 'Analyse',)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AquariumInformationTab(aquarium: aquarium),
                  AquariumAnalyseTab(aquarium: aquarium),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}