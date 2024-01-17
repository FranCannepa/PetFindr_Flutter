import 'package:flutter/material.dart';
import 'package:petfindr/Db/mongoConnection.dart';
import 'package:petfindr/Domain/Utilities.dart';
import 'package:petfindr/UI/Views/MainMenu.dart';
import 'package:petfindr/UI/Widgets/CustomPopUp.dart';
import 'package:petfindr/UI/Widgets/CustomSubmitButton.dart';
import 'package:petfindr/UI/Widgets/CustomTextFormField.dart';
import 'package:petfindr/UI/Widgets/MainLogo.dart';
import 'package:info_popup/info_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const MainLogo(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: "Email",
                      controller: _emailController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email vacio';
                        }
                      },
                    ),
                    CustomTextFormField(
                      label: "Contraseña",
                      controller: _passController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contraseña vacia';
                        }
                      },
                    ),
                    CustomSubmitButton(
                      onTap: () {
                        loginUser(_emailController.text, _passController.text);
                      },
                      texto: "Ingresar",
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  //Methods

  Future<void> loginUser(String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      Utilities.showErrorMessage(context, "Campos Vacios");
    } else {
      try {
        Map<String, dynamic> result =
            await MongoDatabase.loginUser(email, pass);

        if (result["code"] == 200) {
          Map<String, dynamic> data = result["data"];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', data["email"]);
          prefs.setString('username', data["username"]);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainMenu()),
          );
        } else if (result["code"] == 404) {
          Utilities.showErrorMessage(context, "Credenciales Incorrectas");
        } else {
          Utilities.showErrorMessage(context, "Internal Error");
        }
      } catch (e) {
        Utilities.showErrorMessage(context, e.toString());
      }
    }
  }
}
