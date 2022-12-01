import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class PassingTimeBloc extends Bloc {
  final _passingTimeController = BehaviorSubject<String>();

  final DateTime time;
  Timer? timer;

  PassingTimeBloc({required this.time}) {
    startClock();
  }

  startClock() {
    var timeDiff = DateTime.now().difference(time);
    var passingTime = timeDiff.inDays;
    var unit = 'jour';
    // one day in seconds
    var nextRefresh = (86400 + (timeDiff.inDays * 86400)) - timeDiff.inSeconds;

    if(passingTime == 0) {
      passingTime = timeDiff.inHours;
      unit = 'heure';
      nextRefresh = (3600 + (timeDiff.inHours * 3600)) - timeDiff.inSeconds;

      if(passingTime == 0) {
        passingTime = timeDiff.inMinutes;
        unit = 'minute';
        nextRefresh = (60 + (timeDiff.inMinutes * 60)) - timeDiff.inSeconds;

        if(passingTime == 0) {
          passingTime = timeDiff.inSeconds;
          unit = 'seconde';
          nextRefresh = 60 - timeDiff.inSeconds;
        }
      }
    }

    if(passingTime > 1) unit += 's';

    _passingTimeController.add(passingTime.toString() + ' ' + unit);

    timer = Timer(Duration(seconds: nextRefresh), () {
      if(timer != null) {
        timer!.cancel();
      }
      startClock();
    });
  }

  Stream<String> get stream => _passingTimeController.stream;

  @override
  void dispose() {
    timer!.cancel();
    _passingTimeController.close();
  }
}