import 'package:flutter/material.dart';
import 'api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  void _register() async {
    final response = await ApiService.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );

    print('Respuesta de la API: $response');

    if (response['message'] == 'Registro exitoso') {
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Regresar a la pantalla de Login
    } else {
      setState(() {
        _message = response['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/background2.png', // Asegúrate de que esta imagen exista en la carpeta assets
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 180), // Ajustar la altura según sea necesario
                
                // Campo de texto para el nombre de usuario
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200]?.withOpacity(0.8),
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Nombre de usuario',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Espacio de 1 cm entre campos

                // Campo de texto para el correo electrónico
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200]?.withOpacity(0.8),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Correo electrónico',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Espacio de 1 cm entre campos

                // Campo de texto para la contraseña
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200]?.withOpacity(0.8),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: ' Contraseña',
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 40), // Espacio de 1 cm entre campos

                // Botón de Registro
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Registrar'),
                  ),
                ),
                const SizedBox(height: 40), // Espacio de 1 cm entre el botón y el mensaje

                // Mensaje de error
                Text(_message, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
