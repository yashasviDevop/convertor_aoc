import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _tempController = TextEditingController();
  double _convertedTemp = 0.0;

  void _convertToCelsius() {
    setState(() {
      double tempF = double.parse(_tempController.text);
      _convertedTemp = (tempF - 32) * 5 / 9;
    });
  }

  void _convertToFahrenheit() {
    setState(() {
      double tempC = double.parse(_tempController.text);
      _convertedTemp = (tempC * 9 / 5) + 32;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the current theme
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.black54 : Colors.white54, // Background based on theme
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: isDarkTheme ? Colors.grey[800] : Colors.lightBlueAccent,
                labelText: 'Temperature',
                labelStyle: TextStyle(color: isDarkTheme ? Colors.white : Colors.black), // Label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertToCelsius,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Convert to Celsius',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkTheme ? Colors.white : Colors.black, // Text color based on theme
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertToFahrenheit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Convert to Fahrenheit',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkTheme ? Colors.white : Colors.black, // Text color based on theme
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Temperature: ${_convertedTemp.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, color: isDarkTheme ? Colors.white : Colors.black), // Text color
            ),
          ],
        ),
      ),
    );
  }
}




/////////////////////////////////////////////area/////////////////////
class AreaConverter extends StatefulWidget {
  const AreaConverter({super.key});

  @override
  _AreaConverterState createState() => _AreaConverterState();
}

class _AreaConverterState extends State<AreaConverter> {
  final TextEditingController _areaController = TextEditingController();
  double _convertedBigha = 0.0;
  double _convertedBiswa = 0.0;
  bool _isHectareToBighaBiswa = true;

  // Conversion constants
  final double hectareToBiswa = 1 / 0.013; // 1 hectare = 76.92 Biswa
  final double biswaToHectare = 0.013; // 1 Biswa = 0.013 hectare
  final double bighaToBiswa = 20; // 1 Bigha = 20 Biswa

