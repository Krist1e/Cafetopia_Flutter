import 'package:flutter/material.dart';

Route createRouteWithTransition(Widget widget, Tween<Offset> transition) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = transition;
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Route createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
  );
}

rtlTransition() {
  return Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
}
ltrTransition() {
  return Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero);
}