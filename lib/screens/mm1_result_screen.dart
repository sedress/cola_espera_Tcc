import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/metric_container.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Resultados del Modelo M/M/1'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _AnimatedBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MetricContainer('Probabilidad de Sistema Vacío (P0)', p0, 'Nos indica la proporción de tiempo que el servidor está ocioso.'),
                  MetricContainer('Número promedio de clientes (L)', l, 'Representa el número promedio de clientes que se encuentran tanto en la cola como siendo atendidos.'),
                  MetricContainer('Tiempo promedio en el sistema (W)', w, 'Incluye tanto el tiempo de espera en la cola como el tiempo de servicio.'),
                  MetricContainer('Tiempo promedio de espera en cola (Wq)', wq, 'Representa el tiempo promedio que un cliente pasa esperando para ser atendido.'),
                  SizedBox(height: 20),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        ColumnSeries<Map<String, dynamic>, String>(
                          dataSource: graphData,
                          xValueMapper: (data, _) => data['name'],
                          yValueMapper: (data, _) => data['value'],
                          color: Colors.white70, // Matching the color scheme
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1a2a6c), Color(0xFF2a4858)],
        ),
      ),
      child: Center(
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
