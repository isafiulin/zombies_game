import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zombies_game/generated/locale_keys.g.dart';

class LevelProvider with ChangeNotifier {
  Map<int, int> _levl = {1: 1, 2: 1, 3: 1};

  Map<int, int> get levl => _levl;

  LevelProvider() {
    _loadLevlFromPrefs();
  }

  Future<void> _loadLevlFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 1; i <= 3; i++) {
      _levl[i] = prefs.getInt('level$i') ?? 1;
    }
    notifyListeners();
  }

  Future<void> _saveLevelToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in _levl.entries) {
      await prefs.setInt('level${entry.key}', entry.value);
    }
  }

  void saveLevel(int levelType, int level) {
    if (level > 10 || level < 1) {
      return;
    }
    _levl[levelType] = level;
    _saveLevelToPrefs();
    notifyListeners();
  }

  void resetLevl() {
    _levl = {1: 1, 2: 1, 3: 1};
    _saveLevelToPrefs();
    notifyListeners();
  }
}

final List<String> lvlBack = [
  'assets/images/lvl1_back.png',
  'assets/images/lvl2_back.png',
  'assets/images/lvl3_back.png',
];
final List<String> lvlGameBack = [
  'assets/images/lvl1_back1.png',
  'assets/images/lvl2_back2.png',
  'assets/images/lvl3_back3.png',
];

final List<String> lvlName = [
  LocaleKeys.darkAlleys,
  LocaleKeys.hotResort,
  LocaleKeys.theDevilsLair,
];
