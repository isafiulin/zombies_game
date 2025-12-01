import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zombies_game/generated/locale_keys.g.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/hzom_motion.dart';
import 'package:zombies_game/services/coins_provider.dart';
import 'package:zombies_game/services/guns_provider.dart';
import 'package:provider/provider.dart';

class Sh0pScreen extends StatefulWidget {
  const Sh0pScreen({super.key});

  @override
  State<Sh0pScreen> createState() => _Sh0pScreenState();
}

class _Sh0pScreenState extends State<Sh0pScreen> {
  Future<void> kupGun(
    String image,
    int price,
    CoinsProvider co1nProvider,
    GunsProvider gunsProvider,
  ) async {
    if (gunsProvider.kuplGuns.contains(image)) {
      gunsProvider.addNewGun(image);
      return;
    }
    if (co1nProvider.coins < price) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            FlutterI18n.translate(context, LocaleKeys.notEnoughCoinsTitle),
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: Text(
            FlutterI18n.translate(context, LocaleKeys.notEnoughCoinsContent),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      );
      return;
    }
    co1nProvider.subtractCoins(price);

    await gunsProvider.buyGunsToPrefs(image);
  }

  Future<void> kupBull(
    String image,
    int price,
    CoinsProvider co1nProvider,
    GunsProvider gunsProvider,
  ) async {
    if (gunsProvider.kuplBullets.contains(image)) {
      gunsProvider.addNewBullets(image);
      return;
    }
    if (co1nProvider.coins < price) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            FlutterI18n.translate(context, LocaleKeys.notEnoughCoinsTitle),
          ),
          content: Text(
            FlutterI18n.translate(context, LocaleKeys.notEnoughCoinsContent),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    co1nProvider.subtractCoins(price);

    await gunsProvider.buyBulletsToPrefs(image);
  }

  @override
  Widget build(BuildContext context) {
    final co1nProvider = Provider.of<CoinsProvider>(context);
    final gunsProvider = Provider.of<GunsProvider>(context);
    precacheImage(const AssetImage('assets/images/shp_back.png'), context);

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: HZOMColor.bg,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/shp_back.png'),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      HZOMMot(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/back.png',
                              fit: BoxFit.contain,
                              height: 29.h,
                              width: 47.h,
                            ),
                            Text(
                              FlutterI18n.translate(context, LocaleKeys.back),
                              style: TextStyle(
                                fontSize: 20.h,
                                fontWeight: FontWeight.w400,
                                color: HZOMColor.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        FlutterI18n.translate(context, LocaleKeys.shop),
                        style: TextStyle(
                          fontSize: 26.h,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 20.h),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/coin.png',
                            height: 34.h,
                            width: 34.h,
                          ),
                          Text(
                            '${co1nProvider.coins}',
                            style: TextStyle(
                              fontSize: 26.h,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
                  SizedBox(
                    height: 288.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/guns.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 18.h,
                          left: 0,
                          right: 0,
                          child: Text(
                            FlutterI18n.translate(context, LocaleKeys.guns),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 18.h,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width - 32.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupGun(
                                        defaultGun,
                                        0,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplGuns.contains(
                                                defaultGun,
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplGuns.contains(
                                                defaultGun,
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupGun(
                                        gunsList[0],
                                        20,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplGuns.contains(
                                                gunsList[0],
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplGuns.contains(
                                                gunsList[0],
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupGun(
                                        gunsList[1],
                                        50,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplGuns.contains(
                                                gunsList[1],
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplGuns.contains(
                                                gunsList[1],
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupGun(
                                        gunsList[2],
                                        80,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplGuns.contains(
                                                gunsList[2],
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplGuns.contains(
                                                gunsList[2],
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 288.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/bull.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 18.h,
                          left: 0,
                          right: 0,
                          child: Text(
                            FlutterI18n.translate(context, LocaleKeys.bullets),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 18.h,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width - 32.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupBull(
                                        defaultBullt,
                                        0,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplBullets.contains(
                                                defaultBullt,
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/buy.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplBullets.contains(
                                                defaultBullt,
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupBull(
                                        bulletsList[0],
                                        20,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplBullets.contains(
                                                bulletsList[0],
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplBullets.contains(
                                                bulletsList[0],
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupBull(
                                        bulletsList[1],
                                        50,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplBullets.contains(
                                                bulletsList[1],
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplBullets.contains(
                                                bulletsList[1],
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HZOMMot(
                                    onPressed: () async {
                                      await kupBull(
                                        bulletsList[2],
                                        80,
                                        co1nProvider,
                                        gunsProvider,
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          gunsProvider.kuplBullets.contains(
                                                bulletsList[2],
                                              )
                                              ? 'assets/images/set.png'
                                              : 'assets/images/set.png',
                                          fit: BoxFit.fill,
                                          height: 47.h,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          gunsProvider.kuplBullets.contains(
                                                bulletsList[2],
                                              )
                                              ? FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.set,
                                                )
                                              : FlutterI18n.translate(
                                                  context,
                                                  LocaleKeys.buy,
                                                ),
                                          style: TextStyle(
                                            fontSize: 16.5.h,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
