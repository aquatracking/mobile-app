part of 'measurement_subscription_bloc.dart';

enum MeasurementSubscriptionsStatus { initial, loading, success, failure }

final class MeasurementSubscriptionsState extends Equatable {
  const MeasurementSubscriptionsState({
    this.status = MeasurementSubscriptionsStatus.initial,
    this.measurementSubscriptions = const <MeasurementSubscriptionModel>[],
  });

  final MeasurementSubscriptionsStatus status;
  final List<MeasurementSubscriptionModel> measurementSubscriptions;

  MeasurementSubscriptionsState copyWith({
    MeasurementSubscriptionsStatus Function()? status,
    List<MeasurementSubscriptionModel> Function()? measurementSubscriptions,
  }) {
    return MeasurementSubscriptionsState(
      status: status != null ? status() : this.status,
      measurementSubscriptions: measurementSubscriptions != null
          ? measurementSubscriptions()
          : this.measurementSubscriptions,
    );
  }

  @override
  List<Object> get props => [status, measurementSubscriptions];
}
