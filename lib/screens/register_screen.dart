import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String? _error;
  String? _success;

  Future<void> _register() async {
    if (_formKey.currentState?.validate() != true) return;
    final ok = await _authService.register(
      _usernameController.text,
      _passwordController.text,
    );
    if (ok) {
      setState(() {
        _success = 'Registro exitoso. Ahora puedes iniciar sesión.';
        _error = null;
      });
    } else {
      setState(() {
        _error = 'No se pudo registrar. El usuario puede existir.';
        _success = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Usuario'),
                validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Registrarse'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('¿Ya tienes cuenta? Inicia sesión'),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              if (_success != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(_success!, style: const TextStyle(color: Colors.green)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}