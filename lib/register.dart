import 'package:actividad_3_apps/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividad_3_apps/user.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
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
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;

                register(username, password);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  /*void saveUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedUsers = prefs.getStringList('users') ?? [];
    prefs.setStringList(
      'users',
      users.map((user) => user.toString()).toList(),
    );

    print(prefs.getStringList('users'));
  }*/

  Future<void> register(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedUsers = prefs.getStringList('users') ?? [];

    // Verifica si ya existe un usuario con el mismo nombre de usuario
    bool userExists = savedUsers.any((userString) {
      User user = User.fromString(userString);
      return user.username == username;
    });

    if (!userExists) {
      // Agrega el nuevo usuario a la lista
      User newUser = User(username, password);
      savedUsers.add(newUser.toString());

      // Guarda la lista actualizada en SharedPreferences
      await prefs.setStringList('users', savedUsers);
    } else {
      // El nombre de usuario ya está en uso, puedes manejar esto según tus requisitos
      print('El nombre de usuario ya está en uso.');
    }
  }
}