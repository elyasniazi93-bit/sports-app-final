import 'package:flutter/material.dart';
import '../lang_manager.dart'; 
import 'workout_timer_screen.dart';
import 'premium_screen.dart';

class DaysScreen extends StatefulWidget {
  final String categoryTitle;
  final bool isCategoryVIP;

  const DaysScreen({super.key, required this.categoryTitle, required this.isCategoryVIP});

  @override
  State<DaysScreen> createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  bool _isUserVIP = false;

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
    final bool isFreeCategory = widget.categoryTitle == LangManager.get('ex_abs') || 
                                widget.categoryTitle == LangManager.get('ex_legs');
    
    bool isEntireCategoryLocked = widget.isCategoryVIP && !_isUserVIP && !isFreeCategory;

    return Directionality(
      textDirection: LangManager.direction,
      child: Scaffold(
        backgroundColor: const Color(0xFF070708),
        appBar: AppBar(
          title: Text('${LangManager.get('app_title')} - ${widget.categoryTitle}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          backgroundColor: const Color(0xFF13131A),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: 30,
                itemBuilder: (context, index) {
                  // متغیر بسیار مهم: شماره واقعی روز (از ۱ تا ۳۰)
                  int dayNumber = index + 1;
                  
                  bool isDayLocked = false;
                  if (!isFreeCategory) {
                    isDayLocked = isEntireCategoryLocked || (dayNumber > 5 && !_isUserVIP);
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF13131A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.03)),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      leading: Icon(
                        Icons.calendar_today_rounded,
                        color: isDayLocked ? Colors.white38 : Colors.amber,
                        size: 22,
                      ),
                      title: Text(
                        '${LangManager.get('day_prefix')} $dayNumber: ${LangManager.get('day_suffix')}',
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        isDayLocked ? Icons.lock_outline_rounded : (LangManager.currentLang == 'en' ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded),
                        color: isDayLocked ? Colors.amber : Colors.green,
                        size: 18,
                      ),
                      onTap: () {
                        if (isDayLocked) {
                          _navigateToPremium();
                        } else {
                          // 🚀 این خط کاملاً اصلاح شد تا شماره روز واقعی ارسال شود و حرکات هروز عوض شوند
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutTimerScreen(
                                dayNumber: dayNumber, // ارسال متغیر صحیح روز
                                categoryTitle: widget.categoryTitle,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            if (!_isUserVIP && !isFreeCategory)
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
              ),
          ],
        ),
      ),
    );
  }
}
