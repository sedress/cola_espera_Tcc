import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import '../widgets/metric_container.dart';

double division(double numerator, double denominator) {
  return numerator / denominator;
}

double power(double base, int exponent) {
  return pow(base, exponent).toDouble();
}

int factorial(int n) {
  if (n == 0) return 1;
  return n * factorial(n - 1);
}

double calculateP0(int k, double lambda, double mu) {
  double rho = lambda / mu;
  double sum = 0.0;
  for (int i = 0; i < k; i++) {
    sum += power(rho, i) / factorial(i);
  }
  double term = (1 / factorial(k)) * power(rho, k) * (k * mu / (k * mu - lambda));
  return 1.0 / (sum + term);
}

double calculateLq(int k, double lambda, double mu, double p0) {
  double rho = lambda / mu;
  double numerator = lambda * mu * power(rho, k) * p0;
  double denominator = factorial(k - 1) * power(k * mu - lambda, 2);
  return numerator / denominator;
}

double calculateWq(double lq, double lambda) {
  return lq / lambda;
}

class MMkResultScreen extends StatelessWidget {
  final double lambda;
  final double mu;
  final int k;

  MMkResultScreen({required this.lambda, required this.mu, required this.k});

  @override
  Widget build(BuildContext context) {
    final p0 = calculateP0(k, lambda, mu);
    final lq = calculateLq(k, lambda, mu, p0);
    final wq = calculateWq(lq, lambda);
    final l = lq + (lambda / mu);

    final graphData = [
      {'name': 'P0', 'value': p0},
      {'name': 'Lq', 'value': lq},
      {'name': 'Wq', 'value': wq},
      {'name': 'L', 'value': l},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Resultados del Modelo M/M/k'),
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
                  MetricContainer('Probabilidad de Sistema Vacío (P0)', p0, 'Es la probabilidad de que todos los servidores estén desocupados.'),
                  MetricContainer('Longitud Promedio de la Cola (Lq)', lq, 'El número promedio de clientes esperando en la cola para ser atendidos.'),
                  MetricContainer('Tiempo Promedio de Espera en la Cola (Wq)', wq, 'El tiempo promedio que un cliente espera en la cola antes de ser atendido.'),
                  MetricContainer('Número de Clientes en el Sistema (L)', l, 'El número promedio de clientes en el sistema.'),
                  SizedBox(height: 20),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        ColumnSeries<Map<String, dynamic>, String>(
                          dataSource: graphData,
                          xValueMapper: (data, _) => data['name'],
                          yValueMapper: (data, _) => data['value'],
                          color: Colors.white70,
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
