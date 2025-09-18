import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final LocalAuthentication _localAuth = LocalAuthentication();
  String? _error;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() != true) return;
    final token = await _authService.login(
      _usernameController.text,
      _passwordController.text,
    );
    if (token != null) {
      // Intentar autenticación biométrica
      final didAuth = await _localAuth.authenticate(
      localizedReason: 'Autentícate para acceder',
       options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuth) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() => _error = 'Autenticación biométrica fallida');
      }
    } else {
      setState(() => _error = 'Usuario o contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                //controller: _usernameController,
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
                onPressed: _login,
                child: const Text('Iniciar sesión'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
              //if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                 // child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}