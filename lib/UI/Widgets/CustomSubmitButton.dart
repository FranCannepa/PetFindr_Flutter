import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final Function()? onTap;
  final String texto;

  CustomSubmitButton({required this.texto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            texto,
            style: TextStyle(color: Colors.white),
          ),
        ),
      )),
    );
  }
}
