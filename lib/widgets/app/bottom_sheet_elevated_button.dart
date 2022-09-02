import 'dart:async';

import 'package:flutter/material.dart';

class BottomSheetElevatedButton extends StatelessWidget {
  final FutureOr<void> Function()? onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const BottomSheetElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width / 2 - 22, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
