import 'package:flutter/material.dart';
import '../lang_manager.dart';
import 'assessment_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Map<String, Map<String, String>> _localizedText = {
    'fa': {
      'title': 'برنامه ورزشی',
      'gmail': 'ورود با حساب جیمیل',
      'guest': 'ورود به عنوان مهمان',
      'choose': 'انتخاب حساب کاربری',
      'continue': 'برای ادامه به برنامه ورزشی',
      'success': 'ورود با حساب جیمیل موفقیت‌آمیز بود 🎉'
    },
    'en': {
      'title': 'SPORTS APP',
      'gmail': 'Sign in with Gmail',
      'guest': 'Continue as Guest',
      'choose': 'Choose an account',
      'continue': 'to continue to SportsApp',
      'success': 'Signed in successfully with Gmail 🎉'
    },
    'ar': {
      'title': 'تطبيق الرياضة',
      'gmail': 'تسجيل الدخول باستخدام جوميل',
      'guest': 'دخول كضيف',
      'choose': 'اختر حساباً',
      'continue': 'للمتابعة إلى تطبيق الرياضة',
      'success': 'تم تسجيل الدخول بنجاح 🎉'
    }
  };

  void _showGoogleAccountPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 5)],
          ),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('G', style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('o', style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('o', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('g', style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('l', style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('e', style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(_localizedText[LangManager.currentLang]!['choose']!, style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(_localizedText[LangManager.currentLang]!['continue']!, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 20),
                const Divider(height: 1),
                ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.amber, child: Text('E', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                  title: const Text('Elyas Niazi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  subtitle: const Text('elyasniazi93@gmail.com', style: TextStyle(color: Colors.black54)),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(_localizedText[LangManager.currentLang]!['success']!), backgroundColor: Colors.green.shade600),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AssessmentScreen()));
                  },
                ),
                const Divider(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var t = _localizedText[LangManager.currentLang]!;
    return Scaffold(
      backgroundColor: const Color(0xFF070708),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // منوی تغییر زبان با قابلیت ری‌لود زنده کل اپلیکیشن
          PopupMenuButton<String>(
            icon: const Icon(Icons.language_rounded, color: Colors.amber, size: 28),
            onSelected: (String lang) {
              setState(() {
                LangManager.currentLang = lang; // 🚀 اعمال زنده تغییرات زبان بر روی مغز متفکر برنامه
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'fa', child: Text('فارسی 🇮🇷')),
              const PopupMenuItem<String>(value: 'en', child: Text('English 🇬🇧')),
              const PopupMenuItem<String>(value: 'ar', child: Text('العربية 🇦🇪')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.fitness_center_rounded, size: 80, color: Colors.amber),
            const SizedBox(height: 24),
            Text(t['title']!, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.5), textAlign: TextAlign.center),
            const SizedBox(height: 48),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () => _showGoogleAccountPicker(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: Text(t['gmail']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 55,
              child: OutlinedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AssessmentScreen())),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.amber, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: Text(t['guest']!, style: const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
