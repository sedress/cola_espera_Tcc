import 'package:flutter/material.dart';
import 'mm1_result_screen.dart';

class MM1Screen extends StatefulWidget {
  @override
  _MM1ScreenState createState() => _MM1ScreenState();
}

class _MM1ScreenState extends State<MM1Screen> {
  final _lambdaController = TextEditingController();
  final _muController = TextEditingController();

  void _navigateToResults() {
    final lambda = double.tryParse(_lambdaController.text) ?? 0;
    final mu = double.tryParse(_muController.text) ?? 0;

    if (lambda > 0 && mu > 0 && lambda < mu) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MM1ResultScreen(lambda: lambda, mu: mu),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ingrese valores válidos para λ y μ.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modelo M/M/1 - Ingresar Datos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _lambdaController,
              decoration: InputDecoration(labelText: 'Tasa de llegada (λ)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _muController,
              decoration: InputDecoration(labelText: 'Tasa de servicio (μ)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToResults,
              child: Text('Calcular y Ver Resultados'),
            ),
          ],
        ),
      ),
    );
  }
}
