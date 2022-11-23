import 'package:aquatracking/screen/main_screen.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 35;
    int position = -1;

    if(context.findAncestorWidgetOfExactType<MainScreen>() != null) {
      position = 0;
    }

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(),
            IconButton(
              iconSize: iconSize,
              icon: Icon(
                  Icons.home_rounded,
                  color: position == 0 ? Colors.white : Colors.grey
              ),
              onPressed: () {
                if(position != 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                }
              },
            ),
            const Spacer(),
            const Spacer(),
            IconButton(
              iconSize: iconSize,
              icon: Icon(
                  Icons.search,
                  color: position == 1 ? Colors.white : Colors.grey
              ),
              onPressed: () {},
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}