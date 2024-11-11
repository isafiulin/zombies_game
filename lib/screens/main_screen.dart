import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            image: AssetImage(
              'assets/images/mai1n_back.png',
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 50.h),
            child: Column(
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
                SizedBox(
                  height: 30.h,
                ),
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
                        vertical: 4.5.h, horizontal: 5.5.w),
                    decoration: BoxDecoration(
                        color: HZOMColor.blue,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Container(
                      height: 45.h,
                      width: 172.w,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Levels',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
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
                        vertical: 4.5.h, horizontal: 5.5.w),
                    decoration: BoxDecoration(
                        color: HZOMColor.blue,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Container(
                      height: 45.h,
                      width: 172.w,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Shop',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                HZOMMot(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NastokiScreen(),
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
                      height: 45.h,
                      width: 172.w,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 24.sp,
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
            ),
          ),
        ),
      ),
    );
  }
}