  void _convertArea() {
    setState(() {
      double area = double.parse(_areaController.text);
      if (_isHectareToBighaBiswa) {
        _convertedBiswa = area * hectareToBiswa;
        _convertedBigha = _convertedBiswa / bighaToBiswa;
      } else {
        _convertedBiswa = area * bighaToBiswa;
        _convertedBigha = _convertedBiswa * biswaToHectare;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Converter'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(

            color: Colors.white,

        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _areaController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                labelText: _isHectareToBighaBiswa ? 'Area in Hectares' : 'Area in Bigha',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            // Toggle Switch for conversion direction
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hectare to Bigha/Biswa', style: TextStyle(color: Colors.black)),
                Switch(
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.white54,
                  value: _isHectareToBighaBiswa,
                  onChanged: (bool value) {
                    setState(() {
                      _isHectareToBighaBiswa = value;
                      _areaController.clear(); // Clear input when switching
                      _convertedBigha = 0.0; // Reset results
                      _convertedBiswa = 0.0;
                    });
                  },
                ),
                const Text('Bigha to Hectare', style: TextStyle(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertArea,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _isHectareToBighaBiswa ? 'Convert to Bigha & Biswa' : 'Convert to Hectare',
                style: const TextStyle(fontSize: 19,color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Display conversion results
            _isHectareToBighaBiswa
                ? Column(
              children: [
                Text(
                  'Converted Area: ${_convertedBigha.toStringAsFixed(2)} Bigha',
                  style: const TextStyle(fontSize: 22, color: Colors.green),
                ),
                Text(
                  'Converted Area: ${_convertedBiswa.toStringAsFixed(2)} Biswa',
                  style: const TextStyle(fontSize: 22, color: Colors.green),
                ),
              ],
            )
                : Text(
              'Converted Area in Hectares: ${_convertedBigha.toStringAsFixed(4)} Hectare',
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}












///////////////////////////Time conversion/////////////////////////////////
// Time Conversion Screen


class TimeConverter extends StatefulWidget {
  const TimeConverter({Key? key}) : super(key: key);

  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  final TextEditingController _timeController = TextEditingController();
  double _convertedTime = 0.0;
  String _selectedInputUnit = 'Seconds';
  String _selectedOutputUnit = 'Minutes';

  final List<String> _timeUnits = ['Seconds', 'Minutes', 'Hours', 'Days'];

  // Conversion factors between different time units
  final Map<String, double> _conversionFactors = {
    'Seconds to Minutes': 1 / 60,
    'Seconds to Hours': 1 / 3600,
    'Seconds to Days': 1 / 86400,
    'Minutes to Seconds': 60,
    'Minutes to Hours': 1 / 60,
    'Minutes to Days': 1 / 1440,
    'Hours to Seconds': 3600,
    'Hours to Minutes': 60,
    'Hours to Days': 1 / 24,
    'Days to Seconds': 86400,
    'Days to Minutes': 1440,
    'Days to Hours': 24,
  };

  void _convertTime() {
    setState(() {
      double inputTime = double.parse(_timeController.text);
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedTime = inputTime * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Converter'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.white, // White background for the entire UI
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Field for time value
              TextField(
                controller: _timeController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Enter Time Value',
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 30),

              // Dropdown to select the input time unit
              _buildDropdown(
                context,
                value: _selectedInputUnit,
                onChanged: (String? newUnit) {
                  setState(() {
                    _selectedInputUnit = newUnit!;
                  });
                },
                items: _timeUnits,
                hint: 'Select Input Unit',
              ),
              const SizedBox(height: 30),

              // Dropdown to select the output time unit
              _buildDropdown(
                context,
                value: _selectedOutputUnit,
                onChanged: (String? newUnit) {
                  setState(() {
                    _selectedOutputUnit = newUnit!;
                  });
                },
                items: _timeUnits,
                hint: 'Select Output Unit',
              ),
              const SizedBox(height: 30),

              // Button to trigger the conversion
              ElevatedButton(
                onPressed: _convertTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Convert Time', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 40),

              // Display the converted time value
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: Text(
                  'Converted Time: ${_convertedTime.toStringAsFixed(2)} $_selectedOutputUnit',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating custom dropdown widgets
  Widget _buildDropdown(
      BuildContext context, {
        required String value,
        required ValueChanged<String?> onChanged,
        required List<String> items,
        required String hint,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          dropdownColor: Colors.blue[50],
          style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
          items: items.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          hint: Text(hint, style: const TextStyle(color: Colors.blueAccent)),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
        ),
      ),
    );
  }
}








/////////////////////////Speed convertor///////////
// Speed Conversion Screen


class SpeedConverter extends StatefulWidget {
  const SpeedConverter({Key? key}) : super(key: key);

  @override
  _SpeedConverterState createState() => _SpeedConverterState();
}

class _SpeedConverterState extends State<SpeedConverter> {
  final TextEditingController _speedController = TextEditingController();
  double _convertedSpeed = 0.0;
  String _selectedInputUnit = 'Kilometers per Hour (km/h)';
  String _selectedOutputUnit = 'Miles per Hour (mph)';

  final List<String> _speedUnits = [
    'Kilometers per Hour (km/h)',
    'Miles per Hour (mph)',
    'Meters per Second (m/s)',
    'Feet per Second (ft/s)',
  ];

  // Conversion factors between different speed units
  final Map<String, double> _conversionFactors = {
    'Kilometers per Hour (km/h) to Miles per Hour (mph)': 0.621371,
    'Kilometers per Hour (km/h) to Meters per Second (m/s)': 0.277778,
    'Kilometers per Hour (km/h) to Feet per Second (ft/s)': 0.911344,
    'Miles per Hour (mph) to Kilometers per Hour (km/h)': 1.60934,
    'Miles per Hour (mph) to Meters per Second (m/s)': 0.44704,
    'Miles per Hour (mph) to Feet per Second (ft/s)': 1.46667,
    'Meters per Second (m/s) to Kilometers per Hour (km/h)': 3.6,
    'Meters per Second (m/s) to Miles per Hour (mph)': 2.23694,
    'Meters per Second (m/s) to Feet per Second (ft/s)': 3.28084,
    'Feet per Second (ft/s) to Kilometers per Hour (km/h)': 1.09728,
    'Feet per Second (ft/s) to Miles per Hour (mph)': 0.681818,
    'Feet per Second (ft/s) to Meters per Second (m/s)': 0.3048,
  };

  void _convertSpeed() {
    setState(() {
      double inputSpeed = double.parse(_speedController.text);
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedSpeed = inputSpeed * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speed Converter'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.white, // White background for clean look
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Field for speed value
              _buildStyledTextField(
                controller: _speedController,
                labelText: 'Enter Speed Value',
              ),
              const SizedBox(height: 30),

              // Dropdown to select the input speed unit
              _buildStyledDropdown(
                value: _selectedInputUnit,
                onChanged: (String? newUnit) {
                  setState(() {
                    _selectedInputUnit = newUnit!;
                  });
                },
                items: _speedUnits,
                context: context,
                label: 'Select Input Unit',
              ),
              const SizedBox(height: 30),

              // Dropdown to select the output speed unit
              _buildStyledDropdown(
                value: _selectedOutputUnit,
                onChanged: (String? newUnit) {
                  setState(() {
                    _selectedOutputUnit = newUnit!;
                  });
                },
                items: _speedUnits,
                context: context,
                label: 'Select Output Unit',
              ),
              const SizedBox(height: 30),

              // Button to trigger the conversion
              ElevatedButton(
                onPressed: _convertSpeed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Convert Speed',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),

              // Display the converted speed value
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: Text(
                  'Converted Speed: ${_convertedSpeed.toStringAsFixed(2)} $_selectedOutputUnit',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for styled TextField
  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.brown),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper method for custom-styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
    required List<String> items,
    required BuildContext context,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          dropdownColor: Colors.blue[50],
          style: const TextStyle(fontSize: 18, color: Colors.brown),
          items: items.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          hint: Text(label, style: const TextStyle(color: Colors.blueAccent)),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.brown),
        ),
      ),
    );
  }
}








////////////////volume conversion///////
// Volume Conversion Screen

class VolumeConverter extends StatefulWidget {
  const VolumeConverter({Key? key}) : super(key: key);

  @override
  _VolumeConverterState createState() => _VolumeConverterState();
}

class _VolumeConverterState extends State<VolumeConverter> {
  final TextEditingController _volumeController = TextEditingController();
  double _convertedVolume = 0.0;
  String _selectedInputUnit = 'Liters';
  String _selectedOutputUnit = 'Gallons';

  final List<String> _volumeUnits = [
    'Liters',
    'Gallons',
    'Milliliters',
    'Cups',
  ];

  final Map<String, double> _conversionFactors = {
    'Liters to Gallons': 0.264172,
    'Liters to Milliliters': 1000.0,
    'Liters to Cups': 4.22675,
    'Gallons to Liters': 3.78541,
    'Gallons to Milliliters': 3785.41,
    'Gallons to Cups': 16.0,
    'Milliliters to Liters': 0.001,
    'Milliliters to Gallons': 0.000264172,
    'Milliliters to Cups': 0.00422675,
    'Cups to Liters': 0.236588,
    'Cups to Gallons': 0.0625,
    'Cups to Milliliters': 236.588,
  };

  void _convertVolume() {
    setState(() {
      double inputVolume = double.tryParse(_volumeController.text) ?? 0.0;
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedVolume = inputVolume * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volume Converter'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for volume value
            _buildStyledTextField(),
            const SizedBox(height: 20),

            // Dropdown to select the input volume unit
            _buildStyledDropdown(
              value: _selectedInputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedInputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown to select the output volume unit
            _buildStyledDropdown(
              value: _selectedOutputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedOutputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button to trigger the conversion
            _buildConvertButton(),
            const SizedBox(height: 20),

            // Display the converted volume value
            _buildConvertedVolumeDisplay(),
          ],
        ),
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField() {
    return TextField(
      controller: _volumeController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.brown),
      decoration: InputDecoration(
        labelText: 'Enter Volume Value',
        labelStyle: const TextStyle(color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper for Styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.brown),
          items: _volumeUnits.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.brown),
        ),
      ),
    );
  }

  // Button to trigger the conversion
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertVolume,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert Volume',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Display the converted volume value
  Widget _buildConvertedVolumeDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Text(
        'Converted Volume: ${_convertedVolume.toStringAsFixed(2)} $_selectedOutputUnit',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
        textAlign: TextAlign.center,
      ),
    );
  }
}







// Weight Conversion Screen


class WeightConverter extends StatefulWidget {
  const WeightConverter({Key? key}) : super(key: key);

  @override
  _WeightConverterState createState() => _WeightConverterState();
}

class _WeightConverterState extends State<WeightConverter> {
  final TextEditingController _weightController = TextEditingController();
  double _convertedWeight = 0.0;
  String _selectedInputUnit = 'Kilograms';
  String _selectedOutputUnit = 'Pounds';

  final List<String> _weightUnits = [
    'Kilograms',
    'Pounds',
    'Grams',
    'Ounces',
  ];

  final Map<String, double> _conversionFactors = {
    'Kilograms to Pounds': 2.20462,
    'Kilograms to Grams': 1000.0,
    'Kilograms to Ounces': 35.274,
    'Pounds to Kilograms': 0.453592,
    'Pounds to Grams': 453.592,
    'Pounds to Ounces': 16.0,
    'Grams to Kilograms': 0.001,
    'Grams to Pounds': 0.00220462,
    'Grams to Ounces': 0.035274,
    'Ounces to Kilograms': 0.0283495,
    'Ounces to Pounds': 0.0625,
    'Ounces to Grams': 28.3495,
  };

  void _convertWeight() {
    setState(() {
      double inputWeight = double.tryParse(_weightController.text) ?? 0.0;
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedWeight = inputWeight * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Converter'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white, // Keeping the background white
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for weight value
            _buildStyledTextField(),
            const SizedBox(height: 20),

            // Dropdown to select the input weight unit
            _buildStyledDropdown(
              value: _selectedInputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedInputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown to select the output weight unit
            _buildStyledDropdown(
              value: _selectedOutputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedOutputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button to trigger the conversion
            _buildConvertButton(),
            const SizedBox(height: 20),

            // Display the converted weight value
            _buildConvertedWeightDisplay(),
          ],
        ),
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField() {
    return TextField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.brown),
      decoration: InputDecoration(
        labelText: 'Enter Weight Value',
        labelStyle: const TextStyle(color: Colors.greenAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.greenAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper for Styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.brown),
          items: _weightUnits.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.brown),
        ),
      ),
    );
  }

  // Button to trigger the conversion
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertWeight,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert Weight',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Display the converted weight value
  Widget _buildConvertedWeightDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent, width: 2),
      ),
      child: Text(
        'Converted Weight: ${_convertedWeight.toStringAsFixed(2)} $_selectedOutputUnit',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
        textAlign: TextAlign.center,
      ),
    );
  }
}






// Length Conversion Screen

class LengthConverter extends StatefulWidget {
  const LengthConverter({Key? key}) : super(key: key);

  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  final TextEditingController _lengthController = TextEditingController();
  double _convertedLength = 0.0;
  String _selectedInputUnit = 'Meters';
  String _selectedOutputUnit = 'Kilometers';

  final List<String> _lengthUnits = [
    'Meters',
    'Kilometers',
    'Miles',
    'Feet',
    'Inches',
    'Centimeters',
  ];

  final Map<String, double> _conversionFactors = {
    'Meters to Kilometers': 0.001,
    'Meters to Miles': 0.000621371,
    'Meters to Feet': 3.28084,
    'Meters to Inches': 39.3701,
    'Meters to Centimeters': 100.0,
    'Kilometers to Meters': 1000.0,
    'Kilometers to Miles': 0.621371,
    'Kilometers to Feet': 3280.84,
    'Kilometers to Inches': 39370.1,
    'Miles to Meters': 1609.34,
    'Miles to Kilometers': 1.60934,
    'Miles to Feet': 5280.0,
    'Feet to Meters': 0.3048,
    'Feet to Kilometers': 0.0003048,
    'Feet to Miles': 0.000189394,
    'Inches to Meters': 0.0254,
    'Inches to Kilometers': 0.0000254,
    'Inches to Miles': 0.0000157828,
    'Inches to Feet': 0.0833333,
    'Centimeters to Meters': 0.01,
    'Centimeters to Kilometers': 0.00001,
    'Centimeters to Miles': 0.00000621371,
    'Centimeters to Feet': 0.0328084,
    'Centimeters to Inches': 0.393701,
  };

  void _convertLength() {
    setState(() {
      double inputLength = double.tryParse(_lengthController.text) ?? 0.0;
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedLength = inputLength * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Length Converter'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for length value
            _buildStyledTextField(),
            const SizedBox(height: 20),

            // Dropdown to select the input length unit
            _buildStyledDropdown(
              value: _selectedInputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedInputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown to select the output length unit
            _buildStyledDropdown(
              value: _selectedOutputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedOutputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button to trigger the conversion
            _buildConvertButton(),
            const SizedBox(height: 20),

            // Display the converted length value
            _buildConvertedLengthDisplay(),
          ],
        ),
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField() {
    return TextField(
      controller: _lengthController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.brown),
      decoration: InputDecoration(
        labelText: 'Enter Length Value',
        labelStyle: const TextStyle(color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper for Styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.brown),
          items: _lengthUnits.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.brown),
        ),
      ),
    );
  }

  // Button to trigger the conversion
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertLength,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert Length',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Display the converted length value
  Widget _buildConvertedLengthDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Text(
        'Converted Length: ${_convertedLength.toStringAsFixed(2)} $_selectedOutputUnit',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
        textAlign: TextAlign.center,
      ),
    );
  }
}




// Digital Storage Conversion Screen

class DigitalStorageConverter extends StatefulWidget {
  const DigitalStorageConverter({Key? key}) : super(key: key);

