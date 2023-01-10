import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'image_placeholder.dart';

class ImageSelector extends StatefulWidget {
  final Uint8List? image;
  final Function(Uint8List?) onImageSelected;

  const ImageSelector({Key? key, this.image, required this.onImageSelected}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  ImagePicker picker = ImagePicker();
  Uint8List? imageCache;

  @override
  Widget build(BuildContext context) {
    if(imageCache == null && widget.image != null) {
      imageCache = widget.image;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                      children: [
                        (imageCache != null) ?
                        Image(
                          image: MemoryImage(imageCache!),
                          fit: BoxFit.fill,
                        ) : const ImagePlaceholder(icon: Icons.add_photo_alternate_rounded),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text((imageCache != null) ? 'Modifier l\'image' : 'Ajouter une image'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading: const Icon(Icons.camera_alt_rounded),
                                                title: const Text('Prendre une photo'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  picker.pickImage(source: ImageSource.camera)
                                                      .then((file) {
                                                        cropsImage(file);
                                                      }
                                                  );
                                                }
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons.image_rounded),
                                                title: const Text('Choisir une photo'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  picker.pickImage(source: ImageSource.gallery)
                                                      .then((file) {
                                                        cropsImage(file);
                                                      }
                                                  );
                                                }
                                              ),
                                              Visibility(
                                                  visible: imageCache != null,
                                                  child: ListTile(
                                                    leading: const Icon(Icons.delete_rounded),
                                                    title: const Text('Supprimer l\'image'),
                                                    onTap: () {
                                                      setState(() {
                                                        imageCache = null;
                                                      });
                                                      Navigator.pop(context);
                                                      widget.onImageSelected(null);
                                                    }
                                                  ),
                                              )
                                            ],
                                          )
                                        );
                                      }
                                  );
                              }
                          ),
                        )
                      ]
                  )
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text((imageCache != null) ? "Modifier l'image" : "Ajouter une image"),
      ],
    );
  }

  cropsImage(XFile? file) {
    if(file != null) {
      ImageCropper imageCropper = ImageCropper();

      imageCropper.cropImage(
          sourcePath: file.path,
          aspectRatio: const CropAspectRatio(
            ratioX: 16,
            ratioY: 9,
          ),
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Redimensionner',
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: true
            ),
            IOSUiSettings(
                title: 'Redimensionner',
                rotateButtonsHidden: true,
            )
          ]
      ).then((cropFile) async => {
        if(cropFile != null) {
          imageCache = await cropFile.readAsBytes(),
          widget.onImageSelected(imageCache),
          setState(() {})
        }
      });
    }
  }
}