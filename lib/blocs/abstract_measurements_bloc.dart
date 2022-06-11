import 'package:aquatracking/model/abstract_measurement_model.dart';

import 'bloc.dart';

abstract class AbstractMeasurementsBloc extends Bloc {
  fetchMeasurements(String aquariumId, int fetchModel);

  Stream<List<AbstractMeasurementModel>> get stream;
}