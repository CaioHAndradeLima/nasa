
import 'dart:ui';
import 'package:flutter/material.dart';

class CircleCloseButton extends StatelessWidget {
  final Function()? action;
  const CircleCloseButton({super.key, this.action});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        color: Colors.grey,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: 24.0,
              color: Colors.black,
            ),
            onPressed: action ?? () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}