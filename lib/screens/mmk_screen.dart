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
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ingrese valores válidos para λ, μ y k.'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Modelo M/M/k - Ingresar Datos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _AnimatedBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _AnimatedInputField(
                        controller: _lambdaController,
                        label: 'Tasa de llegada (λ)',
                        icon: Icons.arrow_downward,
                      ),
                      SizedBox(height: 10),
                      _AnimatedInputField(
                        controller: _muController,
                        label: 'Tasa de servicio (μ)',
                        icon: Icons.speed,
                      ),
                      SizedBox(height: 10),
                      _AnimatedInputField(
                        controller: _kController,
                        label: 'Número de servidores (k)',
                        icon: Icons.people,
                      ),
                      SizedBox(height: 40),
                      _AnimatedButton(
                        onPressed: _navigateToResults,
                        child: Text(
                          'Calcular y Ver Resultados',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
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
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1a2a6c), Color(0xFF2a4858)],
        ),
      ),
    );
  }
}

class _AnimatedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const _AnimatedInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.white70),
            labelStyle: TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const _AnimatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 500),
      scale: 1.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.withOpacity(0.8), // Cambiar a verde
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
