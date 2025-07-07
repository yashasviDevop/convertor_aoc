import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'converters.dart'; // Import the single file containing all converters
import 'bmi.dart';
import 'currency.dart';
import 'proportion.dart';
import 'primechecker.dart';
import 'percentage.dart';
import 'average.dart';
import 'age.dart';
import 'salestax.dart';

void main() => runApp(AOCApp());

class AOCApp extends StatefulWidget {
  @override
  _AOCAppState createState() => _AOCAppState();
}

class _AOCAppState extends State<AOCApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference(); // Load saved theme preference
  }

  // Load theme preference
  Future<void> _loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Function to toggle the theme
  void _toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AOC Converter',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(
        isDarkMode: _isDarkMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomeScreen({Key? key, required this.isDarkMode, required this.toggleTheme})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  final List<Map<String, dynamic>> _converters = [
    {
      'label': 'Currency Converter',
      'icon': 'images/currency.png',
      'page': const CurrencyConverter(),
    },
    {
      'label': 'Body Mass Index',
      'icon': 'images/bmi.png',
      'page': const BMICalculator(),
    },
    {
      'label': 'Age Calculator',
      'icon': 'images/age.png',
      'page': const AgeCalculator(),
    },
    {
      'label': 'Sales Tax',
      'icon': 'images/sales.png',
      'page': const SalesTaxCalculator(),
    },
    {
      'label': 'Temperature Converter',
      'icon': 'images/temperature.png',
      'page': const TemperatureConverter(),
    },
    {
      'label': 'Area Converter',
      'icon': 'images/area.png',
      'page': const AreaConverter(),
    },
    {
      'label': 'Weight Converter',
      'icon': 'images/weight.png',
      'page': const WeightConverter(),
    },
    {
      'label': 'Length Converter',
      'icon': 'images/LengthConverter.png',
      'page': const LengthConverter(),
    },
    {
      'label': 'Volume Converter',
      'icon': 'images/volume.png',
      'page': const VolumeConverter(),
    },
    {
      'label': 'Time Converter',
      'icon': 'images/time.png',
      'page': const TimeConverter(),
    },
    {
      'label': 'Speed Converter',
      'icon': 'images/speed.png',
      'page': const SpeedConverter(),
    },
    {
      'label': 'Digital Storage Converter',
      'icon': 'images/digital_storage.png',
      'page': const DigitalStorageConverter(),
    },
    {
      'label': 'Power Converter',
      'icon': 'images/power.png',
      'page': const PowerConverter(),
    },
    {
      'label': 'Pressure Converter',
      'icon': 'images/pressure.png',
      'page': const PressureConverter(),
    },
    {
      'label': 'Proportion Converter',
      'icon': 'images/porportion.png',
      'page': const ProportionConverter(),
    },
    {
      'label': 'Prime Checker',
      'icon': 'images/prime.png',
      'page': const PrimeChecker(),
    },
    {
      'label': 'Percentage Calculator',
      'icon': 'images/percentage.png',
      'page': const PercentageCalculator(),
    },
    {
      'label': 'Average Calculator',
      'icon': 'images/avg.png',
      'page': const AverageCalculator(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredConverters = _converters.where((converter) {
      return converter['label']
          .toLowerCase()
          .contains(_searchText.toLowerCase());
    }).toList();

    return WillPopScope(
      onWillPop: () async {
        if (_searchText.isNotEmpty) {
          setState(() {
            _searchText = '';
            _searchController.clear(); // Clear the search field
          });
          return false; // Prevent exiting the app
        }
        return true; // Allow exiting the app
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AOC - All in One Converter'),
          actions: [
            IconButton(
              icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
              onPressed: widget.toggleTheme,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Text(
                  'AOC Converter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to About Us page
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('About Us'),
                        content: const Text('This is a converter app. This is an Offline Application use anywhere any time. Made By Patel Yashasvi. Updated every Month.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: widget.isDarkMode,
                  onChanged: (value) {
                    widget.toggleTheme(); // Toggle theme when switch is changed
                  },
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Converters',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
              ),
              const SizedBox(height: 10),
              // Grid View
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Two buttons in each row
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: filteredConverters.map<Widget>((converter) {
                    return _buildIconButton(
                      context,
                      converter['icon'],
                      converter['label'],
                      converter['page'],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom function to build icon buttons
  Widget _buildIconButton(
      BuildContext context, String iconPath, String label, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
