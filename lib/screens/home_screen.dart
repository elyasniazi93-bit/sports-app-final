import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../lang_manager.dart';
import '../models/category_data.dart';
import 'days_screen.dart';
import 'premium_screen.dart';
import 'profile_screen.dart';
import 'support_screen.dart';
import 'diet_screen.dart'; // وارد کردن صفحه رژیم جدید

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isUserVIP = false;
  int _currentIndex = 0; 

  void _navigateToPremium() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => PremiumScreen(
          onPaymentSuccess: () => setState(() => _isUserVIP = true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // اضافه شدن صفحه رژیم غذایی به چیدمان ناوبری برنامه
    final List<Widget> _pages = [
      _buildWorkoutBody(),  
      const DietScreen(), // 🚀 صفحه رژیم در موقعیت دکمه دوم
      const SupportScreen(), 
      const ProfileScreen(), 
    ];

    return Directionality(
      textDirection: LangManager.direction,
      child: Scaffold(
        backgroundColor: const Color(0xFF070708),
        body: _pages[_currentIndex], 
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: const Color(0xFF13131A),
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white38,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            type: BottomNavigationBarType.fixed, // هماهنگی کامل برای چیدمان ۴ دکمه مستقل
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.fitness_center_rounded),
                label: LangManager.get('nav_workout'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.restaurant_menu_rounded), // 🚀 دکمه جدید رژیم غذایی
                label: LangManager.get('nav_diet'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.report_problem_rounded),
                label: LangManager.get('nav_support'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_rounded),
                label: LangManager.get('nav_profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutBody() {
    final List<Map<String, dynamic>> workoutCategories = CategoryData.getCategories();

    return Scaffold(
      backgroundColor: const Color(0xFF070708),
      appBar: AppBar(
        title: Text(LangManager.get('app_title'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF13131A),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: workoutCategories.length,
              itemBuilder: (context, index) {
                final category = workoutCategories[index];
                bool isLocked = category['isVIP'] && !_isUserVIP;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF13131A), 
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.03)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: Icon(category['icon'], color: isLocked ? Colors.white38 : Colors.amber, size: 28),
                    title: Text(
                      category['title'], 
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      isLocked ? Icons.lock_outline_rounded : (LangManager.currentLang == 'en' ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded), 
                      color: isLocked ? Colors.amber : Colors.green, 
                      size: 20,
                    ),
                    onTap: () {
                      if (isLocked) {
                        _navigateToPremium();
                      } else {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => DaysScreen(
                              categoryTitle: category['title'], 
                              isCategoryVIP: category['isVIP'],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ).animate().fadeIn(delay: (index * 100).ms, duration: 400.ms).slideY(begin: 0.2, end: 0);
              },
            ),
          ),
          if (!_isUserVIP)
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFB300), Color(0xFFFF8F00)]), 
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LangManager.get('vip_banner'), style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: _navigateToPremium, 
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), 
                    child: const Text('۳.۹۹\$', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms).scale(curve: Curves.elasticOut, duration: 600.ms),
        ],
      ),
    );
  }
}
