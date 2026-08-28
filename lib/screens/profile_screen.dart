import 'package:flutter/material.dart';
import '../lang_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070708),
      appBar: AppBar(
        title: Text(LangManager.get('nav_profile'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF13131A),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 2),
                      color: Colors.amber.withOpacity(0.1),
                    ),
                    child: const Center(
                      child: Text('E', style: TextStyle(color: Colors.amber, fontSize: 44, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const CircleAvatar(backgroundColor: Colors.green, radius: 14, child: Icon(Icons.check, color: Colors.white, size: 16))
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Elyas Niazi', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('elyasniazi93@gmail.com', style: TextStyle(color: Colors.white38, fontSize: 14)),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF13131A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.stars_rounded, color: Colors.amber, size: 28),
                      const SizedBox(width: 12),
                      Text(LangManager.get('prof_status'), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(color: Colors.amber.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                    child: const Text('VIP ✨', style: TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF13131A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LangManager.get('prof_days'), style: const TextStyle(color: Colors.white38)),
                      Text(LangManager.get('prof_days_val'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Colors.white10),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LangManager.get('prof_focus'), style: const TextStyle(color: Colors.white38)),
                      Text(LangManager.get('ex_abs'), style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                label: Text(LangManager.get('prof_logout'), style: const TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
