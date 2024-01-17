import 'package:flutter/material.dart';

class CustomRouteButton extends StatelessWidget {
  final String texto;
  final Function()? onTap;
  CustomRouteButton({required this.texto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
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
