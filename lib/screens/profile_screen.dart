import 'package:flutter/material.dart';
import 'api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  
  // Supón que tenemos un método para obtener el ID del usuario
  final String userId = 'USER_ID'; // Cambia esto por el ID real del usuario

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final response = await ApiService.getUser(userId);
    _usernameController.text = response['username'];
    _emailController.text = response['email'];
  }

  void _saveChanges() async {
    final response = await ApiService.updateUser(
      userId,
      _usernameController.text,
      _emailController.text,
      _passwordController.text, // También se puede enviar la contraseña si se desea actualizar
    );
    setState(() {
      _message = response['message'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Nombre de usuario'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              child: const Text('Guardar cambios'),
              onPressed: () {
                _saveChanges();
              },
            ),
            Text(_message),
            ElevatedButton(
              child: const Text('Cerrar sesión'),
              onPressed: () {
                Navigator.pop(context); // Regresa a la pantalla de bienvenida
              },
            ),
          ],
        ),
      ),
    );
  }
}
