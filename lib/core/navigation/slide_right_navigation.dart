import 'package:flutter/material.dart';

class SlideRightTransitions extends PageTransitionsBuilder {
  const SlideRightTransitions();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    final offset = Tween(begin: const Offset(1, 0), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(animation);
    return SlideTransition(position: offset, child: child);
  }
}