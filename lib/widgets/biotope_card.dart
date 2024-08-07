import 'package:aquatracking/dialogs/biotope_dialog.dart';
import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/models/terrarium/terrarium_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/biotope_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BiotopeCard<T extends BiotopeModel, TCreate extends CreateBiotopeModel>
    extends StatelessWidget {
  final BiotopeRepository<T, TCreate> biotopeRepository;
  final T biotope;
  final void Function(BuildContext context) onTap;

  const BiotopeCard({
    super.key,
    required this.biotopeRepository,
    required this.biotope,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> desc = [];

    if (biotope.volume != null && biotope.volume! > 0) {
      desc.add("${biotope.volume}L");
    }

    if (biotope is AquariumModel) {
      if ((biotope as AquariumModel).salt == true) {
        desc.add(AppLocalizations.of(context)!.saltwater);
      } else {
        desc.add(AppLocalizations.of(context)!.freshwater);
      }
    } else if (biotope is TerrariumModel) {
      if ((biotope as TerrariumModel).wet == true) {
        desc.add(AppLocalizations.of(context)!.wetTerrarium);
      } else {
        desc.add(AppLocalizations.of(context)!.dryTerrarium);
      }
    }

    final biotopeImage = BiotopeImage(
      biotopeRepository: biotopeRepository,
      biotope: biotope,
    );

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => BiotopeDialog(
              repository: biotopeRepository,
              biotope: biotope,
              biotopeImage: biotopeImage,
            ),
          );
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: biotopeImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      biotope.name,
                      style: AppText.titleMedium,
                    ),
                    desc.isNotEmpty
                        ? Text(
                            desc.join(" - "),
                            style: AppText.subTitleMedium,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
