import 'package:flutter/material.dart';

class FadeSlideTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double slideOffset;
  final Axis slideAxis;

  const FadeSlideTransition({
    super.key,
    required this.child,
    required this.animation,
    this.slideOffset = 30.0,
    this.slideAxis = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: slideAxis == Axis.vertical
                ? Offset(0, slideOffset * (1 - animation.value))
                : Offset(slideOffset * (1 - animation.value), 0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
