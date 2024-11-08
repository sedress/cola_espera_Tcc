import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Reservas',
      theme: ThemeData.dark(),
      home: ModeloSeleccionScreen(),
    );
  }
}

// Pantalla de Selección de Modelos (Inicio)
class ModeloSeleccionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona el Modelo de Colas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MM1Screen(),
                  ),
                );
              },
              child: Text('Modelo M/M/1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MMkScreen(),
                  ),
                );
              },
              child: Text('Modelo M/M/k'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para ingresar datos del Modelo M/M/1
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
      // Pasamos los datos de lambda y mu a la pantalla de resultados
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

// Pantalla de Resultados para el Modelo M/M/1
class MM1ResultScreen extends StatelessWidget {
  final double lambda;
  final double mu;

  MM1ResultScreen({required this.lambda, required this.mu});

  @override
  Widget build(BuildContext context) {
    final p0 = 1 - (lambda / mu);
    final l = lambda / (mu - lambda);
    final w = 1 / (mu - lambda);
    final wq = lambda / (mu * (mu - lambda));

    final graphData = [
      {'name': 'P0', 'value': p0},
      {'name': 'L', 'value': l},
      {'name': 'W', 'value': w},
      {'name': 'Wq', 'value': wq},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Resultados del Modelo M/M/1')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMetricContainer('Probabilidad de Sistema Vacío (P0)', p0,
                'Nos indica la proporción de tiempo que el servidor está ocioso.'),
            _buildMetricContainer('Número promedio de clientes (L)', l,
                'Representa el número promedio de clientes que se encuentran tanto en la cola como siendo atendidos.'),
            _buildMetricContainer('Tiempo promedio en el sistema (W)', w,
                'Incluye tanto el tiempo de espera en la cola como el tiempo de servicio.'),
            _buildMetricContainer('Tiempo promedio de espera en cola (Wq)', wq,
                'Representa el tiempo promedio que un cliente pasa esperando para ser atendido.'),
            SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: graphData,
                  xValueMapper: (data, _) => data['name'],
                  yValueMapper: (data, _) => data['value'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricContainer(String label, double value, String tooltip) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: Tooltip(
        message: tooltip,
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(value.toStringAsFixed(2), style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para ingresar datos del Modelo M/M/k
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

// Pantalla de Resultados para el Modelo M/M/k
class MMkResultScreen extends StatelessWidget {
  final double lambda;
  final double mu;
  final int k;

  MMkResultScreen({required this.lambda, required this.mu, required this.k});

  @override
  Widget build(BuildContext context) {
    final utilizacionServidores = lambda / (mu * k);
    final probabilidadPerdida = 1 - utilizacionServidores;
    final longitudCola = lambda * probabilidadPerdida;
    final tiempoEspera = longitudCola / lambda;

    final graphData = [
      {'name': 'Prob. Pérdida', 'value': probabilidadPerdida},
      {'name': 'Longitud Cola', 'value': longitudCola},
      {'name': 'Tiempo Espera', 'value': tiempoEspera},
      {'name': 'Utilización Servidores', 'value': utilizacionServidores},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Resultados del Modelo M/M/k')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMetricContainer('Probabilidad de Pérdida', probabilidadPerdida,
                'Es la probabilidad de que un cliente sea rechazado del sistema debido a que todos los servidores están ocupados.'),
            _buildMetricContainer('Longitud Promedio de la Cola', longitudCola,
                'El número promedio de clientes esperando en la cola para ser atendidos.'),
            _buildMetricContainer('Tiempo Promedio de Espera', tiempoEspera,
                'El tiempo promedio que un cliente espera en la cola antes de ser atendido.'),
            _buildMetricContainer('Utilización de Servidores', utilizacionServidores,
                'Porcentaje de tiempo que cada servidor está ocupado procesando clientes.'),
            SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: graphData,
                  xValueMapper: (data, _) => data['name'],
                  yValueMapper: (data, _) => data['value'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricContainer(String label, double value, String tooltip) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: Tooltip(
        message: tooltip,
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(value.toStringAsFixed(2), style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
