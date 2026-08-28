import 'package:flutter/material.dart';

class MastercardForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardController;
  final TextEditingController cvvController;
  final TextEditingController passController;

  const MastercardForm({
    super.key,
    required this.formKey,
    required this.cardController,
    required this.cvvController,
    required this.passController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: cardController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white, letterSpacing: 2),
            decoration: InputDecoration(
              labelText: 'Card Number',
              hintText: '5412.xxxx.xxxx.xxxx',
              hintStyle: const TextStyle(color: Colors.white24),
              filled: true,
              fillColor: const Color(0xFF13131A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              prefixIcon: const Icon(Icons.credit_card_rounded, color: Colors.amber),
            ),
            validator: (val) => val!.length < 16 ? 'Invalid Card Number (16 digits)' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, letterSpacing: 1.5),
                  decoration: InputDecoration(
                    labelText: 'CVV2', 
                    filled: true, 
                    fillColor: const Color(0xFF13131A), 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: passController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, letterSpacing: 2),
                  decoration: InputDecoration(
                    labelText: 'Secure Code (Test: 1234)', 
                    filled: true, 
                    fillColor: const Color(0xFF13131A), 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
