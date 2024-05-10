import 'package:aquatracking/cubit/biotopeType/cubit/biotope_type_cubit.dart';
import 'package:aquatracking/dialogs/new_biotope_dialog.dart';
import 'package:aquatracking/models/aquarium/create_aquarium_model.dart';
import 'package:aquatracking/models/terrarium/create_terrarium_model.dart';
import 'package:aquatracking/repository/biotope/aquarium_repository.dart';
import 'package:aquatracking/repository/biotope/terrarium_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewBiotopeTypeChoiceDialog extends StatelessWidget {
  const NewBiotopeTypeChoiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiotopeTypeCubit(),
      child: const _NewBiotopeTypeChoiceDialog(),
    );
  }
}

class _NewBiotopeTypeChoiceDialog extends StatelessWidget {
  const _NewBiotopeTypeChoiceDialog();

  @override
  Widget build(BuildContext context) {
    final biotopeType =
        context.select((BiotopeTypeCubit cubit) => cubit.state.biotopeType);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addNewBiotope),
      scrollable: true,
      titlePadding: const EdgeInsets.only(
        bottom: 16,
        top: 24,
        left: 24,
        right: 24,
      ),
      contentPadding: const EdgeInsets.all(0),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) {
                if (biotopeType == BiotopeType.aquarium) {
                  return NewBiotopeDialog(
                    repository: AquariumRepository(),
                    createBiotope: CreateAquariumModel(),
                  );
                } else {
                  return NewBiotopeDialog(
                    repository: TerrariumRepository(),
                    createBiotope: CreateTerrariumModel(),
                  );
                }
              },
            );
          },
          child: Text(AppLocalizations.of(context)!.continueLabel),
        ),
      ],
      content: Column(
        children: [
          const Divider(),
          ListTile(
            title: Text(AppLocalizations.of(context)!.aquarium),
            leading: Radio<BiotopeType>(
              value: BiotopeType.aquarium,
              groupValue: biotopeType,
              onChanged: (BiotopeType? value) {
                context.read<BiotopeTypeCubit>().setBiotopeType(value!);
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.terrarium),
            leading: Radio<BiotopeType>(
              value: BiotopeType.terrarium,
              groupValue: biotopeType,
              onChanged: (BiotopeType? value) {
                context.read<BiotopeTypeCubit>().setBiotopeType(value!);
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
