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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PriceME')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'ITEM NAME: '),
            ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ITEM PRICE: ', prefixText: '\$'),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'LABOR HOURS: '),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('CALCULATE'),
              ),
          ],
        ),
      ),
    );
  }
}
