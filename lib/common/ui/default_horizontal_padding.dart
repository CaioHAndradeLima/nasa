
import 'package:flutter/material.dart';

class DefaultHorizontalPadding extends Padding {
  const DefaultHorizontalPadding({required Widget super.child, super.key})
      : super(
    padding: const EdgeInsets.symmetric(horizontal: 16),
  );
}
