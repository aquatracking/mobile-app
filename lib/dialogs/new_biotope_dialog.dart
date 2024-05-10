import 'package:aquatracking/bloc/aquariums/bloc/aquariums_bloc.dart';
import 'package:aquatracking/bloc/terrariums/bloc/terrariums_bloc.dart';
import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/models/aquarium/create_aquarium_model.dart';
import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/models/terrarium/create_terrarium_model.dart';
import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/ui/inputs/date_input_widget.dart';
import 'package:aquatracking/widgets/ui/inputs/segmented_button_widget.dart';
import 'package:aquatracking/widgets/ui/inputs/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewBiotopeDialog<T extends BiotopeModel,
    CreateT extends CreateBiotopeModel> extends StatelessWidget {
  NewBiotopeDialog({
    super.key,
    required this.repository,
    required this.createBiotope,
  });

  final BiotopeRepository<T, CreateT> repository;
  final CreateT createBiotope;

  final _formKey = GlobalKey<FormState>();

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

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > AppBreakpoints.medium) {
        return AlertDialog(
          title: Text(title),
          backgroundColor: Theme.of(context).colorScheme.background,
          scrollable: true,
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  repository.create(createBiotope).then((value) {
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
          content: SizedBox(
            width: 500,
            child: Column(
              children: [
                const Divider(),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: SingleChildScrollView(
                    child: _Form(
                      formKey: _formKey,
                      repository: repository,
                      createBiotope: createBiotope,
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      } else {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      repository.create(createBiotope).then((value) {
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
            body: _Form(
              formKey: _formKey,
              repository: repository,
              createBiotope: createBiotope,
            ),
          ),
        );
      }
    });
  }
}

class _Form<T extends BiotopeModel, CreateT extends CreateBiotopeModel>
    extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final BiotopeRepository<T, CreateT> repository;
  final CreateT createBiotope;

  const _Form({
    required this.formKey,
    required this.repository,
    required this.createBiotope,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                createBiotope.name = value!;
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
                createBiotope.description = value ?? "";
              },
            ),
            const SizedBox(
              height: AppSpacing.medium,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 80,
              ),
              child: DateInputWidget(
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
                  createBiotope.startedDate = value!;
                },
              ),
            ),
            const SizedBox(
              height: AppSpacing.medium,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 80,
              ),
              child: TextInputWidget(
                label: AppLocalizations.of(context)!.volume,
                prefixIcon: Icons.expand_rounded,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      double.tryParse(value) == null) {
                    return AppLocalizations.of(context)!.errorPleaseEnterNumber;
                  }
                  return null;
                },
                onSaved: (value) {
                  createBiotope.volume = value == null || value.isEmpty
                      ? null
                      : double.parse(value);
                },
              ),
            ),
            const SizedBox(
              height: AppSpacing.medium,
            ),
            Visibility(
              visible: CreateT == CreateAquariumModel,
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButtonWidget<bool>(
                  initialValue: false,
                  choices: [
                    SegmentedButtonWidgetChoice(
                      value: false,
                      label: AppLocalizations.of(context)!.freshwater,
                    ),
                    SegmentedButtonWidgetChoice(
                      value: true,
                      label: AppLocalizations.of(context)!.saltwater,
                    ),
                  ],
                  onSaved: (value) {
                    (createBiotope as CreateAquariumModel).salt = value!;
                  },
                ),
              ),
            ),
            Visibility(
              visible: CreateT == CreateTerrariumModel,
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButtonWidget<bool>(
                  initialValue: true,
                  choices: [
                    SegmentedButtonWidgetChoice(
                      value: true,
                      label: AppLocalizations.of(context)!.wetTerrarium,
                    ),
                    SegmentedButtonWidgetChoice(
                      value: false,
                      label: AppLocalizations.of(context)!.dryTerrarium,
                    ),
                  ],
                  onSaved: (value) {
                    (createBiotope as CreateTerrariumModel).wet = value!;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
