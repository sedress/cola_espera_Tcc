import 'package:flutter/material.dart';
import 'mmk_result_screen.dart';

class MMkScreen extends StatefulWidget {
  @override
  _MMkScreenState createState() => _MMkScreenState();
}

class _MMkScreenState extends State<MMkScreen> {
  final _lambdaController = TextEditingController();
  final _muController = TextEditingController();
  final _kController = TextEditingController();

  void _navigateToResults() {
    final lambda = double.tryParse(_lambdaController.text) ?? 0;
    final mu = double.tryParse(_muController.text) ?? 0;
    final k = int.tryParse(_kController.text) ?? 1;

    if (lambda > 0 && mu > 0 && k > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MMkResultScreen(lambda: lambda, mu: mu, k: k),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ingrese valores válidos para λ, μ y k.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modelo M/M/k - Ingresar Datos')),
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
            TextField(
              controller: _kController,
              decoration: InputDecoration(labelText: 'Número de servidores (k)'),
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
