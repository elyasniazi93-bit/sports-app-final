import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exercise_data.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final int dayNumber;
  final String categoryTitle;

  const WorkoutTimerScreen({super.key, required this.dayNumber, required this.categoryTitle});

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> with SingleTickerProviderStateMixin {
  late List<Map<String, dynamic>> _exercises;
  int _currentExerciseIndex = 0;
  Timer? _timer;
  int _remainingSeconds = 30;
  bool _isRunning = false;
  bool _isResting = false;
  final int _restDuration = 15;
  
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _exercises = ExerciseData.getExercises(widget.categoryTitle, widget.dayNumber);
    _remainingSeconds = _exercises[_currentExerciseIndex]['duration'];
    
    // کنترلر انیمیشن متحرک نئونی برای زمان استراحت و تمرین
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
        if (_remainingSeconds <= 3 && _remainingSeconds > 0) {
          SystemSound.play(SystemSoundType.click);
        }
      } else {
        _handleTimerFinished();
      }
    });
  }

  void _handleTimerFinished() {
    _timer?.cancel();
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.vibrate();

    if (!_isResting) {
      if (_currentExerciseIndex < _exercises.length - 1) {
        setState(() {
          _isResting = true;
          _remainingSeconds = _restDuration;
          _isRunning = false;
        });
        _startTimer();
      } else {
        setState(() => _isRunning = false);
        _showFinishedDialog();
      }
    } else {
      setState(() {
        _isResting = false;
        _currentExerciseIndex++;
        _remainingSeconds = _exercises[_currentExerciseIndex]['duration'];
        _isRunning = false;
      });
      _startTimer();
    }
  }

  void _pauseTimer() => setState(() { _timer?.cancel(); _isRunning = false; });

  void _skipAction() {
    _timer?.cancel();
    if (_isResting) {
      setState(() {
        _isResting = false;
        _currentExerciseIndex++;
        _remainingSeconds = _exercises[_currentExerciseIndex]['duration'];
        _isRunning = false;
      });
    } else {
      if (_currentExerciseIndex < _exercises.length - 1) {
        setState(() { _isResting = true; _remainingSeconds = _restDuration; _isRunning = false; });
      } else {
        _showFinishedDialog();
        return;
      }
    }
    _startTimer();
  }

  void _showFinishedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF13131A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('روز ${widget.dayNumber} به پایان رسید! 🎉', textAlign: TextAlign.center),
        actions: [
          TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('بازگشت', style: TextStyle(color: Colors.amber)))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentEx = _exercises[_currentExerciseIndex];
    final Color timerColor = _isResting ? Colors.green.shade400 : Colors.amber;

    return Scaffold(
      backgroundColor: const Color(0xFF070708),
      appBar: AppBar(title: Text('روز ${widget.dayNumber}'), backgroundColor: const Color(0xFF13131A), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(_isResting ? 'وقت استراحت 🛋️' : 'حرکت ${_currentExerciseIndex + 1} از ${_exercises.length}', style: TextStyle(color: timerColor, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(_isResting ? 'آماده‌سازی برای حرکت بعدی' : currentEx['name'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 40),

            // کادر انیمیشن موجی ضربانی نئونی زنده (جایگزین اختصاصی لوتی)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // امواج رقصان پشت دایره تایمر در زمان استراحت
                    if (_isResting && _isRunning)
                      ...List.generate(3, (index) {
                        final double waveRadius = 100 + (index * 30 * _animationController.value);
                        final double waveOpacity = (1.0 - _animationController.value).clamp(0.0, 1.0);
                        return Container(
                          width: waveRadius,
                          height: waveRadius,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green.withOpacity(waveOpacity * 0.4), width: 2),
                          ),
                        );
                      }),
                    // دایره اصلی تایمر
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF13131A),
                        boxShadow: [BoxShadow(color: timerColor.withOpacity(0.2 * _animationController.value), blurRadius: 20)],
                      ),
                      child: Center(
                        child: Text('$_remainingSeconds', style: const TextStyle(color: Colors.white, fontSize: 54, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 60),
            Row(
              children: [
                Expanded(child: SizedBox(height: 55, child: ElevatedButton(onPressed: _isRunning ? _pauseTimer : _startTimer, style: ElevatedButton.styleFrom(backgroundColor: _isRunning ? Colors.red.shade600 : Colors.green.shade600), child: Text(_isRunning ? 'توقف' : 'شروع')))),
                const SizedBox(width: 12),
                Expanded(child: SizedBox(height: 55, child: OutlinedButton(onPressed: _skipAction, child: const Text('بعدی (Skip)', style: TextStyle(color: Colors.white))))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
