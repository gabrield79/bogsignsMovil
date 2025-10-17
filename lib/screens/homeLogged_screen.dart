import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HommeLoggedScreen extends StatelessWidget {
  const HommeLoggedScreen({super.key}) ;

  Future<void> _logout(BuildContext context) async {
    final AuthService authService = AuthService();

    // ✅ Borra el token JWT del almacenamiento
    await authService.logout();

    // ✅ Regresa al login reemplazando la ruta actual
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        automaticallyImplyLeading: false, // evita volver con el botón atrás
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Has iniciado sesión correctamente 🎉',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