  @override
  _DigitalStorageConverterState createState() => _DigitalStorageConverterState();
}

class _DigitalStorageConverterState extends State<DigitalStorageConverter> {
  final TextEditingController _storageController = TextEditingController();
  double _convertedStorage = 0.0;
  String _selectedInputUnit = 'Bytes';
  String _selectedOutputUnit = 'Kilobytes';

  final List<String> _storageUnits = [
    'Bytes',
    'Kilobytes',
    'Megabytes',
    'Gigabytes',
    'Terabytes',
  ];

  // Conversion factors for digital storage units
  final Map<String, double> _conversionFactors = {
    'Bytes to Kilobytes': 0.001,
    'Bytes to Megabytes': 0.000001,
    'Bytes to Gigabytes': 0.000000001,
    'Bytes to Terabytes': 0.000000000001,
    'Kilobytes to Bytes': 1000.0,
    'Kilobytes to Megabytes': 0.001,
    'Kilobytes to Gigabytes': 0.000001,
    'Kilobytes to Terabytes': 0.000000001,
    'Megabytes to Bytes': 1000000.0,
    'Megabytes to Kilobytes': 1000.0,
    'Megabytes to Gigabytes': 0.001,
    'Megabytes to Terabytes': 0.000001,
    'Gigabytes to Bytes': 1000000000.0,
    'Gigabytes to Kilobytes': 1000000.0,
    'Gigabytes to Megabytes': 1000.0,
    'Gigabytes to Terabytes': 0.001,
    'Terabytes to Bytes': 1000000000000.0,
    'Terabytes to Kilobytes': 1000000000.0,
    'Terabytes to Megabytes': 1000000.0,
    'Terabytes to Gigabytes': 1000.0,
  };

