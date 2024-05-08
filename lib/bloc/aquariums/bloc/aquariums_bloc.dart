import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/repository/biotope/aquarium_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'aquariums_event.dart';
part 'aquariums_state.dart';

class AquariumsBloc extends Bloc<AquariumsEvent, AquariumsState> {
  static AquariumsBloc instance = AquariumsBloc(
    aquariumRepository: AquariumRepository(),
  );

  AquariumsBloc({
    required AquariumRepository aquariumRepository,
  })  : _aquariumRepository = aquariumRepository,
        super(const AquariumsState()) {
    on<AquariumsSubscribtionRequested>(_onSubscriptionRequested);
  }

  final AquariumRepository _aquariumRepository;

  Future<void> _onSubscriptionRequested(
    AquariumsSubscribtionRequested event,
    Emitter<AquariumsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => AquariumsStatus.loading));

      final aquariums = await _aquariumRepository.getList();

      emit(
        state.copyWith(
            status: () => AquariumsStatus.success, aquariums: () => aquariums),
      );
    } catch (e) {
      emit(state.copyWith(status: () => AquariumsStatus.failure));
    }
  }
}
