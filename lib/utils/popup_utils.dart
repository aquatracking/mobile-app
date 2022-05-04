import 'package:flutter/material.dart';

class PopupUtils {
  static void showError(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        barrierDismissible: false, // disables popup to close if tapped outside popup (need a button to close)
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            //buttons?
            actions: <Widget>[
              TextButton(
                child: Text("Fermer", style: TextStyle(color: Theme.of(context).highlightColor)),
                onPressed: () { Navigator.of(context).pop(); }, //closes popup
              ),
            ],
          );
        }
    );
  }
}