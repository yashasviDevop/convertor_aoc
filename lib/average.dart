import 'package:flutter/material.dart';
import 'dart:math'; // Import the math library

class AverageCalculator extends StatefulWidget {
  const AverageCalculator({Key? key}) : super(key: key);

  @override
  _AverageCalculatorState createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator> {
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _valuesController = TextEditingController();

  String _resultMessage = '';

  void _calculateAverages() {
    try {
      int count = int.parse(_countController.text);
      String valuesInput = _valuesController.text;

      // Split the input values by commas and convert to double
      List<String> valuesStr = valuesInput.split(',');
      if (valuesStr.length != count) {
        throw Exception('Count does not match the number of provided values.');
      }

      List<double> values = valuesStr.map((e) => double.parse(e.trim())).toList();

      // Calculate Averages
      double arithmeticMean = values.reduce((a, b) => a + b) / values.length;
      double geometricMean = pow(values.reduce((a, b) => a * b), 1 / values.length).toDouble(); // Explicitly convert to double
      double harmonicMean = values.length / values.map((e) => 1 / e).reduce((a, b) => a + b);

      setState(() {
        _resultMessage =
        'Arithmetic Mean: $arithmeticMean\n'
            'Geometric Mean: $geometricMean\n'
            'Harmonic Mean: $harmonicMean';
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Invalid input. Please enter valid numbers.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Average Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input for the count of numbers
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'How many numbers do you want to input?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Input for the values
            TextField(
              controller: _valuesController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Enter values separated by commas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAverages,
              child: const Text('Calculate Averages'),
            ),
            const SizedBox(height: 20),
            Text(
              _resultMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


