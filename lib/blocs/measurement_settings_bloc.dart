import 'package:aquatracking/blocs/bloc.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:rxdart/rxdart.dart';

class MeasurementSettingsBloc extends Bloc {
  final _measurementSettingsController = BehaviorSubject<List<MeasurementSettingsModel>>();
  final AquariumsService _aquariumsService = AquariumsService();

  final AquariumModel aquarium;

  MeasurementSettingsBloc({
    required this.aquarium,
  });

  Stream<List<MeasurementSettingsModel>> get stream => _measurementSettingsController.stream;

  fetchMeasurementSettings() async {
    final measurementSettings = await _aquariumsService.getMeasurementSettings(aquarium);
    _measurementSettingsController.add(measurementSettings);
  }

  update(List<MeasurementSettingsModel> measurementSettings) async {
    await _aquariumsService.updateMeasurementSettings(aquarium, measurementSettings);
    fetchMeasurementSettings();
  }

  @override
  void dispose() {
    _measurementSettingsController.close();
  }
}