import 'package:aquatracking/bloc/measurementSubscription/bloc/measurement_subscription_bloc.dart';
import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/biotope_image.dart';
import 'package:aquatracking/widgets/measurement_subscription_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class BiotopeDialog<T extends BiotopeModel, CreateT extends CreateBiotopeModel>
    extends StatelessWidget {
  const BiotopeDialog(
      {super.key,
      required this.repository,
      required this.biotope,
      required this.biotopeImage});

  final BiotopeRepository<T, CreateT> repository;
  final T biotope;
  final BiotopeImage biotopeImage;

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.eco_rounded;

    if (biotope is AquariumModel) {
      icon = Icons.water_rounded;
    } else if (biotope is TerrariumModel) {
      icon = Icons.grass_rounded;
    }

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > AppBreakpoints.medium) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 600,
            child: _DialogContent(
              biotopeImage: biotopeImage,
              icon: icon,
              repository: repository,
              biotope: biotope,
            ),
          ),
        );
      } else {
        return Dialog.fullscreen(
          child: _DialogContent(
              biotopeImage: biotopeImage,
              icon: icon,
              repository: repository,
              biotope: biotope),
        );
      }
    });
  }
}

class _DialogContent<T extends BiotopeModel, CreateT extends CreateBiotopeModel>
    extends StatelessWidget {
  const _DialogContent({
    required this.biotopeImage,
    required this.icon,
    required this.repository,
    required this.biotope,
  });

  final BiotopeImage biotopeImage;
  final IconData icon;
  final BiotopeRepository<T, CreateT> repository;
  final T biotope;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: this.biotopeImage,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.6),
                          Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.0),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(width: AppSpacing.small),
                        Text(
                          biotope.name,
                          style: AppText.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.info_rounded,
                    semanticLabel: AppLocalizations.of(context)!.informations,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.science_rounded,
                    semanticLabel: AppLocalizations.of(context)!.analyses,
                  ),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [
                _InformationTab(biotope: biotope),
                _MeasurementTab(repository: repository, biotope: biotope),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class _InformationTab extends StatelessWidget {
  const _InformationTab({required this.biotope});

  final BiotopeModel biotope;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.medium,
        ),
        child: Wrap(
          runSpacing: AppSpacing.small,
          children: [
            Visibility(
              visible: biotope.description.isNotEmpty,
              child: _InformationCard(
                title: AppLocalizations.of(context)!.description,
                children: [
                  Text(biotope.description),
                ],
              ),
            ),
            _InformationCard(
              title: AppLocalizations.of(context)!.informations,
              children: [
                Visibility(
                  visible: biotope.volume != null,
                  child: _MetricTile(
                    metric: AppLocalizations.of(context)!.volume,
                    value: biotope.volume.toString(),
                    unit: "L",
                    icon: Icons.water_drop_rounded,
                  ),
                ),
                biotope is AquariumModel
                    ? _MetricTile(
                        metric: AppLocalizations.of(context)!.waterType,
                        value: (biotope as AquariumModel).salt != null &&
                                (biotope as AquariumModel).salt!
                            ? AppLocalizations.of(context)!.saltwater
                            : AppLocalizations.of(context)!.freshwater,
                        icon: Icons.water_rounded,
                      )
                    : const SizedBox(),
                biotope is TerrariumModel
                    ? _MetricTile(
                        metric: AppLocalizations.of(context)!.environment,
                        value: (biotope as TerrariumModel).wet != null &&
                                (biotope as TerrariumModel).wet!
                            ? AppLocalizations.of(context)!.wetTerrarium
                            : AppLocalizations.of(context)!.dryTerrarium,
                        icon: Icons.wb_cloudy_rounded,
                      )
                    : const SizedBox(),
                _MetricTile(
                  metric: AppLocalizations.of(context)!.startedDate,
                  value: DateFormat(
                    AppLocalizations.of(context)!.dateFormat,
                    AppLocalizations.of(context)!.localeName,
                  ).format(
                    DateTime.parse(biotope.startedDate),
                  ),
                  icon: Icons.calendar_today_rounded,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.medium),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppText.titleSmall,
            ),
            const SizedBox(height: AppSpacing.small),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile(
      {required this.metric, required this.value, this.unit = "", this.icon});

  final String metric;
  final String value;
  final String unit;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.small),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: icon != null,
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.medium),
              child: Icon(icon),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric,
                style: AppText.subTitleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$value $unit",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MeasurementTab<T extends BiotopeModel,
    CreateT extends CreateBiotopeModel> extends StatelessWidget {
  const _MeasurementTab({required this.repository, required this.biotope});

  final BiotopeRepository<T, CreateT> repository;
  final T biotope;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeasurementSubscriptionsBloc(
        biotopeRepository: repository,
        biotope: biotope,
      )..add(
          const MeasurementSubscriptionsSubscribtionRequested(),
        ),
      child: BlocBuilder<MeasurementSubscriptionsBloc,
          MeasurementSubscriptionsState>(
        builder: (context, state) {
          if (state.status == MeasurementSubscriptionsStatus.initial ||
              state.status == MeasurementSubscriptionsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == MeasurementSubscriptionsStatus.success) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.small,
                  vertical: AppSpacing.medium,
                ),
                child: Wrap(
                  runSpacing: AppSpacing.small,
                  children: state.measurementSubscriptions
                      .map((measurementSubscription) =>
                          MeasurementSubscriptionTile(
                            measurementSubscription: measurementSubscription,
                          ))
                      .toList(),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
