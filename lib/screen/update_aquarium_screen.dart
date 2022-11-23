import 'package:aquatracking/component/action_button.dart';
import 'package:aquatracking/component/inputs/text_input.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/update_aquarium_model.dart';
import 'package:aquatracking/screen/main_screen.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:aquatracking/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAquariumScreen extends StatefulWidget {
  final AquariumModel aquarium;

  const UpdateAquariumScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  State<UpdateAquariumScreen> createState() => _UpdateAquariumScreenState();
}

ImageProvider _image = Image.asset('assets/images/placeholder.jpg').image;
UpdateAquariumModel _updateAquariumModel = UpdateAquariumModel();

class _UpdateAquariumScreenState extends State<UpdateAquariumScreen> {
  @override
  void initState() {
    _updateAquariumModel.name = widget.aquarium.name;
    _updateAquariumModel.description = widget.aquarium.description;
    _updateAquariumModel.image = widget.aquarium.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImagePicker picker = ImagePicker();
    AquariumsService aquariumsService = AquariumsService();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0x90000000),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                        image: (_updateAquariumModel.image != null) ? MemoryImage(_updateAquariumModel.image!) : _image,
                        fit: BoxFit.fill)),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0x90000000),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.photo_camera_rounded),
                        onPressed: () {
                          picker.pickImage(source: ImageSource.camera)
                            .then((file) {
                              cropsImage(file);
                            }
                          );
                        },
                      ),
                      IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.image_rounded),
                        onPressed: () {
                          picker.pickImage(source: ImageSource.gallery)
                            .then((file) {
                              cropsImage(file);
                            }
                          );
                        },
                      ),
                      Visibility(
                        visible: _updateAquariumModel.image != null,
                        child: IconButton(
                          splashRadius: 20,
                          icon: const Icon(Icons.delete_rounded),
                          onPressed: () {
                            setState(() {
                              _updateAquariumModel.image = null;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextInput(
                  label: 'Nom de l\'aquarium',
                  maxLength: 50,
                  initialValue: _updateAquariumModel.name,
                  onChanged: (value) {
                    _updateAquariumModel.name = value;
                  },
                  icon: Icons.label_rounded,
                ),
                TextInput(
                  label: 'Description',
                  maxLength: 255,
                  minLines: 1,
                  maxLines: 5,
                  initialValue: _updateAquariumModel.description,
                  onChanged: (value) {
                    _updateAquariumModel.description = value;
                  },
                  icon: Icons.description_rounded,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                ActionButton(
                  text: 'Modifier',
                  onPressed: () {
                    if (_updateAquariumModel.name.isEmpty) {
                      PopupUtils.showError(context, 'Paramètre incorrect',
                          'Le nom de l\'aquarium est obligatoire');
                    } else {
                      aquariumsService.updateAquarium(widget.aquarium, _updateAquariumModel).then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                        aquariumsBloc.fetchAquariums();
                      }).catchError((error) {
                        PopupUtils.showError(context, 'Une erreur est survenue', "Impossible d'ajouter l'aquarium");
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
            toolbarColor: Theme.of(context).bottomAppBarColor,
            toolbarWidgetColor: Theme.of(context).primaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true
          )
        ]
      ).then((cropFile) async => {
        if(cropFile != null) {
          _updateAquariumModel.image = await cropFile.readAsBytes(),
          setState(() {})
        }
      });
    }
  }
}
