import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: const Center(
          child: Image(
              image: AssetImage('lib/Assets/Images/appLogo.png'),
              fit: BoxFit.contain),
        ));
  }
}
