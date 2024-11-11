import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/hzom_motion.dart';
import 'package:zombies_game/services/music_provider.dart';
import 'package:provider/provider.dart';

class NastokiScreen extends StatefulWidget {
  const NastokiScreen({super.key});

  @override
  State<NastokiScreen> createState() => _NastokiScreenState();
}

class _NastokiScreenState extends State<NastokiScreen> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);
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
            padding: EdgeInsets.symmetric(
              horizontal: 16.0.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                      'Settings',
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
                const Spacer(),
                SizedBox(
                  height: 30.h,
                ),
                HZOMMot(
                  onPressed: () {
                    musicProvider.togs();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.5.h, horizontal: 5.5.w),
                    decoration: BoxDecoration(
                        color: HZOMColor.blue,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Container(
                      height: 45.h,
                      width: 275.w,
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
                            musicProvider.isMusa ? 'Music off' : 'Music on',
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
                  height: 50.h,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
