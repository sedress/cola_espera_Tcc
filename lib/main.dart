import 'package:flutter/material.dart';
import 'screens/modelo_seleccion_screen.dart';

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