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
      appBar: AppBar(title: Text('Resultados del Modelo M/M/1')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MetricContainer('Probabilidad de Sistema Vacío (P0)', p0, 'Nos indica la proporción de tiempo que el servidor está ocioso.'),
            MetricContainer('Número promedio de clientes (L)', l, 'Representa el número promedio de clientes que se encuentran tanto en la cola como siendo atendidos.'),
            MetricContainer('Tiempo promedio en el sistema (W)', w, 'Incluye tanto el tiempo de espera en la cola como el tiempo de servicio.'),
            MetricContainer('Tiempo promedio de espera en cola (Wq)', wq, 'Representa el tiempo promedio que un cliente pasa esperando para ser atendido.'),
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
}
