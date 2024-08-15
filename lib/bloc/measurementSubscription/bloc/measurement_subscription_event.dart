part of 'measurement_subscription_bloc.dart';

sealed class MeasurementSubscriptionsEvent extends Equatable {
  const MeasurementSubscriptionsEvent();

  @override
  List<Object> get props => [];
}

final class MeasurementSubscriptionsSubscribtionRequested
    extends MeasurementSubscriptionsEvent {
  const MeasurementSubscriptionsSubscribtionRequested();
}
