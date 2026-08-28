import 'package:flutter/material.dart';
import '../lang_manager.dart';
import 'home_screen.dart'; // 🚀 این خط اضافه شد تا ارور هوم اسکرین کاملاً برطرف شود

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // دیتابیس سوالات چندزبانه متصل به منیجر زبان پویا
    final List<Map<String, dynamic>> questions = [
      {
        'title': LangManager.get('q1'),
        'options': [
          LangManager.get('ex_abs'),
          LangManager.get('ex_legs'),
          LangManager.get('ex_back'),
          LangManager.get('ex_arms'),
        ]
      },
    ];

    return Directionality(
      textDirection: LangManager.direction,
      child: Scaffold(
        backgroundColor: const Color(0xFF070708),
        appBar: AppBar(
          title: Text(LangManager.get('assessment_title'), style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF13131A),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (ctx, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          questions[index]['title'],
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: ListView.builder(
                            itemCount: questions[index]['options'].length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                height: 55,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF13131A),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  onPressed: () {
                                    if (_currentPage < questions.length - 1) {
                                      _pageController.nextPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      // انتقال روان و بدون بازگشت به صفحه اصلی پوشه‌ها
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                        (route) => false,
                                      );
                                    }
                                  },
                                  child: Text(questions[index]['options'][i], style: const TextStyle(fontSize: 16)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
