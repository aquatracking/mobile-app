import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final IconData? icon;

  const ImagePlaceholder({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Center(
        child: Icon(
          (icon != null) ? icon : Icons.image_rounded,
          color: Theme.of(context).colorScheme.tertiary,
          size: 64,
        ),
      ),
    );
  }
}