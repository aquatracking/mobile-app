import 'package:aquatracking/screen/add_aquarium_screen.dart';
import 'package:aquatracking/screen/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          Center(
            child: Text('Mesures'),
          ),
          Center(
            child: Text('Notifications'),
          ),
          Center(
            child: Text('Calendrier'),
          ),
          Center(
            child: Text('Recherche'),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_rounded),
            label: 'Mesures',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_rounded),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Calendrier',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: currentIndex == 0,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAquariumScreen()));
          },
          icon: const Icon(Icons.add),
          label: const Text('Créer un aquarium'),
        ),
      ),
    );
  }
}