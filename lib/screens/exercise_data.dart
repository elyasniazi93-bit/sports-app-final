class ExerciseData {
  static List<Map<String, dynamic>> getExercises(String categoryTitle, int dayNumber) {
    final String title = categoryTitle.toLowerCase();

    if (title.contains('شکم') || title.contains('abs') || title.contains('بطن')) {
      return _getAbsExercises(dayNumber);
    }
    else if (title.contains('پا') || title.contains('leg') || title.contains('ساق')) {
      return _getLegsExercises(dayNumber);
    }
    else if (title.contains('پشت') || title.contains('back') || title.contains('ظهر')) {
      return _getBackExercises(dayNumber);
    }
    else if (title.contains('دست') || title.contains('arm') || title.contains('ذراع') || title.contains('بازو')) {
      return _getArmsExercises(dayNumber);
    }
    else if (title.contains('ساعد') || title.contains('forearm')) {
      return _getForearmsExercises(dayNumber); // 🚀 فراخوانی نسخه تفکیک شده ساعد
    }
    else if (title.contains('گردن') || title.contains('neck')) {
      return _getNeckExercises(dayNumber); // 🚀 فراخوانی نسخه تفکیک شده گردن
    }

    return [
      {'name': 'حرکت عمومی کششی عمومی', 'duration': 30},
      {'name': 'شنا سوئدی استاندارد', 'duration': 30},
    ];
  }

  // دیتابیس شکم
  static List<Map<String, dynamic>> _getAbsExercises(int day) {
    if (day % 3 == 1) {
      return [
        {'name': 'کرانچ شکم روی زمین (Crunches)', 'duration': 30},
        {'name': 'حرکت دوچرخه خوابیده (Bicycle Crunches)', 'duration': 30},
        {'name': 'بالا آوردن پاها به صورت عمودی (Leg Raises)', 'duration': 35},
        {'name': 'پلانک ثابت شکم (Plank)', 'duration': 40},
        {'name': 'حرکت کوهنورد سریع (Mountain Climbers)', 'duration': 30},
      ];
    } else if (day % 3 == 2) {
      return [
        {'name': 'کرانچ روسی با چرخش پهلو (Russian Twists)', 'duration': 40},
        {'name': 'حرکت قیچی پاها خوابیده (Flutter Kicks)', 'duration': 30},
        {'name': 'کرانچ معکوس برای زیر شکم (Reverse Crunches)', 'duration': 35},
        {'name': 'حرکت لمس پاشنه پا (Heel Touches)', 'duration': 40},
        {'name': 'پلانک پویا با حرکت باسن (Plank Dips)', 'duration': 30},
      ];
    } else {
      return [
        {'name': 'حرکت کستل کرانچ پیشرفته (V-Ups)', 'duration': 30},
        {'name': 'حرکت ضربدر پاها هوایی (Scissors)', 'duration': 40},
        {'name': 'حرکت PLANK قورباغه‌ای (Spider-Man Plank)', 'duration': 35},
        {'name': 'کرانچ عمودی پا صاف (Vertical Leg Crunches)', 'duration': 30},
        {'name': 'حرکت شکم خلبانی روی زمین (Dead Bug)', 'duration': 40},
      ];
    }
  }

  // دیتابیس پاها
  static List<Map<String, dynamic>> _getLegsExercises(int day) {
    if (day <= 10) {
      return [
        {'name': 'اسکوات استاندارد وزن بدن (Bodyweight Squats)', 'duration': 35},
        {'name': 'لانجز به جلو متناوب (Forward Lunges)', 'duration': 30},
        {'name': 'پلی اسکوات برای داخل پا (Sumo Squats)', 'duration': 35},
      ];
    } else if (day <= 20) {
      return [
        {'name': 'اسکوات پرشی انفجاری (Jump Squats)', 'duration': 30},
        {'name': 'لانجز به عقب تمرکزی (Reverse Lunges)', 'duration': 35},
        {'name': 'اسکوات بلغاری تک پا (Bulgarian Split Squats)', 'duration': 30},
      ];
    } else {
      return [
        {'name': 'اسکوات سومو پرشی پیشرفته (Sumo Jump Squats)', 'duration': 30},
        {'name': 'حرکت لانجز راه رفتنی (Walking Lunges)', 'duration': 40},
        {'name': 'حرکت لیفت پشت پا با دمبل (Stiff-Leg Deadlifts)', 'duration': 35},
      ];
    }
  }

  // دیتابیس عضلات پشت
  static List<Map<String, dynamic>> _getBackExercises(int day) {
    if (day % 2 == 1) {
      return [
        {'name': 'حرکت سوپرمن خوابیده برای فیله پشت (Superman Hold)', 'duration': 35},
        {'name': 'شنا سوئدی دست پهن (Wide-Grip Pushups)', 'duration': 30},
        {'name': 'حرکت زیربغل دمبل خم تک‌دست (Dumbbell Rows)', 'duration': 40},
      ];
    } else {
      return [
        {'name': 'حرکت پرنده-سگ تعادلی (Bird-Dog)', 'duration': 45},
        {'name': 'کشش زیربغل با حوله ایستاده (Towel Lat Pulldown)', 'duration': 35},
        {'name': 'حرکت پل معکوس عضلات پشتی (Reverse Tabletop)', 'duration': 30},
      ];
    }
  }

  // دیتابیس عضلات دست (جلو بازو و پشت بازو)
  static List<Map<String, dynamic>> _getArmsExercises(int day) {
    if (day % 2 == 1) {
      return [
        {'name': 'پشت بازو دیپ روی لبه صندلی (Tricep Dips)', 'duration': 35},
        {'name': 'جلو بازو دمبل تمرکزی ایستاده (Bicep Curls)', 'duration': 40},
        {'name': 'حرکت جلو بازو چکشی متناوب (Hammer Curls)', 'duration': 40},
      ];
    } else {
      return [
        {'name': 'شنا دایموند برای پشت بازو (Diamond Pushups)', 'duration': 30},
        {'name': 'شنا سوئدی روی زانو تمرکزی (Knee Pushups)', 'duration': 35},
        {'name': 'پشت بازو دمبل تک سر پشت سر (Tricep Extensions)', 'duration': 35},
      ];
    }
  }

  // 🚀 تفکیک هوشمند حرکات ساعد بر اساس روزهای زوج و فرد چالش ۳۰ روزه
  static List<Map<String, dynamic>> _getForearmsExercises(int day) {
    if (day % 3 == 1) {
      return [
        {'name': 'ساعد دمبل مچ رو به بالا (Wrist Curls)', 'duration': 40},
        {'name': 'حرکت راه رفتن کشاورز با دمبل سنگین (Farmer Carry)', 'duration': 45},
        {'name': 'حرکت باز و بسته کردن سریع پنجه دست (Finger Pulses)', 'duration': 50},
      ];
    } else if (day % 3 == 2) {
      return [
        {'name': 'ساعد دمبل مچ رو به پایین (Reverse Wrist Curls)', 'duration': 35},
        {'name': 'چرخش مچ‌ها با وزنه سبک (Wrist Rollers)', 'duration': 40},
        {'name': 'آویزان شدن ثابت از میله بارفیکس (Dead Hang)', 'duration': 30},
      ];
    } else {
      return [
        {'name': 'ساعد دمبل ایستاده لبه کادر (Standing Wrist Curls)', 'duration': 45},
        {'name': 'حرکت ساعد چکشی دمبل تمرکزی (Hammer Forearm Press)', 'duration': 35},
        {'name': 'کشش کامل عضلات مچ و ساعد (Forearm Stretch)', 'duration': 30},
      ];
    }
  }

  // 🚀 تفکیک هوشمند حرکات گردن بر اساس روزهای زوج و فرد چالش ۳۰ روزه
  static List<Map<String, dynamic>> _getNeckExercises(int day) {
    if (day % 2 == 1) {
      return [
        {'name': 'کشش گردن به طرفین با دست (Isometric Neck Lateral)', 'duration': 30},
        {'name': 'فشار کف دست به پیشانی مقاوتی (Forward Resistance)', 'duration': 35},
        {'name': 'حرکت شراگ دمبل برای عضلات کول (Dumbbell Shrugs)', 'duration': 45},
      ];
    } else {
      return [
        {'name': 'فشار دست به پشت سر مقاومتی (Backward Resistance)', 'duration': 35},
        {'name': 'چرخش آرام و ۳۶۰ درجه گردن (Neck Circles)', 'duration': 40},
        {'name': 'کشش عضلات ذوزنقه‌ای پشتی (Upper Trapezius Stretch)', 'duration': 30},
      ];
    }
  }
}