  void _convertStorage() {
    setState(() {
      double inputStorage = double.tryParse(_storageController.text) ?? 0.0;
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedStorage = inputStorage * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Storage Converter'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for storage value
            _buildStyledTextField(),
            const SizedBox(height: 20),

            // Dropdown to select the input storage unit
            _buildStyledDropdown(
              value: _selectedInputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedInputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown to select the output storage unit
            _buildStyledDropdown(
              value: _selectedOutputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedOutputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button to trigger the conversion
            _buildConvertButton(),
            const SizedBox(height: 20),

            // Display the converted storage value
            _buildConvertedStorageDisplay(),
          ],
        ),
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField() {
    return TextField(
      controller: _storageController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.brown),
      decoration: InputDecoration(
        labelText: 'Enter Storage Value',
        labelStyle: const TextStyle(color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper for Styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.brown),
          items: _storageUnits.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.brown),
        ),
      ),
    );
  }

  // Button to trigger the conversion
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertStorage,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert Storage',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Display the converted storage value
  Widget _buildConvertedStorageDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Text(
        'Converted Storage: ${_convertedStorage.toStringAsFixed(2)} $_selectedOutputUnit',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
        textAlign: TextAlign.center,
      ),
    );
  }
}





// Power Conversion Screen


class PowerConverter extends StatefulWidget {
  const PowerConverter({Key? key}) : super(key: key);

