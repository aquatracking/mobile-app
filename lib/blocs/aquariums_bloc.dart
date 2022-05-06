import 'package:aquatracking/blocs/bloc.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:rxdart/rxdart.dart';

import '../model/aquarium_model.dart';

class AquariumsBloc extends Bloc {
  final _aquariumsController = BehaviorSubject<List<AquariumModel>>();

  AquariumsBloc(AquariumsService aquariumsService) {
    aquariumsService.getAquariums().then((aquariums) {
      _aquariumsController.add(aquariums);
    });
  }

  Stream<List<AquariumModel>> get stream => _aquariumsController.stream;

  get sink => _aquariumsController.sink;

  set aquariums(List<AquariumModel> aquariums) {
    sink.add(aquariums);
  }

  @override
  void dispose() {

  }
}