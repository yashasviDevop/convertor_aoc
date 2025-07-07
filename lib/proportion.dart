import 'package:flutter/material.dart';

class ProportionConverter extends StatefulWidget {
  const ProportionConverter({Key? key}) : super(key: key);

  @override
  _ProportionConverterState createState() => _ProportionConverterState();
}

class _ProportionConverterState extends State<ProportionConverter> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _xController = TextEditingController();

  double _result = 0.0;
  String _resultMessage = '';

  void _calculateProportion(bool isDirect) {
    try {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);
      double x = double.parse(_xController.text);

      setState(() {
        if (isDirect) {
          // Directly proportional: y = (x * b) / a
          _result = (x * b) / a;
          _resultMessage = 'Directly Proportional Result: $_result';
        } else {
          // Indirectly proportional: y = (a * b) / x
          _result = (a * b) / x;
          _resultMessage = 'Indirectly Proportional Result: $_result';
        }
      });
    } catch (e) {
      setState(() {
        _resultMessage = 'Invalid input. Please enter numeric values.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proportion Converter')),
      body: SingleChildScrollView( // Wrap in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for a
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value for a',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Input Field for b
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value for b',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Input Field for x
            TextField(
              controller: _xController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value for x',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Button for Directly Proportional calculation
            ElevatedButton(
              onPressed: () => _calculateProportion(true),
              child: const Text('Calculate Directly Proportional'),
            ),
            const SizedBox(height: 20),

            // Button for Indirectly Proportional calculation
            ElevatedButton(
              onPressed: () => _calculateProportion(false),
              child: const Text('Calculate Indirectly Proportional'),
            ),
            const SizedBox(height: 20),

            // Display the result
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

