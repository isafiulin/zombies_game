// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:zombies_game/hzom/hzom_color.dart';
import 'package:zombies_game/hzom/hzom_motion.dart';
import 'package:zombies_game/services/coins_provider.dart';
import 'package:zombies_game/services/guns_provider.dart';
import 'package:zombies_game/services/level_provider.dart';
import 'package:provider/provider.dart';

class GamiScreen extends StatefulWidget {
  const GamiScreen({super.key, required this.lvlType, required this.lvl});

  final int lvlType;
  final int lvl;
  @override
  State<GamiScreen> createState() => _GamiScreenState();
}

class _GamiScreenState extends State<GamiScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _hideTimer;
  int timerCount = 5;
  List<Zombi> zombiList = [];
  final List<Ball> _balls = [];
  bool isStart = false;
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _showZombi();
    zombiList = generatezombiList(widget.lvlType);
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dfsdf44() async {
    _audioPlayer.play(
      AssetSource('audio/shrt.mp3'),
    );
  }

  Future<dynamic> loseDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 305.h,
          width: 360.w,
          child: AlertDialog(
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 250.h,
              width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 25.h),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/los_back.png'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: HZOMMot(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            'assets/images/backlose.png',
                            height: 52.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      HZOMMot(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GamiScreen(
                                lvlType: widget.lvlType,
                                lvl: widget.lvl,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/againlose.png',
                          height: 52.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> woneDialog(BuildContext context, CoinsProvider coinProvader,
      LevelProvider lvlProvaider) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 305.h,
          width: 360.w,
          child: AlertDialog(
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 250.h,
              width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 25.h),
              decoration: const BoxDecoration(
                color: HZOMColor.bg,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/win_back.png'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: HZOMMot(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            'assets/images/backwin.png',
                            height: 52.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Visibility(
                        visible: widget.lvl + 1 <= 10,
                        child: HZOMMot(
                          onPressed: () {
                            Navigator.of(context).pop();
                            lvlProvaider.saveLevel(
                                widget.lvlType, widget.lvl + 1);
                            coinProvader.addCoins(15);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GamiScreen(
                                  lvlType: widget.lvlType,
                                  lvl: widget.lvl + 1,
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/nextwin.png',
                            height: 52.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addBall(Offset localPosition) {
    _dfsdf44();

    double initialX = MediaQuery.of(context).size.width / 2;
    double initialY = (MediaQuery.of(context).size.height) /
        MediaQuery.of(context).size.height;

    _balls.add(Ball(initialX / MediaQuery.of(context).size.width, initialY,
        localPosition, _controller));
  }

  List<Zombi> generatezombiList(int lvlType) {
    final Random random = Random();
    final List<Zombi> zombiList = [];

    for (int i = 0; i < 4; i++) {
      zombiList.add(
        Zombi(
          globalKey: GlobalKey(),
          image: zombiKat.image,
          isZombi: zombiKat.isZombi,
          isHide: false,
          isHit: false,
          isKill: false,
        ),
      );
    }
    List<ZombiTemplate> selectedTemplates;
    switch (lvlType) {
      case 1:
        selectedTemplates = zombiTemplate1;
        break;
      case 2:
        selectedTemplates = zombiTemplate2;
        break;
      case 3:
        selectedTemplates = zombiTemplate3;
        break;
      default:
        selectedTemplates = zombiTemplate1;
        break;
    }

    for (int i = 0; i < 5; i++) {
      ZombiTemplate randomTemplate =
          selectedTemplates[random.nextInt(selectedTemplates.length)];
      zombiList.add(
        Zombi(
          globalKey: GlobalKey(),
          image: randomTemplate.image,
          isZombi: randomTemplate.isZombi,
          isHide: false,
          isHit: false,
          isKill: false,
        ),
      );
    }
    zombiList.shuffle();
    return zombiList;
  }

  void _showZombi() {
    if (mounted) {
      setState(() {
        isStart = false;
      });
    }

    _hideTimer?.cancel();
    _hideTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCount -= 1;
      if (timerCount == 1) {
        _hideTimer?.cancel();
        if (mounted) {
          setState(() {
            isStart = true;

            for (var zombi in zombiList) {
              zombi.isHide = true;
            }
          });
        }
      }
    });
  }

  List<Widget> _buildZombieStack(double screenWidth, double screenHeight) {
    List<Widget> stackChildren = [];
    double offsetX = 10.w;
    double offsetY = 10.w;
    double itemWidth = ((screenWidth - ((offsetX - 3.w) * 3)) / 3);
    double itemHeight = ((screenWidth - ((offsetX - 3.w) * 3)) / 3);

    int maxElementsInRow = 3;

    for (int i = 0; i < zombiList.length; i++) {
      double left = (i % maxElementsInRow) * (itemWidth + offsetX);
      double top = (i ~/ maxElementsInRow) * (itemHeight + offsetY);

      stackChildren.add(
        Positioned(
          left: left,
          top: top + 130.h,
          child: SizedBox(
              width: itemWidth,
              height: itemHeight,
              child: zombiList[i].isKill
                  ? null
                  : Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset(
                          key: zombiList[i].globalKey,
                          zombiList[i].image,
                          height: itemWidth - 40.h,
                          width: itemWidth - 40.h,
                        ),
                        if (zombiList[i].isHide)
                          Positioned.fill(
                            child: Image.asset(
                              !zombiList[i].isHit
                                  ? 'assets/images/korob.png'
                                  : 'assets/images/korobhit.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                      ],
                    )),
        ),
      );
    }

    return stackChildren;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final co1nProvider = Provider.of<CoinsProvider>(context);
    final gunsProvider = Provider.of<GunsProvider>(context);
    final levelProvider = Provider.of<LevelProvider>(context);
    precacheImage(AssetImage(lvlGameBack[widget.lvlType - 1]), context);

    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          if (isStart) {
            _addBall(details.localPosition);
          }
        },
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: HZOMColor.bg,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                lvlGameBack[widget.lvlType - 1],
              ),
            ),
          ),
          child: SafeArea(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                for (var ball in _balls) {
                  ball.updatePosition((removedBall) async {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      for (var zombi in zombiList) {
                        final RenderBox? renderBox =
                            zombi.globalKey.currentContext?.findRenderObject()
                                as RenderBox?;

                        if (renderBox != null) {
                          final Offset offset =
                              renderBox.localToGlobal(Offset.zero);

                          double prizraX = offset.dx / width;
                          double prizraY = offset.dy / height;

                          double ballX = ball.targetPosition.dx / width;
                          double ballY = ball.targetPosition.dy / height;

                          if ((ballX - prizraX).abs() < 0.15 &&
                              (ballY - prizraY).abs() < 0.05) {
                            if (zombi.isZombi == false) {
                              zombi.isHit = true;
                              setState(() {});
                            } else if (zombi.isHit == false) {
                              zombi.isHit = true;
                            } else if (zombi.isHit) {
                              zombi.isKill = true;
                            }
                          }
                        }
                      }

                      if (zombiList.any(
                        (element) => element.isHit && !element.isZombi,
                      )) {
                        loseDialog(context);
                      }

                      if (zombiList
                              .where(
                                (element) => element.isKill && element.isZombi,
                              )
                              .toList()
                              .length ==
                          5) {
                        woneDialog(context, co1nProvider, levelProvider);
                      }

                      setState(() {
                        _balls.remove(removedBall);
                      });
                    });
                  }, context);
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _removeOffscreenBalls();
                });
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Stack(
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
                            'Level ${widget.lvl}',
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
                      Positioned(
                        top: 70.h,
                        width: width - 32.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                          child: isStart
                              ? Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        color: Colors.white,
                                        fontFamily: 'JejuHallasan',
                                      ),
                                      children: const <TextSpan>[
                                        TextSpan(text: 'Kill the '),
                                        TextSpan(
                                          text: 'zombies',
                                          style: TextStyle(
                                            color: Color(0xFF00FF00),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: Colors.white,
                                      fontFamily: 'JejuHallasan',
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(text: 'Remember where the \n'),
                                      TextSpan(
                                        text: 'zombies',
                                        style: TextStyle(
                                          color: Color(0xFF00FF00),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: ' are and kill them.'),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 50.h,
                        child: SizedBox(
                          width: width - 32.w,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Gun',
                                      style: TextStyle(
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 19.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.5.h, horizontal: 5.5.w),
                                      decoration: BoxDecoration(
                                          color: widget.lvlType == 2
                                              ? HZOMColor.redFF0000
                                              : HZOMColor.blue,
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                      child: Container(
                                        height: 100.h,
                                        width: 117.w,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurStyle: BlurStyle.inner,
                                              offset: const Offset(-1, 2),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            BoxShadow(
                                              offset: const Offset(-2, 1),
                                              blurRadius: 0,
                                              spreadRadius: 0,
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                            ),
                                            BoxShadow(
                                              blurStyle: BlurStyle.inner,
                                              offset: const Offset(-1, 2),
                                              color: widget.lvlType == 2
                                                  ? HZOMColor.redFF0000
                                                      .withOpacity(0.9)
                                                  : HZOMColor.blue
                                                      .withOpacity(0.9),
                                            ),
                                          ],
                                          color: HZOMColor.black1A1A1A
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Image.asset(
                                          gunsProvider.gun,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 60.w,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Bullet',
                                      style: TextStyle(
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 19.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.5.h, horizontal: 5.5.w),
                                      decoration: BoxDecoration(
                                          color: widget.lvlType == 2
                                              ? HZOMColor.redFF0000
                                              : HZOMColor.blue,
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                      child: Container(
                                        height: 100.h,
                                        width: 117.w,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurStyle: BlurStyle.inner,
                                              offset: const Offset(-1, 2),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            BoxShadow(
                                              offset: const Offset(-2, 1),
                                              blurRadius: 0,
                                              spreadRadius: 0,
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                            ),
                                            BoxShadow(
                                              blurStyle: BlurStyle.inner,
                                              offset: const Offset(-1, 2),
                                              color: widget.lvlType == 2
                                                  ? HZOMColor.redFF0000
                                                      .withOpacity(0.9)
                                                  : HZOMColor.blue
                                                      .withOpacity(0.9),
                                            ),
                                          ],
                                          color: HZOMColor.black1A1A1A
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Image.asset(
                                          gunsProvider.bullet,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ..._buildZombieStack(width - 32.w, height),
                      ..._balls.map(
                        (ball) {
                          return Positioned(
                            left:
                                ball.x * MediaQuery.of(context).size.width - 25,
                            bottom: (1 - ball.y) *
                                    MediaQuery.of(context).size.height -
                                25,
                            child: SizedBox(
                              width: 46.h,
                              height: 46.h,
                              child: Image.asset(gunsProvider.bullet),
                            ),
                          );
                        },
                      ),
                      if (!isStart)
                        Positioned(
                          bottom: 150.h,
                          width: width - 32,
                          child: Center(
                            child: Text(
                              '$timerCount',
                              style: TextStyle(
                                fontSize: 90.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _removeOffscreenBalls() {
    setState(() {
      _balls.removeWhere((ball) => ball.y < 0);
    });
  }
}

class Zombi {
  final GlobalKey globalKey;
  final String image;
  final bool isZombi;
  bool isHide;
  bool isHit;
  bool isKill;
  Zombi({
    required this.globalKey,
    required this.image,
    required this.isZombi,
    required this.isHide,
    required this.isHit,
    required this.isKill,
  });
}

class ZombiTemplate {
  final String image;
  final bool isZombi;

  ZombiTemplate({
    required this.image,
    required this.isZombi,
  });
}

final List<ZombiTemplate> zombiTemplate1 = [
  ZombiTemplate(image: 'assets/images/zombie1_1.png', isZombi: true),
  ZombiTemplate(image: 'assets/images/zombie1_2.png', isZombi: true),
];
final List<ZombiTemplate> zombiTemplate2 = [
  ZombiTemplate(image: 'assets/images/zombie2_1.png', isZombi: true),
  ZombiTemplate(image: 'assets/images/zombie2_2.png', isZombi: true),
];
final List<ZombiTemplate> zombiTemplate3 = [
  ZombiTemplate(image: 'assets/images/zombie3_1.png', isZombi: true),
  ZombiTemplate(image: 'assets/images/zombie3_2.png', isZombi: true),
];

ZombiTemplate zombiKat =
    ZombiTemplate(image: 'assets/images/cat.png', isZombi: false);

class Ball {
  double x;
  double y;
  final Offset targetPosition;
  final double speed = 0.01;

  Ball(this.x, this.y, this.targetPosition, AnimationController controller);

  void updatePosition(Function(Ball) onRemove, BuildContext context) {
    double dx = targetPosition.dx / MediaQuery.of(context).size.width;
    double dy = targetPosition.dy / MediaQuery.of(context).size.height;

    double angle = atan2(dy - y, dx - x);

    x += cos(angle) * speed;
    y += sin(angle) * speed;

    if ((x - dx).abs() <= speed && (y - dy).abs() <= speed) {
      onRemove(this);
    }
  }
}
