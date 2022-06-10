import 'package:aquatracking/component/layout.dart';
import 'package:aquatracking/globals.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:flutter/material.dart';

class AquariumScreen extends StatelessWidget {
  final AquariumModel aquarium;

  const AquariumScreen({Key? key, required this.aquarium}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      canGoBack: true,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image(
                      image: (aquarium.image != null)
                          ? MemoryImage(aquarium.image!)
                          : imagePlaceholder,
                      fit: BoxFit.fill
                  )
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    aquarium.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}