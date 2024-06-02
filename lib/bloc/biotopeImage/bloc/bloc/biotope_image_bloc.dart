import 'dart:typed_data';

import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'biotope_image_event.dart';
part 'biotope_image_state.dart';

class BiotopeImageBloc extends Bloc<BiotopeImageEvent, BiotopeImageState> {
  BiotopeImageBloc({
    required BiotopeRepository biotopeRepository,
    required BiotopeModel biotope,
  })  : _biotopeRepository = biotopeRepository,
        _biotope = biotope,
        super(const BiotopeImageState()) {
    on<BiotopeImageSubscribtionRequested>(_onSubscriptionRequested);
  }

  final BiotopeRepository _biotopeRepository;
  final BiotopeModel _biotope;

  Future<void> _onSubscriptionRequested(
    BiotopeImageSubscribtionRequested event,
    Emitter<BiotopeImageState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => BiotopeImageStatus.loading));

      final biotopeImage = await _biotopeRepository.getImage(_biotope);

      emit(
        state.copyWith(
          status: () => BiotopeImageStatus.success,
          biotopeImage: () => biotopeImage,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: () => BiotopeImageStatus.failure));
    }
  }
}
