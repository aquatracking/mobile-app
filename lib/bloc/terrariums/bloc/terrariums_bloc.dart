import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/terrarium_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'terrariums_event.dart';
part 'terrariums_state.dart';

class TerrariumsBloc extends Bloc<TerrariumsEvent, TerrariumsState> {
  TerrariumsBloc({
    required TerrariumRepository terrariumRepository,
  })  : _terrariumRepository = terrariumRepository,
        super(const TerrariumsState()) {
    on<TerrariumsSubscribtionRequested>(_onSubscriptionRequested);
  }

  final TerrariumRepository _terrariumRepository;

  Future<void> _onSubscriptionRequested(
    TerrariumsSubscribtionRequested event,
    Emitter<TerrariumsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => TerrariumsStatus.loading));

      final terrariums = await _terrariumRepository.getList();

      emit(
        state.copyWith(
            status: () => TerrariumsStatus.success,
            terrariums: () => terrariums),
      );
    } catch (e) {
      emit(state.copyWith(status: () => TerrariumsStatus.failure));
    }
  }
}
