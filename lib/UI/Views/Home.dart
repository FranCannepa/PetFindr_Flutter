import 'package:flutter/material.dart';
import 'package:petfindr/UI/Widgets/LoginForm.dart';
import 'package:petfindr/UI/Views/MainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('email') != null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      body: isLoggedIn ? const MainMenu() : const Login(),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
