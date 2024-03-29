import 'package:flutter/material.dart';
import 'package:nasa_pictures/common/app_bar_widget.dart';

class NasaPicturesWidget extends StatelessWidget {
  const NasaPicturesWidget({super.key});

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
