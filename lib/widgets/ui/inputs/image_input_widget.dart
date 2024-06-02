import 'dart:typed_data';

import 'package:aquatracking/styles.dart';
import 'package:aquatracking/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends FormField<Uint8List> {
  ImageInputWidget({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
  }) : super(
          builder: (FormFieldState<Uint8List> state) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        (state.value != null)
                            ? Image.memory(
                                state.value!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : const ImagePlaceholder(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: state.context,
                                builder: (context) => ImageInputTypeDialog(
                                  state: state,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  (state.value != null)
                      ? AppLocalizations.of(state.context)!.editImage
                      : AppLocalizations.of(state.context)!.addImage,
                ),
              ],
            );
          },
        );
}

class ImageInputTypeDialog extends StatelessWidget {
  final FormFieldState<Uint8List> state;

  const ImageInputTypeDialog({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    pickImageFrom(ImageSource source) {
      ImagePicker().pickImage(source: source).then(
        (image) {
          if (image != null) {
            image.readAsBytes().then((bytes) {
              state.didChange(compressAndResizeImage(bytes));
            });
          }
        },
      );
    }

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addImage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.takePhoto),
            leading: const Icon(Icons.camera_alt_rounded),
            onTap: () {
              Navigator.of(context).pop();
              pickImageFrom(ImageSource.camera);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.chooseFromGallery),
            leading: const Icon(Icons.photo_library_rounded),
            onTap: () {
              Navigator.of(context).pop();
              pickImageFrom(ImageSource.gallery);
            },
          ),
          Visibility(
            visible: state.value != null,
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.deleteImage),
              leading: const Icon(Icons.delete_rounded),
              onTap: () {
                Navigator.of(context).pop();
                state.didChange(null);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Uint8List compressAndResizeImage(Uint8List bytes) {
  img.Image image = img.decodeImage(bytes)!;

  // Resize the image to have the longer side be 800 pixels
  int width;
  int height;

  if (image.width > image.height) {
    width = 800;
    height = (image.height / image.width * 800).round();
  } else {
    height = 800;
    width = (image.width / image.height * 800).round();
  }

  img.Image resizedImage = img.copyResize(image, width: width, height: height);

  // Compress the image with JPEG format
  List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 85);

  return Uint8List.fromList(compressedBytes);
}
