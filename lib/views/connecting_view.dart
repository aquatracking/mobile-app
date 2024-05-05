import 'package:aquatracking/cubit/connectingView/cubit/connecting_view_cubit.dart';
import 'package:aquatracking/repository/user_repository.dart';
import 'package:aquatracking/services/navigator_service.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingView extends StatelessWidget {
  const ConnectingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConnectingViewCubit(),
      child: const _ConnectingView(),
    );
  }
}

class _ConnectingView extends StatelessWidget {
  const _ConnectingView();

  @override
  Widget build(BuildContext context) {
    getMe() async {
      UserRepository userRepository = UserRepository();

      context.read<ConnectingViewCubit>().setLoading(true);

      await userRepository.getMe().then((user) {
        UserRepository.currentUser = user;
        NavigationService().replaceScreen(const MainView());
      }).catchError((error) {
        context.read<ConnectingViewCubit>().setLoading(false);
      });
    }

    getMe();
    return BlocBuilder<ConnectingViewCubit, ConnectingViewState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: state.loading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.connectingToServer),
                      const SizedBox(height: AppSpacing.medium),
                      const CircularProgressIndicator(),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off_rounded, size: 64),
                      Text(
                        AppLocalizations.of(context)!.errorConnection,
                        style: AppText.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.medium),
                      Text(AppLocalizations.of(context)!
                          .errorConnectionDescription),
                      const SizedBox(height: AppSpacing.medium),
                      TextButton(
                        onPressed: () {
                          getMe();
                        },
                        child: Text(AppLocalizations.of(context)!.retry),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
