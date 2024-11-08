import 'package:flutter/material.dart';

class MetricContainer extends StatelessWidget {
  final String label;
  final double value;
  final String tooltip;

  MetricContainer(this.label, this.value, this.tooltip);

  @override
  Widget build(BuildContext context) {
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
