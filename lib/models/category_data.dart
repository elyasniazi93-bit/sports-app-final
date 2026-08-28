import 'package:flutter/material.dart';
import '../lang_manager.dart';

class CategoryData {
  static List<Map<String, dynamic>> getCategories() {
    return [
      {'title': LangManager.get('ex_abs'), 'isVIP': false, 'icon': Icons.fitness_center_rounded},
      {'title': LangManager.get('ex_legs'), 'isVIP': false, 'icon': Icons.directions_run_rounded},
      {'title': LangManager.get('ex_back'), 'isVIP': true, 'icon': Icons.accessibility_new_rounded},
      {'title': LangManager.get('ex_arms'), 'isVIP': true, 'icon': Icons.bolt_rounded},
      {'title': LangManager.get('ex_forearms'), 'isVIP': true, 'icon': Icons.gavel_rounded},
      {'title': LangManager.get('ex_neck'), 'isVIP': true, 'icon': Icons.airline_seat_legroom_extra_rounded}, // نام آیکون استاندارد گردن اصلاح شد
    ];
  }
}
