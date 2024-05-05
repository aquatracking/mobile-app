import 'package:aquatracking/models/aquarium/aquarium_model.dart';
import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AquariumCard extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumCard({super.key, required this.aquarium});

  @override
  Widget build(BuildContext context) {
    List<String> desc = [];

    if (aquarium.volume != null && aquarium.volume! > 0) {
      desc.add("${aquarium.volume}L");
    }

    if (aquarium.salt == true) {
      desc.add(AppLocalizations.of(context)!.saltwater);
    } else {
      desc.add(AppLocalizations.of(context)!.freshwater);
    }

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: () {
          // todo
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ImagePlaceholder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aquarium.name,
                      style: AppText.titleMedium,
                    ),
                    Text(
                      desc.join(" - "),
                      style: AppText.subTitleMedium,
                    ),
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
