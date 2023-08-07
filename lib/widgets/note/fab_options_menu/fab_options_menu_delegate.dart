import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class FABOptionsMenuDelegate extends FlowDelegate {
  final Animation<double> animation;
  final double btnSize;

  FABOptionsMenuDelegate({required this.animation, required this.btnSize})
      : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart =
        Get.locale == const Locale('en', 'US') ? size.width - btnSize : 0.0;
    final yStart = size.height - btnSize;

    for (int i = 0; i < context.childCount; i++) {
      final bool isLastItem = i == context.childCount - 1;
      double setValue(double value) => isLastItem ? 0.0 : value;

      const double margin = 10.0;
      final double x = xStart;
      final double y =
          yStart - setValue(animation.value * (btnSize + margin) * (i + 1));

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
