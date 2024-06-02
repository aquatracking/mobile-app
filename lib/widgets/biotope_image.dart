import 'package:aquatracking/bloc/biotopeImage/bloc/bloc/biotope_image_bloc.dart';
import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/repository/biotope/biotope_repository.dart';
import 'package:aquatracking/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiotopeImage extends StatelessWidget {
  final BiotopeRepository biotopeRepository;
  final BiotopeModel biotope;

  const BiotopeImage({
    super.key,
    required this.biotopeRepository,
    required this.biotope,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BiotopeImageBloc(
        biotopeRepository: biotopeRepository,
        biotope: biotope,
      )..add(
          const BiotopeImageSubscribtionRequested(),
        ),
      child: _BiotopeImage(
        biotope: biotope,
      ),
    );
  }
}

class _BiotopeImage extends StatelessWidget {
  final BiotopeModel biotope;

  const _BiotopeImage({
    required this.biotope,
  });

  @override
  Widget build(BuildContext context) {
    if (biotope.imageUrl == null) {
      return const ImagePlaceholder();
    }

    return BlocBuilder<BiotopeImageBloc, BiotopeImageState>(
      builder: (context, state) {
        if (state.status == BiotopeImageStatus.success &&
            state.biotopeImage != null) {
          return Image.memory(
            state.biotopeImage!,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        }

        return const ImagePlaceholder();
      },
    );
  }
}