  @override
  _PowerConverterState createState() => _PowerConverterState();
}

class _PowerConverterState extends State<PowerConverter> {
  final TextEditingController _powerController = TextEditingController();
  double _convertedPower = 0.0;
  String _selectedInputUnit = 'Watts';
  String _selectedOutputUnit = 'Kilowatts';

  final List<String> _powerUnits = [
    'Watts',
    'Kilowatts',
    'Horsepower',
  ];

  // Conversion factors for power units
  final Map<String, double> _conversionFactors = {
    'Watts to Kilowatts': 0.001,
    'Watts to Horsepower': 0.00134102,
    'Kilowatts to Watts': 1000.0,
    'Kilowatts to Horsepower': 1.34102,
    'Horsepower to Watts': 745.7,
    'Horsepower to Kilowatts': 0.7457,
  };

  void _convertPower() {
    setState(() {
      double inputPower = double.tryParse(_powerController.text) ?? 0.0;
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedPower = inputPower * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Converter'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for power value
            _buildStyledTextField(),
            const SizedBox(height: 20),

            // Dropdown to select the input power unit
            _buildStyledDropdown(
              value: _selectedInputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedInputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown to select the output power unit
            _buildStyledDropdown(
              value: _selectedOutputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedOutputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button to trigger the conversion
            _buildConvertButton(),
            const SizedBox(height: 20),

            // Display the converted power value
            _buildConvertedPowerDisplay(),
          ],
        ),
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField() {
    return TextField(
      controller: _powerController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: 'Enter Power Value',
        labelStyle: const TextStyle(color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper for Styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
          items: _powerUnits.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
        ),
      ),
    );
  }

  // Button to trigger the conversion
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertPower,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert Power',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Display the converted power value
  Widget _buildConvertedPowerDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple, width: 2),
      ),
      child: Text(
        'Converted Power: ${_convertedPower.toStringAsFixed(2)} $_selectedOutputUnit',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        textAlign: TextAlign.center,
      ),
    );
  }
}







