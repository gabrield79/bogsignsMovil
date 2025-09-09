import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bogsings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 50, 136, 207),
        ),
      ),
      home: const MyHomePage(title: 'BOGSINGS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenidos a Bogsings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 30),

            // Botón 1
            ElevatedButton(
              onPressed: () {
                if (mounted) {
                  debugPrint("Botón Iniciar Sesión presionado"); // debug
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Botón Iniciar Sesión presionado'),
                    ),
                  );
                }
              },
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),

            // Botón 2
            ElevatedButton(
              onPressed: () {
                if (mounted) {
                  debugPrint("Botón Registrarse presionado"); // debug
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Botón Registrarse presionado'),
                    ),
                  );
                }
              },
              child: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

