import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SenasScreen extends StatefulWidget {
  const SenasScreen({Key? key}) : super(key: key);

  @override
  State<SenasScreen> createState() => _SenasScreenState();
}

class _SenasScreenState extends State<SenasScreen> {
  // Lista de señas (imagen + significado)
  final List<Map<String, String>> _senas = [
    {'imagen': 'assets/senas/hola.png', 'significado': 'Hola'},
    {'imagen': 'assets/senas/gracias.png', 'significado': 'Gracias'},
    {'imagen': 'assets/senas/porfavor.png', 'significado': 'Por favor'},
    {'imagen': 'assets/senas/amor.png', 'significado': 'Te amo'},
    
  ];

  Map<String, String>? _senaActual;
  double _ultimaSacudida = 0;
  final double _umbralSacudida = 15; // sensibilidad

  @override
  void initState() {
    super.initState();
    _senaActual = _senas.first;

    // Suscribirse al sensor del acelerómetro
    accelerometerEvents.listen((AccelerometerEvent event) {
      final magnitud = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      final ahora = DateTime.now().millisecondsSinceEpoch.toDouble();

      if (magnitud > _umbralSacudida && ahora - _ultimaSacudida > 1000) {
        _ultimaSacudida = ahora;
        _mostrarSenaAleatoria();
      }
    });
  }

  void _mostrarSenaAleatoria() {
    final random = Random();
    final nueva = _senas[random.nextInt(_senas.length)];
    setState(() => _senaActual = nueva);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nueva seña: ${nueva['significado']} 🙌'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Señas interactivas')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle, size: 64, color: Colors.white),
                  SizedBox(height: 8),
                  Text('Bienvenido 👋',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/homelogged');
              },
            ),
            ListTile(
              leading: const Icon(Icons.pan_tool_alt),
              title: const Text('Señas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.red)),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: Center(
        child: _senaActual == null
            ? const Text('Cargando seña...')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _senaActual!['imagen']!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _senaActual!['significado']!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '👉 Agita el teléfono para ver otra seña',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
