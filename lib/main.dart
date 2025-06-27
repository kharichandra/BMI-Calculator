import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const BMIScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  double height = 170; // in cm
  double weight = 70; // in kg

  double get bmi => weight / ((height / 100) * (height / 100));

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight 😟";
    if (bmi < 25) return "Normal 😊";
    if (bmi < 30) return "Overweight 😐";
    return "Obese 😟";
  }

  Color getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blueAccent;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.redAccent;
  }

  void resetValues() {
    setState(() {
      height = 170;
      weight = 70;
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = getBMICategory(bmi);
    final bmiColor = getBMIColor(bmi);

    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text("Height: ${height.toStringAsFixed(1)} cm"),
            Slider(
              value: height,
              min: 100,
              max: 220,
              divisions: 120,
              label: "${height.toStringAsFixed(1)} cm",
              onChanged: (val) => setState(() => height = val),
            ),
            const SizedBox(height: 16),
            Text("Weight: ${weight.toStringAsFixed(1)} kg"),
            Slider(
              value: weight,
              min: 30,
              max: 150,
              divisions: 120,
              label: "${weight.toStringAsFixed(1)} kg",
              onChanged: (val) => setState(() => weight = val),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bmiColor.withValues(alpha: 0.8), bmiColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    "Your BMI",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: resetValues,
              icon: const Icon(Icons.refresh),
              label: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
