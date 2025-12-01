import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_yandex_games/flutter_yandex_games.dart';
import 'package:zombies_game/generated/locale_keys.g.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/hzom_motion.dart';
import 'package:zombies_game/screens/lvl_screen.dart';
import 'package:zombies_game/screens/settings_screen.dart';
import 'package:zombies_game/screens/shop_screen.dart';

class Mai1nScreen extends StatefulWidget {
  const Mai1nScreen({super.key});

  @override
  State<Mai1nScreen> createState() => _Mai1nScreenState();
}

class _Mai1nScreenState extends State<Mai1nScreen> {
  String status = "Initializing...";

  bool initFinished = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initYandexGames();
    });
  }

  void initYandexGames() {
    YandexGames.init().then((value) {
      setState(() {
        status = "Yandex Games Sdk Init Successful";
        initFinished = true;
        YandexGames.loadingApi.ready();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/mai1n_back.png'), context);

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: HZOMColor.bg,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/mai1n_back.png'),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 50.h),
            child: initFinished
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      HZOMMot(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LVLScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.5.h,
                            horizontal: 5.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: HZOMColor.blue,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Container(
                            // height: 60.h,
                            width: 230.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  offset: const Offset(-2, 1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  color: HZOMColor.blue.withOpacity(0.9),
                                ),
                              ],
                              color: HZOMColor.black1A1A1A.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Text(
                                FlutterI18n.translate(context, LocaleKeys.play),
                                style: TextStyle(
                                  fontSize: 26.h,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      HZOMMot(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LVLScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.5.h,
                            horizontal: 5.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: HZOMColor.blue,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Container(
                            // height: 45.h,
                            width: 172.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  offset: const Offset(-2, 1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  color: HZOMColor.blue.withOpacity(0.9),
                                ),
                              ],
                              color: HZOMColor.black1A1A1A.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FlutterI18n.translate(context, LocaleKeys.levels),
                                  style: TextStyle(
                                    fontSize: 26.h,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      HZOMMot(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Sh0pScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.5.h,
                            horizontal: 5.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: HZOMColor.blue,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Container(
                            // height: 45.h,
                            width: 172.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  offset: const Offset(-2, 1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  color: HZOMColor.blue.withOpacity(0.9),
                                ),
                              ],
                              color: HZOMColor.black1A1A1A.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FlutterI18n.translate(context, LocaleKeys.shop),
                                  style: TextStyle(
                                    fontSize: 26.h,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      HZOMMot(
                        onPressed: ()  async {
                         await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NastokiScreen(),
                            ),
                          );
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.5.h,
                            horizontal: 5.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: HZOMColor.blue,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Container(
                            // height: 45.h,
                            width: 172.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  offset: const Offset(-2, 1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                                BoxShadow(
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(-1, 2),
                                  color: HZOMColor.blue.withOpacity(0.9),
                                ),
                              ],
                              color: HZOMColor.black1A1A1A.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  FlutterI18n.translate(context, LocaleKeys.settings),
                                  style: TextStyle(
                                    fontSize: 26.h,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: Text('Initializing...')),
          ),
        ),
      ),
    );
  }
}
