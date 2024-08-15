import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/measurementSubscription/measurement_subscription_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'measurement_subscription_event.dart';
part 'measurement_subscription_state.dart';

class MeasurementSubscriptionsBloc
    extends Bloc<MeasurementSubscriptionsEvent, MeasurementSubscriptionsState> {
  MeasurementSubscriptionsBloc({
    required BiotopeRepository biotopeRepository,
    required BiotopeModel biotope,
  })  : _biotopeRepository = biotopeRepository,
        _biotope = biotope,
        super(const MeasurementSubscriptionsState()) {
    on<MeasurementSubscriptionsSubscribtionRequested>(_onSubscriptionRequested);
  }

  final BiotopeRepository _biotopeRepository;
  final BiotopeModel _biotope;

  Future<void> _onSubscriptionRequested(
    MeasurementSubscriptionsSubscribtionRequested event,
    Emitter<MeasurementSubscriptionsState> emit,
  ) async {
    try {
      emit(
          state.copyWith(status: () => MeasurementSubscriptionsStatus.loading));

      final measurementSubscriptions =
          await _biotopeRepository.getMeasurementSubscriptions(_biotope);

      emit(
        state.copyWith(
            status: () => MeasurementSubscriptionsStatus.success,
            measurementSubscriptions: () => measurementSubscriptions),
      );
    } catch (e) {
      emit(
          state.copyWith(status: () => MeasurementSubscriptionsStatus.failure));
    }
  }
}
