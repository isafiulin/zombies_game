import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GunsProvider with ChangeNotifier {
  String _gun = defaultGun;
  String _bullt = defaultBullt;

  List<String> _gunsList = [defaultGun];
  List<String> _bulletsList = [defaultBullt];

  String get gun => _gun;
  String get bullet => _bullt;

  List<String> get kuplGuns => _gunsList;
  List<String> get kuplBullets => _bulletsList;

  GunsProvider() {
    _loadGunFromPrefs();
    _loadGunsFromPrefs();
    _loadBulltFromPrefs();
    _loadBulletsFromPrefs();
  }

  Future<void> _loadGunFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _gun = prefs.getString('gun') ?? defaultGun;
    notifyListeners();
  }

  Future<void> _loadBulltFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _bullt = prefs.getString('bullet') ?? defaultBullt;
    notifyListeners();
  }

  Future<void> _loadGunsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _gunsList = prefs.getStringList('gunsList') ?? _gunsList;
    notifyListeners();
  }

  Future<void> _loadBulletsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _bulletsList = prefs.getStringList('bulletsList') ?? _bulletsList;
    notifyListeners();
  }

  Future<void> _saveGunToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gun', _gun);
  }

  Future<void> buyGunsToPrefs(String newGun) async {
    final prefs = await SharedPreferences.getInstance();
    _gunsList.add(newGun);
    await prefs.setStringList('gunsList', _gunsList);
  }

  Future<void> _saveBulletsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bullet', _bullt);
  }

  Future<void> buyBulletsToPrefs(String newBullets) async {
    final prefs = await SharedPreferences.getInstance();
    _bulletsList.add(newBullets);
    await prefs.setStringList('bulletsList', _bulletsList);
  }

  void addNewGun(String newGun) {
    _gun = newGun;
    _saveGunToPrefs();
    notifyListeners();
  }

  void addNewBullets(String newBull) {
    _bullt = newBull;
    _saveBulletsToPrefs();
    notifyListeners();
  }
}

String defaultGun = 'assets/icons/gun1.png';
String defaultBullt = 'assets/icons/bul1.png';

List<String> gunsList = [
  'assets/icons/gun2.png',
  'assets/icons/gun3.png',
  'assets/icons/gun4.png',
];

List<String> bulletsList = [
  'assets/icons/bul2.png',
  'assets/icons/bul3.png',
  'assets/icons/bul4.png',
];
