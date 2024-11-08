import 'package:flutter/material.dart';
import 'mm1_screen.dart';
import 'mmk_screen.dart';

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
