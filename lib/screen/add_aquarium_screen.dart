import 'package:aquatracking/component/image_selector.dart';
import 'package:aquatracking/model/create_aquarium_model.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:aquatracking/utils/popup_utils.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class AddAquariumScreen extends StatefulWidget {
  const AddAquariumScreen({Key? key}) : super(key: key);

  @override
  State<AddAquariumScreen> createState() => _AddAquariumScreenState();
}

CreateAquariumModel _createAquariumModel = CreateAquariumModel();

class _AddAquariumScreenState extends State<AddAquariumScreen> {
  @override
  void initState() {
    _createAquariumModel = CreateAquariumModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AquariumsService aquariumsService = AquariumsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un aquarium'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => {
              if (_createAquariumModel.name == null || _createAquariumModel.name!.isEmpty) {
                PopupUtils.showError(context, 'Paramètre manquant', 'Veuillez entrer un nom pour l\'aquarium')
              } else if (_createAquariumModel.volume == null) {
                PopupUtils.showError(context, 'Paramètre manquant', 'Veuillez entrer un volume pour l\'aquarium')
              } else if (_createAquariumModel.startedDate == null) {
                PopupUtils.showError(context, 'Paramètre manquant', 'Veuillez entrer une date de début pour l\'aquarium')
              } else {
                aquariumsService.addAquarium(_createAquariumModel).then((value) {
                  Navigator.pop(context);
                  aquariumsBloc.fetchAquariums();
                }).catchError((error) {
                  PopupUtils.showError(context, 'Une erreur est survenue', "Impossible d'ajouter l'aquarium");
                })
              }
            },
            child: const Text('Enregistrer',),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ImageSelector(
              image: _createAquariumModel.image,
              onImageSelected: (image) => _createAquariumModel.image = image,
            ),
            const SizedBox(
              height: 28,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                _createAquariumModel.name = value;
              },
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Nom de l\'aquarium',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label_rounded),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              minLines: 1,
              maxLines: 5,
              maxLength: 255,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                _createAquariumModel.description = value;
              },
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _createAquariumModel.volume = int.parse(value);
              },
              decoration: const InputDecoration(
                labelText: 'Nombre de litres',
                prefixIcon: Icon(
                  Icons.local_drink_rounded,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            DateTimePicker(
              dateMask: "d MMMM yyyy",
              locale: const Locale("fr", "FR"),
              decoration: const InputDecoration(
                labelText: 'Date de début',
                prefixIcon: Icon(
                  Icons.calendar_today_rounded,
                ),
                border: OutlineInputBorder(),
              ),
              type: DateTimePickerType.date,
              firstDate: DateTime(1970),
              lastDate: DateTime.now(),
              onChanged: (value) {
                _createAquariumModel.startedDate = DateTime.tryParse(value);
              },
            ),
            const Padding(padding: EdgeInsets.all(9.0)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListTile(
                        title: const Text('Eau douce'),
                        leading: Radio<bool>(
                          activeColor: Theme.of(context).colorScheme.primary,
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
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: true,
                          groupValue: _createAquariumModel.salt,
                          onChanged: (value) {
                            setState(() {
                              _createAquariumModel.salt = value!;
                            });
                          },
                        )),
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }
}
