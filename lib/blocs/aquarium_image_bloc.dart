import 'dart:typed_data';

import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class AquariumImageBloc extends Bloc {
  final _aquariumImageController = BehaviorSubject<Uint8List?>();
  final _aquariumService = AquariumsService();

  final AquariumModel aquarium;

  AquariumImageBloc({required this.aquarium}) {
    _aquariumImageController.add(null);
    fetchImage();
  }

  Stream<Uint8List?> get stream => _aquariumImageController.stream;

  fetchImage() async {
    final image = await _aquariumService.getImage(aquarium);
    _aquariumImageController.add(image);
  }

  get value => _aquariumImageController.value;

  @override
  void dispose() {
    _aquariumImageController.close();
  }
}