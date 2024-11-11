import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/hzom_motion.dart';
import 'package:zombies_game/screens/game_screen.dart';
import 'package:zombies_game/services/level_provider.dart';
import 'package:provider/provider.dart';

class LVLScreen extends StatefulWidget {
  const LVLScreen({super.key});

  @override
  State<LVLScreen> createState() => _LVLScreenState();
}

class _LVLScreenState extends State<LVLScreen> {
  int selLvl = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final levelProvider = Provider.of<LevelProvider>(context);
    for (var lvl in lvlBack) {
      precacheImage(AssetImage(lvl), context);
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                selLvl = value;
              });
            },
            itemCount: lvlBack.length,
            itemBuilder: (context, snapshot) {
              return Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: HZOMColor.bg,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      lvlBack[selLvl],
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 41.0.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.2.spMin,
                            crossAxisCount: 5,
                            crossAxisSpacing: 16.0.h,
                            mainAxisSpacing: 16.0.h,
                          ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            int level = index + 1;

                            return HZOMMot(
                              onPressed: () {
                                if (index >
                                    levelProvider.levl[selLvl + 1]! - 1) {
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GamiScreen(
                                      lvlType: selLvl + 1,
                                      lvl: index + 1,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0.r),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(selLvl == 1
                                        ? index >
                                                levelProvider
                                                        .levl[selLvl + 1]! -
                                                    1
                                            ? 'assets/images/redDis.png'
                                            : 'assets/images/redEn.png'
                                        : index >
                                                levelProvider
                                                        .levl[selLvl + 1]! -
                                                    1
                                            ? 'assets/images/blueDis.png'
                                            : 'assets/images/blueEn.png'),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "$level",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: index >
                                              levelProvider.levl[selLvl + 1]! -
                                                  1
                                          ? Colors.grey
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          children: [
                            HZOMMot(
                              onPressed: () {
                                if (selLvl == 0) {
                                  return;
                                }
                                _pageController.previousPage(
                                    duration: Durations.medium1,
                                    curve: Curves.ease);
                              },
                              child: Image.asset(
                                selLvl == 1
                                    ? 'assets/images/leftred.png'
                                    : 'assets/images/left.png',
                                height: 41.h,
                                width: 45.w,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              lvlName[selLvl],
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w400,
                                color: HZOMColor.white,
                              ),
                            ),
                            const Spacer(),
                            HZOMMot(
                              onPressed: () {
                                if (selLvl == 2) {
                                  return;
                                }
                                _pageController.nextPage(
                                    duration: Durations.medium1,
                                    curve: Curves.ease);
                              },
                              child: Image.asset(
                                selLvl == 1
                                    ? 'assets/images/rightred.png'
                                    : 'assets/images/right.png',
                                height: 41.h,
                                width: 45.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 250.h,
                        ),
                        HZOMMot(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GamiScreen(
                                  lvlType: selLvl + 1,
                                  lvl: levelProvider.levl[selLvl + 1] ?? 1,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.5.h, horizontal: 5.5.w),
                            decoration: BoxDecoration(
                                color: HZOMColor.blue,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Container(
                              height: 60.h,
                              width: 230.w,
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
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Play',
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
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
                              width: 27.w,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                color: HZOMColor.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Levels',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 70.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
