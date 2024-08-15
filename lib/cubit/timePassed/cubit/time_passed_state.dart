part of 'time_passed_cubit.dart';

enum TimePassedUnit { now, seconds, minutes, hours, days }

class TimePassedState extends Equatable {
  const TimePassedState({
    this.duration = 0,
    required this.unit,
  });

  final int duration;
  final TimePassedUnit unit;

  @override
  List<Object> get props => [duration, unit];
}
