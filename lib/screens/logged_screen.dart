import 'package:flutter/material.dart';

class LoggedScreen extends StatelessWidget {
  const LoggedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle, size: 64, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Bienvenido 👋',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                // Ya estamos en Inicio, así que no navegamos a otro lado
              },
            ),
            ListTile(
              leading: const Icon(Icons.pan_tool_alt),
              title: const Text('Señas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/senas');
              },
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.language, size: 100, color: Colors.blue),
                SizedBox(height: 20),
                Text(
                  'Bienvenido a Mi Aplicación de Lenguaje de Señas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'BOGSINGS es una herramienta para las entidades públicas con la capacidad de traducir a lengua de señas. En nuestra sociedad actualmente se vive una constante lucha por la igualdad de derechos, oportunidades, y mejoramiento de la calidad de vida de las personas sordas. Nuestra aplicación tiene el fin de que las personas sordas puedan tener mayor inclusión en la sociedad y menor vulneración a sus derechos fundamentales.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                SizedBox(height: 16),
                Text(
                  'Esta aplicación te permite aprender, practicar y explorar el lenguaje de señas de forma interactiva. '
                  'Usa el menú lateral para navegar entre las secciones.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

