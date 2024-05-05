import 'package:aquatracking/bloc/aquariums/bloc/aquariums_bloc.dart';
import 'package:aquatracking/bloc/terrariums/bloc/terrariums_bloc.dart';
import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/aquarium_repository.dart';
import 'package:aquatracking/repository/biotope/terrarium_repository.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/biotope_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AquariumsBloc(
            aquariumRepository: AquariumRepository(),
          )..add(const AquariumsSubscribtionRequested()),
        ),
        BlocProvider(
          create: (context) => TerrariumsBloc(
            terrariumRepository: TerrariumRepository(),
          )..add(const TerrariumsSubscribtionRequested()),
        ),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: AppSpacing.medium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .helloUser(UserRepository.currentUser?.username ?? ""),
                    style: AppText.titleLarge,
                  ),
                  Text(
                    AppLocalizations.of(context)!.wellcomeToAquarium,
                    style: AppText.subTitleMedium,
                  ),
                ],
              ),
            ]),
          ),
          const _AquariumSectionTitle(),
          const _AquariumsGridView(),
          const _TerrariumSectionTitle(),
          const _TerrariumsGridView(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.medium),
          ),
        ],
      ),
    );
  }
}

class _BiotopeSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _BiotopeSectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppSpacing.large,
          bottom: AppSpacing.medium,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.small),
            Text(
              title,
              style: AppText.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _AquariumSectionTitle extends StatelessWidget {
  const _AquariumSectionTitle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AquariumsBloc, AquariumsState>(
      builder: (context, state) {
        return _BiotopeSectionTitle(
          title:
              '${AppLocalizations.of(context)!.aquariums} (${state.aquariums.length})',
          icon: Icons.water_rounded,
        );
      },
    );
  }
}

class _TerrariumSectionTitle extends StatelessWidget {
  const _TerrariumSectionTitle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TerrariumsBloc, TerrariumsState>(
      builder: (context, state) {
        return _BiotopeSectionTitle(
          title:
              '${AppLocalizations.of(context)!.terrariums} (${state.terrariums.length})',
          icon: Icons.grass_rounded,
        );
      },
    );
  }
}

class _AquariumsGridView extends StatelessWidget {
  const _AquariumsGridView();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AquariumsBloc, AquariumsState>(
          listenWhen: ((previous, current) =>
              previous.status != current.status),
          listener: (context, state) {
            if (state.status == AquariumsStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.errorFailedToFetchAquariums,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AquariumsBloc, AquariumsState>(
        builder: (context, state) {
          return state.aquariums.isNotEmpty
              ? ResponsiveSliverGridList(
                  horizontalGridSpacing: AppSpacing.medium,
                  verticalGridSpacing: AppSpacing.medium,
                  minItemWidth: 300,
                  minItemsPerRow: 1,
                  maxItemsPerRow: 20,
                  children: [
                    for (final aquarium in state.aquariums)
                      BiotopeCard<AquariumModel>(
                        biotope: aquarium,
                        onTap: (context) {},
                      ),
                  ],
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.medium,
                    ),
                    child: Text(AppLocalizations.of(context)!.noAquariumsFound),
                  ),
                );
        },
      ),
    );
  }
}

class _TerrariumsGridView extends StatelessWidget {
  const _TerrariumsGridView();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TerrariumsBloc, TerrariumsState>(
          listenWhen: ((previous, current) =>
              previous.status != current.status),
          listener: (context, state) {
            if (state.status == TerrariumsStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.errorFailedToFetchTerrariums,
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<TerrariumsBloc, TerrariumsState>(
        builder: (context, state) {
          return state.terrariums.isNotEmpty
              ? ResponsiveSliverGridList(
                  horizontalGridSpacing: AppSpacing.medium,
                  verticalGridSpacing: AppSpacing.medium,
                  minItemWidth: 300,
                  minItemsPerRow: 1,
                  maxItemsPerRow: 20,
                  children: [
                    for (final terrarium in state.terrariums)
                      BiotopeCard<TerrariumModel>(
                        biotope: terrarium,
                        onTap: (context) {},
                      ),
                  ],
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.medium,
                    ),
                    child:
                        Text(AppLocalizations.of(context)!.noTerrariumsFound),
                  ),
                );
        },
      ),
    );
  }
}
