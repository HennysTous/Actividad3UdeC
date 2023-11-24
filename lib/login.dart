import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividad_3_apps/home.dart';
import 'package:actividad_3_apps/register.dart';
import 'package:actividad_3_apps/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async{
                bool loggedIn = await Login(
                  _usernameController.text,
                  _passwordController.text,
                );

                if(loggedIn){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }else{
                  AlertDialog alert = AlertDialog(
                    title: const Text('Usuario no encontrado'),
                    content: const Text('El usuario ingresado no existe, por favor, registrate'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
                onPressed: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );

                },
                child: Text("Aun no tienes cuenta? Registrate aqui")),
          ],
        ),
      ),
    );
  }

  Future<bool> Login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedUsers = prefs.getStringList('users');

    if (savedUsers != null) {
      for (String userString in savedUsers) {
        // Convierte la cadena guardada en SharedPreferences de nuevo a un objeto User
        User user = User.fromString(userString);

        // Verifica si el nombre de usuario y la contraseña coinciden
        if (user.username == username && user.password == password) {
          // El usuario ha iniciado sesión exitosamente
          return true;
        }
      }
    }
    print(savedUsers);
    // No se encontró un usuario con el nombre de usuario y la contraseña proporcionados
    return false;
  }
}