import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centers the app content and constrains it to a maximum size (1024x720).
/// Outside area is painted white.
///
/// Also overrides MediaQuery.size for descendants so `MediaQuery.of(context).size`
/// reflects the clamped size.
class GameFrame extends StatelessWidget {
  const GameFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;
        final double availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height;

        final double frameWidth = availableWidth.clamp(0, 620);
        final double frameHeight = availableHeight.clamp(0, 1024);

        final media = MediaQuery.of(context);
        final mediaForChild = media.copyWith(
          size: Size(frameWidth, frameHeight),
        );

        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Center(
            child: SizedBox(
              width: frameWidth,
              height: frameHeight,
              child: MediaQuery(
                data: mediaForChild,
                child: ScreenUtilInit(
                  designSize: const Size(620, 1024),
                  ensureScreenSize: true,
                  // fontSizeResolver: FontSizeResolvers.height,
                  minTextAdapt: true,
                  splitScreenMode: true,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
