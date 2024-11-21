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
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MM1ResultScreen(lambda: lambda, mu: mu),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOutCubic;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    } else {
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ingrese valores válidos para λ y μ (λ < μ).'),
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
        title: Text('Modelo M/M/1 - Ingresar Datos'),
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
                      SizedBox(height: 20),
                      _AnimatedInputField(
                        controller: _muController,
                        label: 'Tasa de servicio (μ)',
                        icon: Icons.speed,
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
      duration: Duration(milliseconds: 800),
      child: Transform.translate(
        offset: Offset(0, 0),
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
      scale: 1.0,
      duration: Duration(milliseconds: 500),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.withOpacity(0.8), // Cambiar a verde
          foregroundColor: Colors.white, // Color del texto y el ícono
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
