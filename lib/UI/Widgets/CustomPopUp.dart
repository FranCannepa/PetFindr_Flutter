import 'package:info_popup/info_popup.dart';
import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  final String mensaje;

  const CustomPopUp({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Login Error"),
      content: Text(mensaje),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
