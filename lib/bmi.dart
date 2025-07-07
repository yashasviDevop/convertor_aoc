import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  // Controllers for BMI Calculator
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmiValue = 0.0;
  String _bmiCategory = '';
  String _bmiRisk = '';

  // Gender Selection for Weight Range Based on Height
  String _selectedGender = 'Female';
  double _selectedHeight = 150.0;

  // Complete height and weight range data
  final Map<String, Map<int, String>> _weightRanges = {
    'Female': {
      137: '63/77 lb (28.5/34.9 kg)',
      138: '63/77 lb (28.5/34.9 kg)',
      139: '63/77 lb (28.5/34.9 kg)',
      140: '68/83 lb (30.8/37.6 kg)',
      141: '68/83 lb (30.8/37.6 kg)',
      142: '72/88 lb (32.6/39.9 kg)',
      143: '72/88 lb (32.6/39.9 kg)',
      144: '72/88 lb (32.6/39.9 kg)',
      145: '77/94 lb (34.9/42.6 kg)',
      146: '77/94 lb (34.9/42.6 kg)',
      147: '81/99 lb (36.4/44.9 kg)',
      148: '81/99 lb (36.4/44.9 kg)',
      149: '81/99 lb (36.4/44.9 kg)',
      150: '86/105 lb (39.0/47.6 kg)',
      151: '86/105 lb (39.0/47.6 kg)',
      152: '90/110 lb (40.8/49.9 kg)',
      153: '90/110 lb (40.8/49.9 kg)',
      154: '90/110 lb (40.8/49.9 kg)',
      155: '95/116 lb (43.1/52.6 kg)',
      156: '95/116 lb (43.1/52.6 kg)',
      157: '99/121 lb (44.9/54.9 kg)',
      158: '99/121 lb (44.9/54.9 kg)',
      159: '99/121 lb (44.9/54.9 kg)',
      160: '104/127 lb (47.2/57.6 kg)',
      161: '104/127 lb (47.2/57.6 kg)',
      162: '104/127 lb (47.2/57.6 kg)',
      163: '108/132 lb (49.0/59.9 kg)',
      164: '108/132 lb (49.0/59.9 kg)',
      165: '113/138 lb (51.2/62.6 kg)',
      166: '113/138 lb (51.2/62.6 kg)',
      167: '113/138 lb (51.2/62.6 kg)',
      168: '117/143 lb (53.0/64.8 kg)',
      169: '117/143 lb (53.0/64.8 kg)',
      170: '122/149 lb (55.3/67.6 kg)',
      171: '122/149 lb (55.3/67.6 kg)',
      172: '122/149 lb (55.3/67.6 kg)',
      173: '126/154 lb (57.1/69.8 kg)',
      174: '126/154 lb (57.1/69.8 kg)',
      175: '131/160 lb (59.4/72.6 kg)',
      176: '131/160 lb (59.4/72.6 kg)',
      177: '135/165 lb (61.2/74.8 kg)',
      178: '135/165 lb (61.2/74.8 kg)',
      179: '135/165 lb (61.2/74.8 kg)',
      180: '140/171 lb (63.5/77.5 kg)',
      181: '140/171 lb (63.5/77.5 kg)',
      182: '144/176 lb (65.3/79.8 kg)',
      183: '144/176 lb (65.3/79.8 kg)',
      184: '149/182 lb (67.6/82.5 kg)',
      185: '149/182 lb (67.6/82.5 kg)',
      186: '153/187 lb (69.4/84.8 kg)',
      187: '153/187 lb (69.4/84.8 kg)',
      188: '158/193 lb (71.6/87.5 kg)',
      189: '158/193 lb (71.6/87.5 kg)',
      190: '162/198 lb (73.5/89.8 kg)',
      191: '162/198 lb (73.5/89.8 kg)',
      192: '162/198 lb (73.5/89.8 kg)',
      193: '162/198 lb (73.5/89.8 kg)',

    },
    'Male': {
      137: '63/77 lb (28.5/34.9 kg)',
      138: '63/77 lb (28.5/34.9 kg)',
      139: '63/77 lb (28.5/34.9 kg)',
      140: '68/84 lb (30.8/38.1 kg)',
      141: '68/84 lb (30.8/38.1 kg)',
      142: '74/90 lb (33.5/40.8 kg)',
      143: '74/90 lb (33.5/40.8 kg)',
      144: '74/90 lb (33.5/40.8 kg)',
      145: '79/97 lb (35.8/43.9 kg)',
      146: '79/97 lb (35.8/43.9 kg)',
      147: '85/103 lb (38.5/46.7 kg)',
      148: '85/103 lb (38.5/46.7 kg)',
      149: '85/103 lb (38.5/46.7 kg)',
      150: '90/110 lb (40.8/49.9 kg)',
      151: '90/110 lb (40.8/49.9 kg)',
      152: '95/117 lb (43.1/53.0 kg)',
      153: '95/117 lb (43.1/53.0 kg)',
      154: '95/117 lb (43.1/53.0 kg)',
      155: '101/123 lb (45.8/55.8 kg)',
      156: '101/123 lb (45.8/55.8 kg)',
      157: '106/130 lb (48.1/58.9 kg)',
      158: '106/130 lb (48.1/58.9 kg)',
      159: '106/130 lb (48.1/58.9 kg)',
      160: '112/136 lb (50.8/61.6 kg)',
      161: '112/136 lb (50.8/61.6 kg)',
      162: '112/136 lb (50.8/61.6 kg)',
      163: '117/143 lb (53.0/64.8 kg)',
      164: '117/143 lb (53.0/64.8 kg)',
      165: '122/150 lb (55.3/68.0 kg)',
      166: '122/150 lb (55.3/68.0 kg)',
      167: '122/150 lb (55.3/68.0 kg)',
      168: '128/156 lb (58.0/70.7 kg)',
      169: '128/156 lb (58.0/70.7 kg)',
      170: '133/163 lb (60.3/73.9 kg)',
      171: '133/163 lb (60.3/73.9 kg)',
      172: '133/163 lb (60.3/73.9 kg)',
      173: '139/169 lb (63.0/76.6 kg)',
      174: '139/169 lb (63.0/76.6 kg)',
      175: '144/176 lb (65.3/79.8 kg)',
      176: '144/176 lb (65.3/79.8 kg)',
      177: '149/183 lb (67.6/83.0 kg)',
      178: '149/183 lb (67.6/83.0 kg)',
      179: '149/183 lb (67.6/83.0 kg)',
      180: '155/189 lb (70.3/85.7 kg)',
      181: '155/189 lb (70.3/85.7 kg)',
      182: '160/196 lb (72.6/88.9 kg)',
      183: '160/196 lb (72.6/88.9 kg)',
      184: '166/202 lb (75.3/91.6 kg)',
      185: '166/202 lb (75.3/91.6 kg)',
      186: '171/209 lb (77.5/94.8 kg)',
      187: '171/209 lb (77.5/94.8 kg)',
      188: '176/216 lb (79.8/98.0 kg)',
      189: '176/216 lb (79.8/98.0 kg)',
      190: '182/222 lb (82.5/100.6 kg)',
      191: '182/222 lb (82.5/100.6 kg)',
      192: '182/222 lb (82.5/100.6 kg)',
      193: '182/222 lb (82.5/100.6 kg)',

    }
  };



  // Height Conversion Variables
  double _heightCm = 150.0;
  double _heightFeet = 4.0;
  double _heightInches = 11.0;

  // Feet/Inches to Centimeters
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  double _convertedHeightCm = 0.0;

  void _calculateBMI() {
    try {
      double height = double.parse(_heightController.text) / 100; // Convert to meters
      double weight = double.parse(_weightController.text);

      setState(() {
        _bmiValue = weight / (height * height);
        if (_bmiValue < 18.5) {
          _bmiCategory = 'Underweight';
          _bmiRisk = 'Increased';
        } else if (_bmiValue < 24.9) {
          _bmiCategory = 'Normal Weight';
          _bmiRisk = 'Least';
        } else if (_bmiValue < 29.9) {
          _bmiCategory = 'Overweight';
          _bmiRisk = 'Increased';
        } else if (_bmiValue < 34.9) {
          _bmiCategory = 'Obese Class I';
          _bmiRisk = 'High';
        } else if (_bmiValue < 39.9) {
          _bmiCategory = 'Obese Class II';
          _bmiRisk = 'Very High';
        } else {
          _bmiCategory = 'Obese Class III';
          _bmiRisk = 'Extremely High';
        }
      });
    } catch (e) {
      setState(() {
        _bmiValue = 0.0;
        _bmiCategory = 'Invalid input';
        _bmiRisk = '';
      });
    }
  }

  void _convertHeight() {
    // Convert cm to feet and inches
    _heightFeet = (_heightCm / 30.48);
    _heightInches = (_heightCm % 30.48) / 2.54;

    setState(() {
      _heightFeet = _heightFeet.floorToDouble();
      _heightInches = _heightInches.roundToDouble();
    });
  }

  void _convertFeetInchesToCm() {
    try {
      double feet = double.parse(_feetController.text);
      double inches = double.parse(_inchesController.text);

      setState(() {
        _convertedHeightCm = (feet * 30.48) + (inches * 2.54);
      });
    } catch (e) {
      setState(() {
        _convertedHeightCm = 0.0; // Reset on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI & Height Converter'),
        backgroundColor: Colors.teal,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'BMI Calculator'),
                      Tab(text: 'Weight Based on Height'),
                      Tab(text: 'Height Conversion'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // BMI Calculator View
                        _buildBMICalculatorView(),
                        // Weight Based on Height View
                        _buildWeightBasedOnHeightView(),
                        // Height Conversion View
                        _buildHeightConversionView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMICalculatorView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildStyledTextField(
            controller: _heightController,
            label: 'Enter Height (in cm)',
          ),
          const SizedBox(height: 20),
          _buildStyledTextField(
            controller: _weightController,
            label: 'Enter Weight (in kg)',
          ),
          const SizedBox(height: 20),
          _buildStyledElevatedButton(
            label: 'Calculate BMI',
            onPressed: _calculateBMI,
          ),
          const SizedBox(height: 20),
          Text(
            'BMI: ${_bmiValue.toStringAsFixed(2)}\n$_bmiCategory\nRisk: $_bmiRisk',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeightBasedOnHeightView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStyledDropdown(),
          const SizedBox(height: 20),
          _buildHeightSlider(),
          Text(
            'Selected Height: ${_selectedHeight.toString()} cm',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Recommended Weight Range: ${_weightRanges[_selectedGender]?[_selectedHeight] ?? "N/A"}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildHeightConversionView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildStyledTextField(
            controller: _heightController,
            label: 'Enter Height (in cm)',
            onChanged: (value) {
              setState(() {
                _heightCm = double.tryParse(value) ?? 0.0;
                _convertHeight();
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Converted Height: ${_heightFeet.toStringAsFixed(0)} ft ${_heightInches.toStringAsFixed(0)} in',
            style: const TextStyle(fontSize: 18),
          ),
          const Divider(height: 40, thickness: 2),
          _buildStyledTextField(
            controller: _feetController,
            label: 'Enter Feet',
          ),
          const SizedBox(height: 20),
          _buildStyledTextField(
            controller: _inchesController,
            label: 'Enter Inches',
          ),
          const SizedBox(height: 20),
          _buildStyledElevatedButton(
            label: 'Convert to cm',
            onPressed: _convertFeetInchesToCm,
          ),
          const SizedBox(height: 20),
          Text(
            'Converted Height: ${_convertedHeightCm.toStringAsFixed(2)} cm',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Helper for Styled TextField
  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        labelText: label,
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
  Widget _buildStyledDropdown() {
    return DropdownButton<String>(
      value: _selectedGender,
      items: const [
        DropdownMenuItem(value: 'Female', child: Text('Female')),
        DropdownMenuItem(value: 'Male', child: Text('Male')),
      ],
      onChanged: (String? newGender) {
        setState(() {
          _selectedGender = newGender!;
        });
      },
      style: const TextStyle(fontSize: 20, color: Colors.teal),
      underline: Container(
        height: 2,
        color: Colors.teal,
      ),
    );
  }

  // Helper for Height Slider
  Widget _buildHeightSlider() {
    return Column(
      children: [
        Slider(
          value: _selectedHeight,
          min: 137,
          max: 193,
          divisions: 100,
          label: '${_selectedHeight.toStringAsFixed(0)} cm',
          activeColor: Colors.teal,
          onChanged: (double newHeight) {
            setState(() {
              _selectedHeight = newHeight.roundToDouble();
            });
          },
        ),
      ],
    );
  }

  // Helper for Styled Elevated Button
  Widget _buildStyledElevatedButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 18,color: Colors.white)),
    );
  }
}
