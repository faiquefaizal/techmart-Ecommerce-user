import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggerdColomnAnimater extends StatelessWidget {
  final List<Widget> children;
  final Duration duration;
  const StaggerdColomnAnimater({
    super.key,
    this.duration = const Duration(seconds: 1),
    required this.availableHeight,
    required this.children,
  });

  final double availableHeight;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: duration,
          childAnimationBuilder:
              (widget) => SlideAnimation(
                verticalOffset: -100,
                child: FadeInAnimation(child: widget),
              ),
          children: children,
        ),
      ),
    );
  }
}
