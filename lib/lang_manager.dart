import 'package:flutter/material.dart';

class LangManager {
  static String currentLang = 'fa'; 

  static TextDirection get direction {
    return currentLang == 'en' ? TextDirection.ltr : TextDirection.rtl;
  }

  static const Map<String, Map<String, String>> words = {
    'fa': {
      'app_title': 'پوشه‌های تمرینی',
      'vip_banner': 'خرید نسخه VIP ✨',
      'vip_screen_title': 'درگاه پرداخت (VIP)',
      'ex_abs': 'تمرین تخصصی شکم',
      'ex_legs': 'تمرین تخصصی پاها',
      'ex_arms': 'تمرین جلو بازو و پشت بازو',
      'ex_back': 'تمرین تخصصی عضلات پشت',
      'ex_forearms': 'تمرین حجم‌دهی ساعد',
      'ex_neck': 'تمرین تقویت عضلات گردن',
      'day_prefix': 'روز',
      'day_suffix': 'تمرین ۷ حرکت متنوع',
      'nav_workout': 'تمرین',
      'nav_diet': 'تغذیه',
      'nav_support': 'گزارشات',
      'nav_profile': 'پروفایل',
      'diet_title': 'رژیم و تغذیه فیتنس',
      'diet_allowed': 'برنامه وعده‌های غذایی 🍽️',
      'diet_forbidden': 'ممنوعیت‌های غذایی ❌',
      // وعده‌های جدید
      'diet_breakfast_title': 'صبحانه (Breakfast) 🍳',
      'diet_breakfast_desc': '۳ عدد تخم‌مرغ آب‌پز + جو دوسر با شیر کم‌چرب و موز',
      'diet_lunch_title': 'چاشت/ناهار (Lunch) 🍗',
      'diet_lunch_desc': 'سینه مرغ کباب شده یا ماهی + برنج قهوه‌ای و سالاد فصل',
      'diet_dinner_title': 'شام (Dinner) 🥗',
      'diet_dinner_desc': 'گوشت بوقلمون یا فیله گوساله + سیب‌زمینی آب‌پز و کلم بروکلی',
      'diet_sugar': 'قندهای مصنوعی، شیرینی‌جات و نوشابه‌ها',
      'diet_fast': 'فست‌فودها و غذاهای سرخ‌شده در چربی شدید',
      'diet_trans': 'چربی‌های اشباع شده و تنقلات کارخانه‌ای',
    },
    'en': {
      'app_title': 'Workout Categories',
      'vip_banner': 'Upgrade to VIP Version ✨',
      'vip_screen_title': 'Payment Portal (VIP)',
      'ex_abs': 'Abs Workout',
      'ex_legs': 'Legs Workout',
      'ex_arms': 'Biceps & Triceps',
      'ex_back': 'Back Workout',
      'ex_forearms': 'Forearms Volume',
      'ex_neck': 'Neck Strengthening',
      'day_prefix': 'Day',
      'day_suffix': '7 Diverse Exercises',
      'nav_workout': 'Workout',
      'nav_diet': 'Diet',
      'nav_support': 'Support',
      'nav_profile': 'Profile',
      'diet_title': 'Fitness Diet & Nutrition',
      'diet_allowed': 'Meal Plan 🍽️',
      'diet_forbidden': 'Forbidden Foods ❌',
      // New Meals
      'diet_breakfast_title': 'Breakfast Plan 🍳',
      'diet_breakfast_desc': '3 Boiled Eggs + Oatmeal with low-fat milk and a banana',
      'diet_lunch_title': 'Lunch Plan 🍗',
      'diet_lunch_desc': 'Grilled Chicken Breast or Fish + Brown Rice and fresh salad',
      'diet_dinner_title': 'Dinner Plan 🥗',
      'diet_dinner_desc': 'Turkey Breast or Beef Fillet + Boiled Potatoes and Broccoli',
      'diet_sugar': 'Artificial Sugars, Sweets, and Sodas',
      'diet_fast': 'Fast Foods and Deep-Fried Oily Dishes',
      'diet_trans': 'Saturated Fats and Factory Snacks',
    },
    'ar': {
      'app_title': 'مجلدات التمرين',
      'vip_banner': 'شراء نسخة VIP ✨',
      'vip_screen_title': 'بوابة الدفع (VIP)',
      'ex_abs': 'تمرين البطن المتخصص',
      'ex_legs': 'تمرين الساقين المتخصص',
      'ex_arms': 'تمرين البايسبس والترايسبس',
      'ex_back': 'تمرين الظهر المتخصص',
      'ex_forearms': 'تمرين الساعد المتخصص',
      'ex_neck': 'تمرين تقوية عضلات الرقبة',
      'day_prefix': 'يوم',
      'day_suffix': 'تمرين من ۷ حركات متنوعة',
      'nav_workout': 'التمرين',
      'nav_diet': 'التغذية',
      'nav_support': 'التقارير',
      'nav_profile': 'الملف الشخصي',
      'diet_title': 'النظام الغذائي والتغذية',
      'diet_allowed': 'خطة الوجبات الغذائية 🍽️',
      'diet_forbidden': 'الأطعمة الممنوعة ❌',
      // New Meals
      'diet_breakfast_title': 'وجبة الإفطار 🍳',
      'diet_breakfast_desc': '۳ بيضات مسلوقة + دقيق الشوفان مع حليب قليل الدسم وموز',
      'diet_lunch_title': 'وجبة الغداء 🍗',
      'diet_lunch_desc': 'صدر دجاج مشوي أو سمك + أرز بني وسلطة طازجة',
      'diet_dinner_title': 'وجبة العشاء 🥗',
      'diet_dinner_desc': 'صدر ديك رومي أو فيليه لحم بقر + بطاطس مسلوقة وبروكلي',
      'diet_sugar': 'السكريات الاصطناعية، الحلويات، والمشروبات الغازية',
      'diet_fast': 'الوجبات السريعة والأطباق المقلية بالزيت الكثيف',
      'diet_trans': 'الدهون المشبعة والوجبات الخفيفة المصنعة',
    }
  };

  static String get(String key) {
    return words[currentLang]?[key] ?? key;
  }
}
