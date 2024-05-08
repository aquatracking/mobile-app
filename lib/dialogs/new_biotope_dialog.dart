import 'package:aquatracking/bloc/aquariums/bloc/aquariums_bloc.dart';
import 'package:aquatracking/bloc/terrariums/bloc/terrariums_bloc.dart';
import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/ui/inputs/date_input_widget.dart';
import 'package:aquatracking/widgets/ui/inputs/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewBiotopeDialog<T extends BiotopeModel> extends StatelessWidget {
  NewBiotopeDialog({
    super.key,
    required this.repository,
  });

  final BiotopeRepository<T> repository;

  final _formKey = GlobalKey<FormState>();
  final CreateBiotopeModel _biotope = CreateBiotopeModel(
    name: "",
    description: "",
  );

  @override
  Widget build(BuildContext context) {
    String title = "";
    Function onSaved = () {};

    switch (T) {
      case const (AquariumModel):
        title = AppLocalizations.of(context)!.addNewAquarium;
        onSaved = () {
          AquariumsBloc.instance.add(const AquariumsSubscribtionRequested());
        };
        break;
      case const (TerrariumModel):
        title = AppLocalizations.of(context)!.addNewTerrarium;
        onSaved = () {
          TerrariumsBloc.instance.add(const TerrariumsSubscribtionRequested());
        };
        break;
    }

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  repository.create(_biotope).then((value) {
                    onSaved();
                    Navigator.of(context).pop();
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!
                              .errorWhenCreatingBiotope,
                        ),
                      ),
                    );
                  });
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              children: [
                TextInputWidget(
                  label: AppLocalizations.of(context)!.name,
                  prefixIcon: Icons.label_rounded,
                  requiredIndicator: true,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.errorPleaseEnterName;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _biotope.name = value!;
                  },
                ),
                const SizedBox(
                  height: AppSpacing.medium,
                ),
                TextInputWidget(
                  label: AppLocalizations.of(context)!.description,
                  prefixIcon: Icons.description_rounded,
                  maxLength: 255,
                  maxLines: 5,
                  minLines: 1,
                  onSaved: (value) {
                    _biotope.description = value ?? "";
                  },
                ),
                const SizedBox(
                  height: AppSpacing.medium,
                ),
                DateInputWidget(
                  label: AppLocalizations.of(context)!.startedDate,
                  prefixIcon: Icons.calendar_today_rounded,
                  initialValue: DateTime.now(),
                  validator: (value) {
                    if (value == null) {
                      return AppLocalizations.of(context)!
                          .errorPleaseEnterStartedDate;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _biotope.startedDate = value!;
                  },
                ),
                const SizedBox(
                  height: AppSpacing.medium,
                ),
                TextInputWidget(
                  label: AppLocalizations.of(context)!.volume,
                  prefixIcon: Icons.expand_rounded,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && double.tryParse(value) == null) {
                      return AppLocalizations.of(context)!
                          .errorPleaseEnterNumber;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _biotope.volume =
                        value == null ? null : double.parse(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
