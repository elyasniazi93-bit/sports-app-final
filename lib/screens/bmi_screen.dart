import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../lang_manager.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _bmiResult;
  String _bmiStatus = '';
  Color _statusColor = Colors.white;

  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text);

    if (weight == null || height == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LangManager.get('bmi_error')), backgroundColor: Colors.red),
      );
      return;
    }

    final double heightInMeters = height / 100;
    setState(() {
      _bmiResult = weight / (heightInMeters * heightInMeters);

      if (_bmiResult! < 18.5) {
        _bmiStatus = LangManager.get('bmi_under');
        _statusColor = Colors.blue.shade400;
      } else if (_bmiResult! >= 18.5 && _bmiResult! < 25) {
        _bmiStatus = LangManager.get('bmi_normal');
        _statusColor = Colors.green.shade400;
      } else if (_bmiResult! >= 25 && _bmiResult! < 30) {
        _bmiStatus = LangManager.get('bmi_over');
        _statusColor = Colors.orange.shade400;
      } else {
        _bmiStatus = LangManager.get('bmi_obese');
        _statusColor = Colors.red.shade400;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LangManager.direction,
      child: Scaffold(
        backgroundColor: const Color(0xFF070708),
        appBar: AppBar(
          title: Text(LangManager.get('bmi_title'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          backgroundColor: const Color(0xFF13131A),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              LangManager.currentLang == 'en' 
                  ? Icons.arrow_back_ios_new_rounded 
                  : Icons.arrow_forward_ios_rounded,
              color: Colors.amber,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: LangManager.get('bmi_weight'),
                  labelStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: const Color(0xFF13131A),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.monitor_weight_rounded, color: Colors.amber),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: LangManager.get('bmi_height'),
                  labelStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: const Color(0xFF13131A),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.straighten_rounded, color: Colors.amber),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(LangManager.get('bmi_btn'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),

              if (_bmiResult != null) ...[
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF13131A),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _statusColor.withOpacity(0.15), width: 1.5),
                    boxShadow: [
                      BoxShadow(color: _statusColor.withOpacity(0.05), blurRadius: 30, spreadRadius: 2)
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(LangManager.get('bmi_result'), style: const TextStyle(color: Colors.white60, fontSize: 14)),
                      const SizedBox(height: 8),
                      Text(
                        _bmiResult!.toStringAsFixed(1),
                        style: TextStyle(color: _statusColor, fontSize: 50, fontWeight: FontWeight.bold, letterSpacing: 1), // فونت ویت به بولد اصلاح شد
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white10, height: 1),
                      const SizedBox(height: 16),
                      Text(LangManager.get('bmi_status'), style: const TextStyle(color: Colors.white60, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text(
                        _bmiStatus,
                        style: TextStyle(color: _statusColor, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).animate().scale(curve: Curves.easeOutBack, duration: 400.ms).fadeIn(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
