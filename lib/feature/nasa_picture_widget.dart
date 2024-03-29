import 'package:flutter/material.dart';
import 'package:nasa_pictures/common/AppBarWidget.dart';

class NasaPictureWidget extends StatelessWidget {
  const NasaPictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        Text(
          'Nasa Pictures',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Center(
        child: Text(
          'see nasa pictures right here',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
