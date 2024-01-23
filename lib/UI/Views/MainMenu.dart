import 'package:flutter/material.dart';
import 'package:petfindr/UI/Views/Home.dart';
import 'package:petfindr/UI/Views/ListedReports.dart';
import 'package:petfindr/UI/Views/NewReport.dart';
import 'package:petfindr/UI/Widgets/CustomRouteButton.dart';
import 'package:petfindr/UI/Widgets/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomRouteButton(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewReport()),
                )
              },
              texto: "Nuevo reporte",
            ),
            CustomRouteButton(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListedReports()),
                )
              },
              texto: "Listar reportes",
            ),
            SizedBox(height: 5),
            AbsorbPointer(
              absorbing: !enabled,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context)
                      .colorScheme
                      .secondary, // Apply secondary color
                  onPrimary: Colors.white, // Ensure text contrast
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)), // Softer edges
                ),
                onPressed: () async {
                  setState(() {
                    enabled = false;
                  });
                  await clearAllPreferences();
                  Navigator.pop(context);
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16), // Slightly larger text
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

void main() {
  runApp(MaterialApp(
    home: MainMenu(),
  ));
}
