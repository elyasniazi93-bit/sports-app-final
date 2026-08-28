import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ۳ ثانیه نمایش انیمیشن و سپس انتقال خودکار به صفحه ورود
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070708),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF13131A),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.15),
                    blurRadius: 40,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                size: 90,
                color: Colors.amber,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms)
            .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), curve: Curves.bounceOut, duration: 1000.ms)
            .then(delay: 200.ms)
            .shimmer(duration: 1200.ms, color: Colors.white24),
            const SizedBox(height: 32),
            const Text(
              'SPORTS APP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 8),
            const Text(
              '30 DAY FITNESS CHALLENGE',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