// Pressure Conversion Screen


class PressureConverter extends StatefulWidget {
  const PressureConverter({Key? key}) : super(key: key);

  @override
  _PressureConverterState createState() => _PressureConverterState();
}

class _PressureConverterState extends State<PressureConverter> {
  final TextEditingController _pressureController = TextEditingController();
  double _convertedPressure = 0.0;
  String _selectedInputUnit = 'Pascals';
  String _selectedOutputUnit = 'PSI';

  final List<String> _pressureUnits = [
    'Pascals',
    'PSI',
    'Bar',
    'Atmosphere',
  ];

  // Conversion factors for pressure units
  final Map<String, double> _conversionFactors = {
    'Pascals to PSI': 0.0001450377,
    'Pascals to Bar': 1e-5,
    'Pascals to Atmosphere': 9.86923e-6,
    'PSI to Pascals': 6894.76,
    'PSI to Bar': 0.0689476,
    'PSI to Atmosphere': 0.06804596,
    'Bar to Pascals': 100000,
    'Bar to PSI': 14.5038,
    'Bar to Atmosphere': 0.986923,
    'Atmosphere to Pascals': 101325,
    'Atmosphere to PSI': 14.696,
    'Atmosphere to Bar': 1.01325,
  };

  void _convertPressure() {
    setState(() {
      double inputPressure = double.tryParse(_pressureController.text) ?? 0.0;
      String conversionKey = '$_selectedInputUnit to $_selectedOutputUnit';
      double conversionFactor = _conversionFactors[conversionKey] ?? 1.0;

      _convertedPressure = inputPressure * conversionFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pressure Converter'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field for pressure value
            _buildStyledTextField(),
            const SizedBox(height: 20),

            // Dropdown to select the input pressure unit
            _buildStyledDropdown(
              value: _selectedInputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedInputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown to select the output pressure unit
            _buildStyledDropdown(
              value: _selectedOutputUnit,
              onChanged: (String? newUnit) {
                setState(() {
                  _selectedOutputUnit = newUnit!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Button to trigger the conversion
            _buildConvertButton(),
            const SizedBox(height: 20),

            // Display the converted pressure value
            _buildConvertedPressureDisplay(),
          ],
        ),
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField() {
    return TextField(
      controller: _pressureController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        labelText: 'Enter Pressure Value',
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper for Styled Dropdown
  Widget _buildStyledDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.teal),
          items: _pressureUnits.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
        ),
      ),
    );
  }

  // Button to trigger the conversion
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertPressure,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert Pressure',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // Display the converted pressure value
  Widget _buildConvertedPressureDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal, width: 2),
      ),
      child: Text(
        'Converted Pressure: ${_convertedPressure.toStringAsFixed(2)} $_selectedOutputUnit',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
        textAlign: TextAlign.center,
      ),
    );
  }
}
