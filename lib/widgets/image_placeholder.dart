import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Center(
        child: Icon(
          Icons.image_rounded,
          color: Theme.of(context).colorScheme.tertiary,
          size: 64,
        ),
      ),
    );
  }
}
