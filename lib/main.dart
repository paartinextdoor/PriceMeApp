import 'package:flutter/material.dart';

void main() {
  runApp(const PriceMeApp());
}

class PriceMeApp extends StatelessWidget {
  const PriceMeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PriceME',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const PriceMeScreen(),
    );
  }
}

class PriceMeScreen extends StatefulWidget {
  const PriceMeScreen({super.key});

  @override
  State<PriceMeScreen> createState() => _PriceMeScreenState();
}

class _PriceMeScreenState extends State<PriceMeScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController materialCostController = TextEditingController();
  TextEditingController labourHoursController = TextEditingController();

  String? selectedCategory;

  final List<Map<String, String>> categories = [
    {'value': 'crotchet', 'label': 'Crotchet'},
    {'value': 'jewelry', 'label': 'Jewelry'},
    {'value': 'quilling', 'label': 'Quilling'},
    {'value': 'decor', 'label': 'Decor'},
    {'value': 'cricut cut', 'label': 'Cricut Cut'},
    {'value': 'handmade card', 'label': 'Handmade Card'},
  ];

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  double? totalPrice;

  String displayedItemName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: SizedBox(
          height: 300, // sets the maximum height for the logo
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain, // keeps the aspect ratio
          ),
        ),
        centerTitle: true, // optional, centers the logo
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50.0,
          ), // moves content down

          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: itemNameController,
                    decoration: inputDecoration('ITEM NAME: '),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    decoration: inputDecoration('Category'),
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category['value'], // internal lowercase value
                        child: Text(category['label']!), // user-friendly label
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: materialCostController,
                    decoration: inputDecoration(
                      'MATERIAL COST: ',
                    ).copyWith(prefixText: '\$'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: labourHoursController,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('LABOR HOURS: '),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: calculateTotalPrice,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFFFCD2F3),
                      foregroundColor: const Color.fromARGB(255, 90, 89, 89),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('CALCULATE'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (totalPrice != null)
                Text(
                  '$displayedItemName price: \$${totalPrice!.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    itemNameController.dispose();
    materialCostController.dispose();
    labourHoursController.dispose();
    super.dispose();
  }

  void calculateTotalPrice() {
    final materialCost = double.tryParse(materialCostController.text.trim());
    final laborHours = double.tryParse(labourHoursController.text.trim());

    // Normalize item name
    String rawName = itemNameController.text.trim();
    final itemName = rawName.isNotEmpty
        ? '${rawName[0].toUpperCase()}${rawName.substring(1)}'
        : 'Item';

    // Define labor rates in a map
    final Map<String, double> laborRates = {
      'crotchet': 20,
      'jewelry': 10,
      'decor': 10,
      'cricut cut': 5,
      'quilling': 20,
      'handmade card': 8,
    };

    // Normalize category
    final categoryKey = selectedCategory?.trim().toLowerCase();
    final laborRate = laborRates[categoryKey] ?? 0;

    if (materialCost == null || laborHours == null) {
      setState(() {
        totalPrice = null;
        displayedItemName = itemName;
      });
      return;
    }

    setState(() {
      totalPrice = materialCost + (laborHours * laborRate);
      displayedItemName = itemName;
    });
  }
}
