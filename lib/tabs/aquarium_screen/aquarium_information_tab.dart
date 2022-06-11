import 'package:aquatracking/component/solo_metric.dart';
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  aquarium.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Visibility(visible: aquarium.description.isNotEmpty ,child: const SizedBox(height: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SoloMetric(
                    metric: 'Volume',
                    value: aquarium.volume.toString(),
                    unit: 'L',
                  ),
                  SoloMetric(
                    metric: "Type d'eau",
                    value: (aquarium.salt) ? 'Salée' : 'Douce',
                  ),
                  // todo : Implémenter les poissons et plantes
                  /*SoloMetric(
                    metric: 'Poissons',
                    value: 0.toString(),
                  ),
                  SoloMetric(
                    metric: "Plantes",
                    value: 0.toString()
                  )*/
                ],
              ),
              const SizedBox(height: 30),
              // Date de création
              RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Démarré il y a ",
                      ),
                      TextSpan(
                        text: DateTime.now().difference(aquarium.startedDate).inDays.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).highlightColor
                        ),
                      ),
                      const TextSpan(
                          text: " jours, le "
                      ),
                      TextSpan(
                        text: DateTools.convertUTCToLocalHumanString(aquarium.startedDate.toString()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor
                        ),
                      ),
                    ]
                  )
              )
            ],
          ),
        )
    );
  }
}