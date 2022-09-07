import 'dart:math';

import 'package:flutter/material.dart';

class FABOptionsMenuDelegate extends FlowDelegate {
  final Animation<double> animation;
  final double btnSize;

  FABOptionsMenuDelegate({required this.animation, required this.btnSize})
      : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - btnSize;
    final yStart = size.height - btnSize;

    final int n = context.childCount;

    for (int i = 0; i < n; i++) {
      final isLastItem = i == n - 1;
      double setValue(value) => isLastItem ? 0.0 : value;

      final double radius = 90.0 * animation.value;
      final double theta = i * pi * 0.5 / (n - 2);

      final double x = xStart - setValue(radius * cos(theta));
      final double y = yStart - setValue(radius * sin(theta));

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0.0)
            ..translate(btnSize / 2, btnSize / 2)
            ..rotateZ(isLastItem
                ? 270 * animation.value * pi / 180
                : 360 * animation.value * pi / 180)
            ..scale(isLastItem ? 1.0 : max(animation.value, 0.5))
            ..translate(-btnSize / 2, -btnSize / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FABOptionsMenuDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
