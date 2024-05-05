import 'package:aquatracking/bloc/aquariums/bloc/aquariums_bloc.dart';
import 'package:aquatracking/repository/biotope/aquarium_repository.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/aquarium_card.dart';
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.medium,
              ),
              child: Text(
                AppLocalizations.of(context)!.aquariums,
                style: AppText.titleMedium,
              ),
            ),
          ),
          const AquariumsGridView(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.medium),
          ),
        ],
      ),
    );
  }
}

class AquariumsGridView extends StatelessWidget {
  const AquariumsGridView({super.key});

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
          return ResponsiveSliverGridList(
            horizontalGridSpacing: AppSpacing.medium,
            verticalGridSpacing: AppSpacing.medium,
            minItemWidth: 300,
            minItemsPerRow: 1,
            maxItemsPerRow: 20,
            children: [
              for (final aquarium in state.aquariums)
                AquariumCard(aquarium: aquarium),
            ],
          );
        },
      ),
    );
  }
}
