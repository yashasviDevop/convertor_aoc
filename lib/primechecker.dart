import 'package:flutter/material.dart';

class PrimeChecker extends StatefulWidget {
  const PrimeChecker({Key? key}) : super(key: key);

  @override
  _PrimeCheckerState createState() => _PrimeCheckerState();
}

class _PrimeCheckerState extends State<PrimeChecker> {
  final TextEditingController _numberController = TextEditingController();
  String _isPrimeMessage = '';
  String _primeFactorsMessage = '';
  String _nextPrimeMessage = '';

  void _checkPrime() {
    try {
      int number = int.parse(_numberController.text);
      bool isPrime = _isPrime(number);
      List<int> primeFactors = _primeFactors(number);
      int nextPrime = _nextPrime(number);

      setState(() {
        _isPrimeMessage = isPrime ? 'Is Prime: Yes' : 'Is Prime: No';
        _primeFactorsMessage =
        'Prime Factors: ${primeFactors.isNotEmpty ? primeFactors.join(', ') : 'None'}';
        _nextPrimeMessage = 'Next Prime: $nextPrime';
      });
    } catch (e) {
      setState(() {
        _isPrimeMessage = 'Invalid input. Please enter a valid integer.';
        _primeFactorsMessage = '';
        _nextPrimeMessage = '';
      });
    }
  }

  bool _isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  List<int> _primeFactors(int n) {
    List<int> factors = [];
    for (int i = 2; i <= n; i++) {
      while (n % i == 0) {
        factors.add(i);
        n ~/= i;
      }
    }
    return factors.toSet().toList(); // To get unique factors
  }

  int _nextPrime(int n) {
    int next = n + 1;
    while (!_isPrime(next)) {
      next++;
    }
    return next;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prime Checker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter a number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPrime,
              child: const Text('Check Prime'),
            ),
            const SizedBox(height: 20),
            Text(
              _isPrimeMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              _primeFactorsMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              _nextPrimeMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
