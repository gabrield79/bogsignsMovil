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
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _success = null;
    });

    try {
      print('🟢 Intentando registrar...');
      final ok = await _authService.register(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() {
        _isLoading = false;
        if (ok) {
          _success = '✅ Registro exitoso. Ahora puedes iniciar sesión.';
          _error = null;
        } else {
          _error = '⚠️ No se pudo registrar. El usuario puede existir.';
          _success = null;
        }
      });

      if (ok) {
        // Espera un momento para mostrar el mensaje de éxito y luego ir al login
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      }
    } catch (e, stack) {
      print('❌ Excepción en _register: $e');
      print(stack);
      setState(() {
        _isLoading = false;
        _error = 'Error inesperado: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Registrarse'),
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('¿Ya tienes cuenta? Inicia sesión'),
              ),
              const SizedBox(height: 12),
              if (_error != null)
                Text(_error!,
                    style: const TextStyle(color: Colors.red, fontSize: 14)),
              if (_success != null)
                Text(_success!,
                    style: const TextStyle(color: Colors.green, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
