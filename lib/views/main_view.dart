import 'package:aquatracking/cubit/mainView/main_view_cubit.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/mainSubViews/home_view.dart';
import 'package:aquatracking/views/mainSubViews/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainViewCubit(),
      child: _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  _MainView();

  final destinations = [
    {
      'icon': Icons.home_rounded,
      'label': (context) => AppLocalizations.of(context)!.navigationHomeLabel,
    },
    {
      'icon': Icons.settings_rounded,
      'label': (context) =>
          AppLocalizations.of(context)!.navigationSettingsLabel,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final selectedView =
        context.select((MainViewCubit cubit) => cubit.state.view);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > AppBreakpoints.compact) {
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedView.index,
                  groupAlignment: -1,
                  onDestinationSelected: (index) {
                    context.read<MainViewCubit>().setViewByIndex(index);
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: <NavigationRailDestination>[
                    for (final destination in destinations)
                      NavigationRailDestination(
                        icon: Icon(destination['icon'] as IconData),
                        label: Text(
                          (destination['label']! as Function(
                              BuildContext))(context),
                        ),
                      ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: IndexedStack(
                    index: selectedView.index,
                    children: const [HomeView(), SettingsView()],
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: selectedView.index,
              children: const [HomeView(), SettingsView()],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedView.index,
            onDestinationSelected: (index) {
              context.read<MainViewCubit>().setViewByIndex(index);
            },
            destinations: <NavigationDestination>[
              for (final destination in destinations)
                NavigationDestination(
                  icon: Icon(destination['icon'] as IconData),
                  label: (destination['label']! as Function(
                      BuildContext))(context),
                ),
            ],
          ),
        );
      }
    });
  }
}
