import 'package:flutter/material.dart';

class PercentageCalculator extends StatefulWidget {
  const PercentageCalculator({Key? key}) : super(key: key);

  @override
  _PercentageCalculatorState createState() => _PercentageCalculatorState();
}

class _PercentageCalculatorState extends State<PercentageCalculator> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _spiCgpaController = TextEditingController();

  String _selectedMethod = 'Discount: a - b% = x';
  String _resultMessage = '';

  void _calculatePercentage() {
    try {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);
      double result;

      switch (_selectedMethod) {
        case 'Discount: a - b% = x':
          result = a - (b / 100) * a; // Calculates the discounted amount
          _resultMessage = 'Result: $result';
          break;

        case 'Increase: a + b% = x':
          result = a + (b / 100) * a; // Calculates the increased amount
          _resultMessage = 'Result: $result';
          break;

        case 'Simple Percentage: a * b% = x':
          result = a * (b / 100); // Calculates the simple percentage
          _resultMessage = 'Result: $result';
          break;

        case 'Increase/Decrease: a -> b = x%':
          if (a == 0) {
            _resultMessage = 'Cannot calculate percentage change from 0.';
          } else {
            double change = b - a;
            double percentageChange = (change / a) * 100; // Percentage change from A to B
            _resultMessage = 'Result: ${percentageChange.toStringAsFixed(2)}%';
          }
          break;

        case 'Percentage of A from B: a <- b = x%':
          if (b == 0) {
            _resultMessage = 'Cannot calculate percentage of A from 0.';
          } else {
            double percentageOfA = (a / b) * 100; // Percentage of A in relation to B
            _resultMessage = 'Result: ${percentageOfA.toStringAsFixed(2)}%';
          }
          break;

        default:
          _resultMessage = 'Invalid method selected';
      }
    } catch (e) {
      setState(() {
        _resultMessage = 'Invalid input. Please enter valid numbers.';
      });
    }

    setState(() {}); // Update UI to show result
  }

  void _calculateSpiCgpa() {
    try {
      double spiCgpa = double.parse(_spiCgpaController.text);
      double percentage = spiCgpa * 9.5; // Common conversion factor from CGPA/SPI to percentage
      _resultMessage = 'Converted Percentage: ${percentage.toStringAsFixed(2)}%';
    } catch (e) {
      setState(() {
        _resultMessage = 'Invalid input for SPI/CGPA. Please enter a valid number.';
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Percentage Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedMethod,
              items: const [
                DropdownMenuItem(
                  value: 'Discount: a - b% = x',
                  child: Text('Discount: a - b% = x'),
                ),
                DropdownMenuItem(
                  value: 'Increase: a + b% = x',
                  child: Text('Increase: a + b% = x'),
                ),
                DropdownMenuItem(
                  value: 'Simple Percentage: a * b% = x',
                  child: Text('Simple Percentage: a * b% = x'),
                ),
                DropdownMenuItem(
                  value: 'Increase/Decrease: a -> b = x%',
                  child: Text('Increase/Decrease: a -> b = x%'),
                ),
                DropdownMenuItem(
                  value: 'Percentage of A from B: a <- b = x%',
                  child: Text('Percentage of A from B: a <- b = x%'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMethod = newValue!;
                  _resultMessage = ''; // Reset the result when method changes
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value for A',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value for B',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculatePercentage,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            Text(
              _resultMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 40, thickness: 2),
            const Text(
              'SPI/CGPA to Percentage',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _spiCgpaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter SPI/CGPA',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSpiCgpa,
              child: const Text('Convert to Percentage'),
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

