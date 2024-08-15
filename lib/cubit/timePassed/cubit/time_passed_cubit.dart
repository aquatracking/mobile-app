import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_passed_state.dart';

class TimePassedCubit extends Cubit<TimePassedState> {
  final DateTime time;

  TimePassedCubit(
    this.time,
  ) : super(getTimePassed(time)) {
    initClock();
  }

  static TimePassedState getTimePassed(DateTime time) {
    Duration difference = DateTime.now().difference(time);

    if (difference.inDays > 0) {
      return TimePassedState(
          duration: difference.inDays, unit: TimePassedUnit.days);
    } else if (difference.inHours > 0) {
      return TimePassedState(
          duration: difference.inHours, unit: TimePassedUnit.hours);
    } else if (difference.inMinutes > 0) {
      return TimePassedState(
          duration: difference.inMinutes, unit: TimePassedUnit.minutes);
    } else if (difference.inSeconds > 0) {
      return TimePassedState(
          duration: difference.inSeconds, unit: TimePassedUnit.seconds);
    } else {
      return const TimePassedState(unit: TimePassedUnit.now);
    }
  }

  void initClock() {
    Duration difference = DateTime.now().difference(time);

    int nextRefresh = 1000000;

    if (difference.inDays > 0) {
      nextRefresh =
          (86400 + (difference.inDays * 86400)) - difference.inSeconds;
    } else if (difference.inHours > 0) {
      nextRefresh = (3600 + (difference.inHours * 3600)) - difference.inSeconds;
    } else if (difference.inMinutes > 0) {
      nextRefresh = (60 + (difference.inMinutes * 60)) - difference.inSeconds;
    } else if (difference.inSeconds > 0) {
      nextRefresh = 1;
    }

    Future.delayed(Duration(seconds: nextRefresh), () {
      emit(getTimePassed(time));
      initClock();
    });
  }
}
