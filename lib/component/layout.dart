import 'package:aquatracking/component/custom_navigation_bar.dart';
import 'package:aquatracking/screen/add_aquarium_screen.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final bool canGoBack;

  const Layout({Key? key, required this.child, this.canGoBack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ) : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAquariumScreen()));
        },
        child: const Icon(Icons.add),
        elevation: 2,
        backgroundColor: Theme.of(context).highlightColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}