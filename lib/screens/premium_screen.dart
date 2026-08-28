import 'package:flutter/material.dart';
import '../lang_manager.dart';
import 'mastercard_form.dart';

class PremiumScreen extends StatefulWidget {
  final VoidCallback onPaymentSuccess;

  const PremiumScreen({super.key, required this.onPaymentSuccess});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final _masterKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedMethod = 'mastercard'; 

  // کنترلرهای متنی مشترک برای ارتباط بین دو حصه
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _processPayment() {
    // اعتبارسنجی فرم مسترکارت قبل از ارسال
    if (_selectedMethod == 'mastercard' && !_masterKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (_selectedMethod == 'mastercard') {
        // 🔐 بررسی دقیق و زنده رمز وارد شده از حصه اول
        if (_passController.text == '1234') {
          _showResultDialog('تراکنش با موفقیت انجام شد 🎉\nنسخه VIP فعال گردید.', Colors.green, true);
        } else {
          _showResultDialog('رمز کارت اشتباه است یا موجودی کافی نیست! ❌', Colors.red, false);
        }
      } else if (_selectedMethod == 'binance') {
        // 🪙 منطق پرداخت اختصاصی بایننس (بررسی تراکنش بلاک‌چین تتر)
        _showResultDialog('تراکنش تتر با موفقیت در بلاک‌چین تایید شد! ⛓️\nاشتراک VIP فعال شد.', Colors.green, true);
      }
    });
  }

  void _showResultDialog(String message, Color color, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF13131A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Icon(isSuccess ? Icons.check_circle_rounded : Icons.error_outline_rounded, color: color, size: 70),
        content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (isSuccess) {
                Navigator.pop(context);
                widget.onPaymentSuccess();
              }
            },
            child: Text(isSuccess ? 'VIP ورود به بخش' : 'تلاش مجدد', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LangManager.direction,
      child: Scaffold(
        backgroundColor: const Color(0xFF070708),
        appBar: AppBar(
          title: Text(LangManager.get('vip_screen_title'), style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF13131A),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF1C1C24), Color(0xFF13131A)]),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.amber.withOpacity(0.2)),
                ),
                child: const Column(
                  children: [
                    Text('VIP 30-Day Premium Subscription', style: TextStyle(color: Colors.white60, fontSize: 14)),
                    SizedBox(height: 8),
                    Text('\$ 3.99', style: TextStyle(color: Colors.amber, fontSize: 36, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildMethodCard('mastercard', Icons.credit_card_rounded, 'MasterCard'),
                  const SizedBox(width: 10),
                  _buildMethodCard('binance', Icons.currency_bitcoin_rounded, 'Binance Pay'),
                ],
              ),
              const SizedBox(height: 24),
              
              if (_selectedMethod == 'mastercard') 
                MastercardForm(
                  formKey: _masterKey,
                  cardController: _cardController,
                  cvvController: _cvvController,
                  passController: _passController,
                ),
              if (_selectedMethod == 'binance') _buildBinancePayForm(),
              
              const SizedBox(height: 30),
              SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedMethod == 'binance' ? const Color(0xFFFCD535) : Colors.green.shade600,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                      : Text(
                          _selectedMethod == 'binance' ? 'Confirm Binance Deposit' : 'Pay Now',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodCard(String method, IconData icon, String text) {
    bool isSelected = _selectedMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMethod = method),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber.withOpacity(0.1) : const Color(0xFF13131A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? Colors.amber : Colors.transparent, width: 2),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.amber : Colors.white60, size: 32),
              const SizedBox(height: 8),
              Text(text, style: TextStyle(color: isSelected ? Colors.amber : Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBinancePayForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF13131A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.02)),
      ),
      child: Column(
        children: [
          const Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 140),
          const SizedBox(height: 12),
          const Text('Scan QR Code or copy Address via USDT (TRC20)', style: TextStyle(color: Colors.white70, fontSize: 13), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'TY3xP9KkWsM4mNq...Z7bVw9',
                    style: TextStyle(color: Colors.amber, fontSize: 12, fontFamily: 'monospace'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, color: Colors.white60, size: 20),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address copied to clipboard!')));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
