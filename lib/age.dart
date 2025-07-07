import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  final TextEditingController _birthYearController = TextEditingController();
  final TextEditingController _currentYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _currentDayController = TextEditingController();

  String _selectedBirthMonth = 'January';
  String _selectedCurrentMonth = 'January';

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  String _ageMessage = '';
  String _nextBirthdayMessage = '';

  void _calculateAge() {
    try {
      int birthYear = int.parse(_birthYearController.text);
      int currentYear = int.parse(_currentYearController.text);
      int birthDay = int.parse(_birthDayController.text);
      int currentDay = int.parse(_currentDayController.text);

      int birthMonth = _months.indexOf(_selectedBirthMonth) + 1; // Months are 1-indexed
      int currentMonth = _months.indexOf(_selectedCurrentMonth) + 1;

      DateTime birthDate = DateTime(birthYear, birthMonth, birthDay);
      DateTime currentDate = DateTime(currentYear, currentMonth, currentDay);

      int ageYears = currentDate.year - birthDate.year;
      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
        ageYears--;
      }

      // Calculate next birthday
      DateTime nextBirthday = DateTime(currentDate.year, birthMonth, birthDay);
      if (nextBirthday.isBefore(currentDate) || nextBirthday.isAtSameMomentAs(currentDate)) {
        nextBirthday = DateTime(currentDate.year + 1, birthMonth, birthDay);
      }

      setState(() {
        _ageMessage = 'Your Age: $ageYears years';
        _nextBirthdayMessage = 'Next Birthday: ${DateFormat('yMMMEd').format(nextBirthday)}';
      });
    } catch (e) {
      setState(() {
        _ageMessage = 'Invalid input. Please enter valid dates.';
        _nextBirthdayMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Calculator')),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Birth Date Inputs
              const Text('Birth Date:', style: TextStyle(fontSize: 20)),
              DropdownButton<String>(
                value: _selectedBirthMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBirthMonth = newValue!;
                  });
                },
                items: _months.map<DropdownMenuItem<String>>((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
              ),
              TextField(
                controller: _birthDayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added spacing
              TextField(
                controller: _birthYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // More spacing after the year field

              // Current Date Inputs
              const Text('Current Date:', style: TextStyle(fontSize: 20)),
              DropdownButton<String>(
                value: _selectedCurrentMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrentMonth = newValue!;
                  });
                },
                items: _months.map<DropdownMenuItem<String>>((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
              ),
              TextField(
                controller: _currentDayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Added spacing
              TextField(
                controller: _currentYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20), // More spacing after the year field

              // Calculate Button
              ElevatedButton(
                onPressed: _calculateAge,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Calculate Age'),
              ),
              const SizedBox(height: 20),

              // Display Results
              Text(
                _ageMessage,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                _nextBirthdayMessage,
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
