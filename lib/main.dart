import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zombies_game/hzom/global_general_constants.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/game_frame.dart';
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

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final aaa = await _loadFirstOpenFromPrefs();

  final prefs = await SharedPreferences.getInstance();

  final String defaultLocale = PlatformDispatcher.instance.locale.languageCode;
  String systemLanguageCode = '';

  if (defaultLocale.contains(GlobalGeneralConsts.ru)) {
    systemLanguageCode = GlobalGeneralConsts.ru;
  } else if (defaultLocale.contains(GlobalGeneralConsts.en)) {
    systemLanguageCode = GlobalGeneralConsts.en;
  } else {
    systemLanguageCode = GlobalGeneralConsts.ru;
  }

  final String languageCode =
      prefs.getString(GlobalPrefsConst.lang) ?? systemLanguageCode;

  prefs.setString(GlobalPrefsConst.lang, languageCode);
  Intl.defaultLocale = 'ru_RU';

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  await EasyLocalization.ensureInitialized();

  await _setloadFirstOpenFromPrefs();
  runApp(
    EasyLocalization(
      ignorePluralRules: false,
      supportedLocales: const [Locale('ru'), Locale('en')],
      path: 'assets/translations',
      startLocale: Locale(languageCode),
      fallbackLocale: const Locale('ru'),
      child: ZombiesApp(isFirst: aaa, languageCode: languageCode),
    ),
  );
}

class ZombiesApp extends StatelessWidget {
  const ZombiesApp({
    super.key,
    required this.isFirst,
    required this.languageCode,
  });
  final bool isFirst;
  final String languageCode;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinsProvider()),
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => GunsProvider()),
        ChangeNotifierProvider(create: (_) => LevelProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          // Wrap every page in a centered, constrained frame with white background
          return GameFrame(child: child ?? const SizedBox());
        },
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: 'ZombiesOrCats',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: HZOMColor.bg),
          ),
          fontFamily: 'Montserrat',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: isFirst ? const Mai1nScreen() : const FirstScreen(),
      ),
    );
  }
}
