import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsProvider with ChangeNotifier {
  int _coins = 100;

  int get coins => _coins;

  CoinsProvider() {
    _loadCoinsFromPrefs();
  }

  Future<void> _loadCoinsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _coins = prefs.getInt('coins') ?? 0;
    notifyListeners();
  }

  Future<void> _saveCoinsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('coins', _coins);
  }

  void addCoins(int amount) {
    _coins += amount;
    _saveCoinsToPrefs(); // Save to SharedPreferences
    notifyListeners();
  }

  void subtractCoins(int amount) {
    _coins -= amount;
    _saveCoinsToPrefs(); // Save to SharedPreferences
    notifyListeners();
  }

  void resetCoins() {
    _coins = 1000;
    _saveCoinsToPrefs(); // Save to SharedPreferences
    notifyListeners();
  }
}
