import 'package:flutter/material.dart';
import 'package:nasa_pictures/feature/nasa_picture_widget.dart';
import 'package:nasa_pictures/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.defaultTheme(context),
      home: const NasaPictureWidget(),
    );
  }
}
