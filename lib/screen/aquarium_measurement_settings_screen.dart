import 'package:aquatracking/component/action_button.dart';
import 'package:aquatracking/component/measurement_settings_card.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:flutter/material.dart';

class AquariumMeasurementSettingsScreen extends StatefulWidget {
  final AquariumModel aquarium;

  const AquariumMeasurementSettingsScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  State<AquariumMeasurementSettingsScreen> createState() => _AquariumMeasurementSettingsScreenState();
}

class _AquariumMeasurementSettingsScreenState extends State<AquariumMeasurementSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Préférences'),
      ),
      body: StreamBuilder<List<MeasurementSettingsModel>>(
        stream: widget.aquarium.measurementSettingsBloc.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            if(snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucune mesures disponibles'));
            } else {
              snapshot.data!.sort((a, b) => a.order.compareTo(b.order));
              return Column(
                children: [
                  Expanded(
                    child: ReorderableListView(
                      children: snapshot.data!.map((setting) => MeasurementSettingsCard(key : Key(setting.id), measurementSettings: setting)).toList(),
                      onReorder: (int start, int current) {
                        for(int i = 0; i < snapshot.data!.length; i++) {
                          if(snapshot.data![i].order == start) {
                            snapshot.data![i].order = current;
                            if(current > start) snapshot.data![i].order--;
                          } else {
                            if(current > start && i < current && i > start) {
                              snapshot.data![i].order--;
                            } else if(current < start && i >= current && i < start) {
                              snapshot.data![i].order++;
                            }
                          }
                        }

                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionButton(
                      text: 'Enregistrer',
                      icon: Icons.save,
                      width: 130,
                      onPressed: () {
                        widget.aquarium.measurementSettingsBloc.update(snapshot.data!);
                        Navigator.pop(context);
                      }
                    ),
                  )
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}