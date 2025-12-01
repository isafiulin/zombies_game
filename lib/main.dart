import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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

  print('defaultLocale: $defaultLocale');
  if (!kIsWeb) {
    AudioPlayer.global.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          contentType: AndroidContentType.sonification,
          usageType: AndroidUsageType.game,
          audioFocus:
              AndroidAudioFocus.none, 
          isSpeakerphoneOn: false,
          stayAwake: false,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.ambient,
          options: {AVAudioSessionOptions.mixWithOthers},
        ),
      ),
    );
  }

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
  // Intl.defaultLocale = 'ru_RU';

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  final delegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      basePath: 'assets/i18n', // путь из pubspec.yaml
      fallbackFile: 'en', // файл по умолчанию
      forcedLocale: Locale(systemLanguageCode), // можно задать стартап-локаль
      useCountryCode: false,
      decodeStrategies: [
        JsonDecodeStrategy(), // читаем ТОЛЬКО .json
      ],
    ),
  );

  await _setloadFirstOpenFromPrefs();
  runApp(
    ZombiesApp(
      isFirst: aaa,
      languageCode: languageCode,
      i18nDelegate: delegate,
    ),
  );
}

class ZombiesApp extends StatelessWidget {
  const ZombiesApp({
    super.key,
    required this.isFirst,
    required this.languageCode,
    required this.i18nDelegate,
  });
  final bool isFirst;
  final String languageCode;
  final FlutterI18nDelegate i18nDelegate;

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
        localizationsDelegates: [
          i18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ru'), Locale('ky')],
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
