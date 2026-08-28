import 'package:flutter/material.dart';
import '../lang_manager.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        backgroundColor: const Color(0xFF070708),
        appBar: AppBar(
          title: Text(LangManager.get('diet_title'), style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF13131A),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white38,
            tabs: [
              Tab(text: LangManager.get('diet_allowed')),
              Tab(text: LangManager.get('diet_forbidden')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // برگه اول: برنامه فیکس صبح، چاشت و شب
            ListView(
              padding: const EdgeInsets.all(24),
              children: [
                buildMealCard(LangManager.get('diet_breakfast_title'), LangManager.get('diet_breakfast_desc'), Colors.amber),
                buildMealCard(LangManager.get('diet_lunch_title'), LangManager.get('diet_lunch_desc'), Colors.orange.shade400),
                buildMealCard(LangManager.get('diet_dinner_title'), LangManager.get('diet_dinner_desc'), Colors.blue.shade400),
              ],
            ),

            // برگه دوم: ممنوعیت‌های غذایی شدید
            ListView(
              padding: const EdgeInsets.all(24),
              children: [
                buildMealCard(LangManager.get('diet_forbidden'), LangManager.get('diet_sugar'), Colors.red.shade400),
                buildMealCard(LangManager.get('diet_forbidden'), LangManager.get('diet_fast'), Colors.red.shade400),
                buildMealCard(LangManager.get('diet_forbidden'), LangManager.get('diet_trans'), Colors.red.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMealCard(String title, String description, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13131A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.12), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant_rounded, color: accentColor, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(color: accentColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            // 🚀 رنگ در این خط کاملاً اصلاح شد تا هیچ خطایی ایجاد نشود
            style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
