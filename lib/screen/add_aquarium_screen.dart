import 'dart:developer';

import 'package:aquatracking/model/create_aquarium_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:aquatracking/utils/popup_utils.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddAquariumScreen extends StatefulWidget {
  const AddAquariumScreen({Key? key}) : super(key: key);

  @override
  State<AddAquariumScreen> createState() => _AddAquariumScreenState();
}

ImageProvider _image = Image.asset('assets/images/placeholder.jpg').image;
CreateAquariumModel _createAquariumModel = CreateAquariumModel();

class _AddAquariumScreenState extends State<AddAquariumScreen> {
  @override
  void initState() {
    _createAquariumModel = CreateAquariumModel();
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
                        image: (_createAquariumModel.image != null)
                            ? MemoryImage(_createAquariumModel.image!)
                            : _image,
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
                        visible: _createAquariumModel.image != null,
                        child: IconButton(
                          splashRadius: 20,
                          icon: const Icon(Icons.delete_rounded),
                          onPressed: () {
                            setState(() {
                              _createAquariumModel.image = null;
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
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    _createAquariumModel.name = value;
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nom de l\'aquarium',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(
                      Icons.tag_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    _createAquariumModel.description = value;
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(
                      Icons.description_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _createAquariumModel.volume = int.parse(value);
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nombre de litres',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(
                      Icons.local_drink_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                DateTimePicker(
                  dateMask: "d MMMM yyyy",
                  cursorColor: Theme.of(context).primaryColor,
                  locale: const Locale("fr", "FR"),
                  decoration: InputDecoration(
                    labelText: 'Date de début',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  type: DateTimePickerType.date,
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                  onChanged: (value) {
                    _createAquariumModel.startedDate = DateTime.tryParse(value);
                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ListTile(
                            title: const Text('Eau douce'),
                            leading: Radio<bool>(
                              activeColor: Theme.of(context).highlightColor,
                              value: false,
                              groupValue: _createAquariumModel.salt,
                              onChanged: (value) {
                                setState(() {
                                  _createAquariumModel.salt = value!;
                                });
                              },
                            )),
                      ),
                      Flexible(
                        child: ListTile(
                            title: const Text('Eau salée'),
                            leading: Radio<bool>(
                              activeColor: Theme.of(context).highlightColor,
                              value: true,
                              groupValue: _createAquariumModel.salt,
                              onChanged: (value) {
                                setState(() {
                                  _createAquariumModel.salt = value!;
                                });
                              },
                            )),
                      )
                    ]),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context).highlightColor;
                        }
                        return Theme.of(context)
                            .highlightColor; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    if (_createAquariumModel.name == null ||
                        _createAquariumModel.name!.isEmpty) {
                      PopupUtils.showError(context, 'Paramètre manquant',
                          'Veuillez entrer un nom pour l\'aquarium');
                    } else if (_createAquariumModel.volume == null) {
                      PopupUtils.showError(context, 'Paramètre manquant',
                          'Veuillez entrer un volume pour l\'aquarium');
                    } else if (_createAquariumModel.startedDate == null) {
                      PopupUtils.showError(context, 'Paramètre manquant',
                          'Veuillez entrer une date de début pour l\'aquarium');
                    } else {
                      aquariumsService.addAquarium(_createAquariumModel).then((value) {
                        Navigator.pop(context);
                      }).catchError((error) {
                        print(error);
                        PopupUtils.showError(context, 'Une erreur est survenue', "Impossible d'ajouter l'aquarium");
                      });
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Créer',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
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
          _createAquariumModel.image = await cropFile.readAsBytes(),
          setState(() {})
        }
      });
    }
  }
}
