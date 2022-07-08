import 'package:aquatracking/blocs/measurements_bloc.dart';
import 'package:aquatracking/component/action_button.dart';
import 'package:aquatracking/component/inputs/date_and_time_input.dart';
import 'package:aquatracking/component/inputs/number_input.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:flutter/material.dart';

MeasurementTypeModel? _measurementTypeSelected;
String _value = "";
DateTime _date = DateTime.now();
AquariumsService _aquariumsService = AquariumsService();

class AddAquariumMeasurementScreen extends StatefulWidget {
  final AquariumModel aquarium;
  const AddAquariumMeasurementScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  State<AddAquariumMeasurementScreen> createState() => _AddAquariumMeasurementScreenState();
}

class _AddAquariumMeasurementScreenState extends State<AddAquariumMeasurementScreen> {
  @override
  void initState() {
    _measurementTypeSelected = null;
    _value = "";
    _date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Ajouter un relevé',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              StreamBuilder<List<MeasurementTypeModel>>(
                stream: measurementTypesBloc.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData && snapshot.data != null) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('Aucun type de relevé disponible'));
                    } else {
                      return DropdownButtonFormField<MeasurementTypeModel>(
                        items: [
                          for(final measurementType in snapshot.data!)
                            DropdownMenuItem(
                              value: measurementType,
                              child: Text(measurementType.name),
                            ),
                        ],
                        isExpanded: true,
                        hint: const Text('Type de relevé'),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.assessment_rounded),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _measurementTypeSelected = value;
                          });
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
              NumberInput(
                label: 'Valeur',
                icon: Icons.science_rounded,
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              DateAndTimeInput(
                label: "Date et heure",
                icon: Icons.calendar_today,
                onChanged: (value) {
                  setState(() {
                    _date = DateTime.parse(value);
                  });
                },
                defaultValue: _date.toIso8601String(),
                firstDate: DateTime(0),
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: 20),
              (_measurementTypeSelected != null && _value.isNotEmpty) ? ActionButton(
                  text: 'Ajouter',
                  onPressed: () {
                    _aquariumsService.addMeasurement(widget.aquarium, _measurementTypeSelected!, _value, _date).then((value) => {
                      Navigator.pop(context),
                      MeasurementsBloc.update(_measurementTypeSelected!)
                    });
                  }
              ) : ActionButton(
                  text: 'Ajouter',
                  color: Colors.grey,
                  backgroundColor: Colors.grey[800],
                  onPressed: () {
                    // nothing
                  }
              ),
            ]
          ),
        ),
      ),
    );
  }
}