import 'package:flutter/material.dart';
import 'login_screen.dart'; // Asegúrate de que este sea tu Pantalla de Login
import 'register_screen.dart'; // Asegúrate de que este sea tu Pantalla de Registro

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Cambia a tu imagen de fondo
            fit: BoxFit.cover, // Asegúrate de que la imagen cubra todo el fondo
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Espacio adicional para mover el mensaje hacia abajo
              const SizedBox(height: 100), // Ajusta este valor según sea necesario

              // Mensaje de bienvenida
              const Text(
                '¡Bienvenido a DisPets!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Cambia el color del texto si es necesario
              ),
              const SizedBox(height: 40), // Espacio entre el mensaje y los botones

              // Botón de Registro
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                  ),
                  child: const Text('Registrar'),
                ),
              ),
              const SizedBox(height: 20), // Espacio entre los botones

              // Botón de Iniciar Sesión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                  ),
                  child: const Text('Iniciar sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
