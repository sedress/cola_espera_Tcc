import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'mm1_screen.dart';
import 'mmk_screen.dart';

class ModeloSeleccionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _AnimatedBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                _buildUniversityLogo(),
                _buildContextDescription(),
                Expanded(child: _buildModelButtons(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'Modelos de Colas',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildUniversityLogo() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            'assets/images/university_logo.png',
            height: 250,
            width: 250,
          ),
        ],
      ),
    );
  }

  Widget _buildContextDescription() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Esta aplicación está diseñada para optimizar la gestión de recursos en '
            'centros de atención al cliente mediante el uso de modelos de teoría de colas. '
            'Puede ayudar a calcular métricas clave como el tiempo promedio de espera y la '
            'utilización de los servidores, ayudando a mejorar la eficiencia y calidad del servicio.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildModelButtons(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          _AnimatedModelButton(
            title: 'Modelo M/M/1',
            icon: Icons.align_vertical_bottom_rounded,
            color: Colors.blue,
            onPressed: () => _navigateTo(context, MM1Screen()),
            onInfoPressed: () => _showModelInfo(context, 'M/M/1', 'Este modelo describe un sistema de colas con una sola estación de servicio. Se usa comúnmente para modelar situaciones como líneas de espera en cajeros automáticos o centros de llamadas.'),
          ),
          SizedBox(height: 20),
          _AnimatedModelButton(
            title: 'Modelo M/M/k',
            icon: Icons.align_vertical_bottom_rounded,
            color: Colors.green,
            onPressed: () => _navigateTo(context, MMkScreen()),
            onInfoPressed: () => _showModelInfo(context, 'M/M/k', 'Este modelo extiende el modelo M/M/1, permitiendo múltiples servidores. Es ideal para sistemas donde varios servidores atienden clientes simultáneamente, como centros de atención telefónica con varios agentes.'),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
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
  }

  void _showModelInfo(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class _AnimatedModelButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final VoidCallback onInfoPressed;

  const _AnimatedModelButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.onInfoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.info_outline, color: Colors.white),
                onPressed: onInfoPressed,
              ),
            ],
          ),
        ),
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
