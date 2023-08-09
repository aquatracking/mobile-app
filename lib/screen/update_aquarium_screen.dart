import 'package:aquatracking/component/image_selector.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/update_aquarium_model.dart';
import 'package:aquatracking/screen/main_screen.dart';
import 'package:aquatracking/service/aquariums_service.dart';
import 'package:aquatracking/utils/globals.dart';
import 'package:aquatracking/utils/popup_utils.dart';
import 'package:flutter/material.dart';

class UpdateAquariumScreen extends StatefulWidget {
  final AquariumModel aquarium;

  const UpdateAquariumScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  State<UpdateAquariumScreen> createState() => _UpdateAquariumScreenState();
}

UpdateAquariumModel _updateAquariumModel = UpdateAquariumModel();

class _UpdateAquariumScreenState extends State<UpdateAquariumScreen> {
  @override
  void initState() {
    _updateAquariumModel.name = widget.aquarium.name;
    _updateAquariumModel.description = widget.aquarium.description;
    _updateAquariumModel.image = widget.aquarium.aquariumImageBloc.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AquariumsService aquariumsService = AquariumsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier un aquarium'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => {
              if(_updateAquariumModel.name.isEmpty) {
                PopupUtils.showError(context, 'Paramètre manquant', 'Veuillez entrer un nom pour l\'aquarium')
              } else {
                aquariumsService.updateAquarium(widget.aquarium, _updateAquariumModel).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                  aquariumsBloc.fetchAquariums();
                }).catchError((error) {
                  PopupUtils.showError(context, 'Une erreur est survenue', "Impossible de modifier l'aquarium");
                })
              }
            },
            child: const Text('Enregistrer',),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ImageSelector(
              image: _updateAquariumModel.image,
              onImageSelected: (image) {
                _updateAquariumModel.image = image;
              },
            ),
            const SizedBox(height: 28),
            TextFormField(
              textInputAction: TextInputAction.next,
              onChanged: (value) => _updateAquariumModel.name = value,
              maxLength: 50,
              initialValue: _updateAquariumModel.name,
              decoration: const InputDecoration(
                labelText: 'Nom de l\'aquarium',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label_rounded),
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              textInputAction: TextInputAction.next,
              onChanged: (value) => _updateAquariumModel.description = value,
              minLines: 1,
              maxLines: 5,
              maxLength: 255,
              initialValue: _updateAquariumModel.description,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
