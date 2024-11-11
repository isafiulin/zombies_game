import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/screens/first_screen.dart';
import 'package:zombies_game/screens/main_screen.dart';
import 'package:zombies_game/services/coins_provider.dart';
import 'package:zombies_game/services/guns_provider.dart';
import 'package:zombies_game/services/level_provider.dart';
import 'package:zombies_game/services/music_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> _loadFirstOpenFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('_loadFirstOpenFromPrefs') ?? false;
}

Future<bool> _setloadFirstOpenFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setBool('_loadFirstOpenFromPrefs', true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final aaa = await _loadFirstOpenFromPrefs();

  await _setloadFirstOpenFromPrefs();
  runApp(ZombiesApp(
    isFirst: aaa,
  ));
}

class ZombiesApp extends StatelessWidget {
  const ZombiesApp({super.key, required this.isFirst});
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CoinsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MusicProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => GunsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => LevelProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Zombies game',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: HZOMColor.bg,
              ),
            ),
            fontFamily: 'JejuHallasan',
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          home: isFirst ? const Mai1nScreen() : const FirstScreen(),
        ),
      ),
    );
  }
}
