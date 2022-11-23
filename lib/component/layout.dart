import 'package:aquatracking/component/custom_navigation_bar.dart';
import 'package:aquatracking/component/modals/add_aquarium_info_modal.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/screen/add_aquarium_screen.dart';
import 'package:aquatracking/screen/aquarium_screen.dart';
import 'package:aquatracking/screen/main_screen.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final bool canGoBack;
  final AquariumModel? aquarium;
  final List<Widget>? actions;

  const Layout({Key? key, required this.child, this.canGoBack = false, this.aquarium, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHomeScreen = context.findAncestorWidgetOfExactType<MainScreen>() != null;
    bool isAquariumScreen = (aquarium != null) && (context.findAncestorWidgetOfExactType<AquariumScreen>() != null);

    return Scaffold(
      body: child,
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: (canGoBack) ? AppBar(
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
        actions: actions,
      ) : null,
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(isHomeScreen) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAquariumScreen()));
          } else if(isAquariumScreen) {
            AddAquariumInfoModal.show(context: context, aquarium: aquarium!);
          }

        },
        child: const Icon(Icons.add),
        elevation: 2,
        backgroundColor: Theme.of(context).highlightColor,
      ),*/
    );
  }
}