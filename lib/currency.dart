import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0.0;
  bool _isForeignToNational = true; // True for Foreign to National, False for National to Foreign
  String _selectedCurrency = 'USD'; // Default currency

  // Updated Conversion rates
  final Map<String, double> conversionRates = {
    'USD': 82.7,
    'AED': 22.5,
    'THB': 2.3,
    'MYR': 18.0,
    'JPY': 0.57,
    'KRW': 0.062,
    'OMR': 214.5,
    'BHD': 218.3,
    'CNY': 11.5,
  };

  // Sample data for each country (budget, famous places, Indian restaurants)
  final Map<String, Map<String, String>> countryData = {
    'USD': {
      'budget': 'Average daily budget for Indians in the US: ₹7000-₹9000',
      'places': 'Famous places: Statue of Liberty, Grand Canyon, Times Square',
      'restaurants': 'Popular Indian Restaurants: Junoon, Bukhara Grill, Tamarind'
    },
    'AED': {
      'budget': 'Average daily budget for Indians in AFD: ₹5000-₹7000',
      'places': 'Famous places: Burj Khalifa, Dubai Mall, Palm Jumeirah',
      'restaurants': 'Popular Indian Restaurants: Rang Mahal, Amritsr, Bombay Brasserie'
    },
    'THB': {
      'budget': 'Average daily budget for Indians in Thailand: ₹3000-₹5000',
      'places': 'Famous places: The Grand Palace, Phuket, Chiang Mai',
      'restaurants': 'Popular Indian Restaurants: Gaggan, Indus, Mrs. Balbir\'s'
    },
    'MYR': {
      'budget': 'Average daily budget for Indians in Malaysia: ₹3500-₹5500',
      'places': 'Famous places: Petronas Towers, Batu Caves, Langkawi',
      'restaurants': 'Popular Indian Restaurants: Spice Garden, Passage Thru India, Betel Leaf'
    },
    'JPY': {
      'budget': 'Average daily budget for Indians in Japan: ₹8000-₹10000',
      'places': 'Famous places: Mount Fuji, Tokyo Tower, Kyoto Temples',
      'restaurants': 'Popular Indian Restaurants: Nataraj, Dhaba India, Nirvanam'
    },
    'KRW': {
      'budget': 'Average daily budget for Indians in Korea: ₹6000-₹8000',
      'places': 'Famous places: Gyeongbokgung Palace, Jeju Island, Bukchon Hanok Village',
      'restaurants': 'Popular Indian Restaurants: Jyoti Restaurant, Taj Palace, Chakraa'
    },
    'OMR': {
      'budget': 'Average daily budget for Indians in Oman: ₹5000-₹7000',
      'places': 'Famous places: Sultan Qaboos Grand Mosque, Wahiba Sands, Musandam',
      'restaurants': 'Popular Indian Restaurants: Mumtaz Mahal, Begum\'s, Copper Chimney'
    },
    'BHD': {
      'budget': 'Average daily budget for Indians in Bahrain: ₹5500-₹7500',
      'places': 'Famous places: Bahrain National Museum, Al Fateh Grand Mosque, Amwaj Islands',
      'restaurants': 'Popular Indian Restaurants: Nirvana, Copper Chimney, Lanterns'
    },
    'CNY': {
      'budget': 'Average daily budget for Indians in China: ₹4000-₹6000',
      'places': 'Famous places: The Great Wall, Forbidden City, Terracotta Army',
      'restaurants': 'Popular Indian Restaurants: Ganges, Tandoor, Raj Indian Restaurant'
    },
    // Additional country data omitted for brevity...
  };

  void _convertCurrency() {
    setState(() {
      if (_amountController.text.isNotEmpty && conversionRates.containsKey(_selectedCurrency)) {
        double amount = double.parse(_amountController.text);
        double rate = conversionRates[_selectedCurrency] ?? 0.0;
        if (_isForeignToNational) {
          _convertedAmount = amount * rate;
        } else {
          _convertedAmount = amount / rate;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on, size: 32, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Currency Conversion',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[700]),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Dropdown to select the foreign currency
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  value: _selectedCurrency,
                  isExpanded: true,
                  items: conversionRates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newCurrency) {
                    setState(() {
                      _selectedCurrency = newCurrency ?? 'USD';
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // TextField to input the amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _isForeignToNational ? 'Amount in $_selectedCurrency' : 'Amount in INR',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Foreign to National'),
                Switch(
                  value: _isForeignToNational,
                  activeColor: Colors.teal,
                  onChanged: (bool value) {
                    setState(() {
                      _isForeignToNational = value;
                    });
                  },
                ),
                const Text('National to Foreign'),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _convertCurrency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('Convert'),
              ),
            ),
            const SizedBox(height: 20),
            if (_amountController.text.isNotEmpty)
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _isForeignToNational
                            ? 'Converted Amount: $_convertedAmount INR'
                            : 'Converted Amount: $_convertedAmount $_selectedCurrency',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            if (_convertedAmount != 0.0 && countryData.containsKey(_selectedCurrency))
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Travel Information:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Average Budget: ${countryData[_selectedCurrency]?['budget'] ?? 'Data not available'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Famous Places: ${countryData[_selectedCurrency]?['places'] ?? 'Data not available'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Famous Indian Restaurants: ${countryData[_selectedCurrency]?['restaurants'] ?? 'Data not available'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
