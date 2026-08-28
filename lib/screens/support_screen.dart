import 'package:flutter/material.dart';
import '../lang_manager.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF070708),
      appBar: AppBar(
        title: Text(LangManager.get('nav_support'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF13131A),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Text(
              LangManager.get('sup_desc'),
              style: const TextStyle(color: Colors.white60, fontSize: 14, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            TextField(
              controller: textController,
              maxLines: 6,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: LangManager.get('sup_label'),
                labelStyle: const TextStyle(color: Colors.white60),
                hintText: LangManager.get('sup_hint'),
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: const Color(0xFF13131A),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (textController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(LangManager.get('sup_error'))),
                    );
                    return;
                  }
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(LangManager.get('sup_success')), backgroundColor: Colors.green),
                  );
                  textController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.send_rounded),
                label: Text(LangManager.get('sup_btn'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
