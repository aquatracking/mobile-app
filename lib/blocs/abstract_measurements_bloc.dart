import 'package:aquatracking/model/measurement_model.dart';

import 'bloc.dart';

abstract class AbstractMeasurementsBloc extends Bloc {
  fetchMeasurements(String aquariumId, int fetchModel);

  Stream<List<MeasurementModel>> get stream;
}