import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/hzom_motion.dart';
import 'package:zombies_game/screens/main_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/first_back.png'), context);

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: HZOMColor.bg,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/first_back.png',
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Mai1nScreen(),
                      ),
                      (protected) => false,
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
                            'Ok',
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
