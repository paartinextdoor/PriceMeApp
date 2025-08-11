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
  double? totalPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PriceME')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: itemNameController,
              decoration: const InputDecoration(labelText: 'ITEM NAME: '),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: materialCostController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'MATERIAL COST: ',
                prefixText: '\$',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: labourHoursController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'LABOR HOURS: '),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: calculateTotalPrice,
              child: const Text('CALCULATE'),
            ),
            const SizedBox(height: 20),
            if (totalPrice != null)
              Text('Total Price: \$${totalPrice!.toStringAsFixed(2)}'),
          ],
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
    final materialCost = double.tryParse(materialCostController.text);
    final laborHours = double.tryParse(labourHoursController.text);

    if (materialCost == null || laborHours == null) {
      setState(() {
        totalPrice = null; // or handle error
      });
      return;
    }

    const laborRate = 10.0; // example rate per hour
    setState(() {
      totalPrice = materialCost + (laborHours * laborRate);
    });
  }
}
