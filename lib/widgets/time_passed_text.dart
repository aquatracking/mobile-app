import 'package:aquatracking/cubit/timePassed/cubit/time_passed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimePassedText extends StatelessWidget {
  final DateTime dateTime;
  final String template;

  const TimePassedText({
    super.key,
    required this.dateTime,
    this.template = '{value}',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimePassedCubit(dateTime),
      child: BlocBuilder<TimePassedCubit, TimePassedState>(
        builder: (context, state) {
          String text = "";

          switch (state.unit) {
            case TimePassedUnit.now:
              text = AppLocalizations.of(context)!.justNow;
              break;
            case TimePassedUnit.seconds:
              text = AppLocalizations.of(context)!.secondAgo(state.duration);
              break;
            case TimePassedUnit.minutes:
              text = AppLocalizations.of(context)!.minuteAgo(state.duration);
              break;
            case TimePassedUnit.hours:
              text = AppLocalizations.of(context)!.hourAgo(state.duration);
              break;
            case TimePassedUnit.days:
              text = AppLocalizations.of(context)!.dayAgo(state.duration);
              break;
          }

          return Text(template.replaceAll('{value}', text));
        },
      ),
    );
  }
}
