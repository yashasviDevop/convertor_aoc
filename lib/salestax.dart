import 'package:flutter/material.dart';

class SalesTaxCalculator extends StatefulWidget {
  const SalesTaxCalculator({Key? key}) : super(key: key);

  @override
  _SalesTaxCalculatorState createState() => _SalesTaxCalculatorState();
}

class _SalesTaxCalculatorState extends State<SalesTaxCalculator> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _taxPercentageController = TextEditingController();
  String _selectedMethod = 'Price Plus Tax';

  double _finalPrice = 0.0;
  double _taxAmount = 0.0;

  final List<String> _methods = [
    'Price Minus Tax',
    'Price Plus Tax',
  ];

  void _calculateSalesTax() {
    try {
      double price = double.parse(_priceController.text);
      double taxPercentage = double.parse(_taxPercentageController.text);
      _taxAmount = price * (taxPercentage / 100);

      if (_selectedMethod == 'Price Plus Tax') {
        _finalPrice = price + _taxAmount;
      } else {
        _finalPrice = price - _taxAmount;
      }

      setState(() {});
    } catch (e) {
      // Handle any input errors here
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter valid numerical values.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Tax Calculator')),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _taxPercentageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tax Percentage',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedMethod,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMethod = newValue!;
                  });
                },
                items: _methods.map<DropdownMenuItem<String>>((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateSalesTax,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Calculate Tax'),
              ),
              const SizedBox(height: 20),
              Text(
                'Tax Amount: ₹${_taxAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Final Price: ₹${_finalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
