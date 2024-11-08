import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/metric_container.dart';

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
            MetricContainer('Probabilidad de Pérdida', probabilidadPerdida, 'Es la probabilidad de que un cliente sea rechazado del sistema debido a que todos los servidores están ocupados.'),
            MetricContainer('Longitud Promedio de la Cola', longitudCola, 'El número promedio de clientes esperando en la cola para ser atendidos.'),
            MetricContainer('Tiempo Promedio de Espera', tiempoEspera, 'El tiempo promedio que un cliente espera en la cola antes de ser atendido.'),
            MetricContainer('Utilización de Servidores', utilizacionServidores, 'Porcentaje de tiempo que cada servidor está ocupado procesando clientes.'),
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
