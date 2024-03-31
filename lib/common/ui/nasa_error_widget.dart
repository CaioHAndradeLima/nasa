
import 'package:flutter/material.dart';
import 'package:nasa_pictures/common/ui/default_horizontal_padding.dart';

class NasaErrorWidget extends StatelessWidget {
  final String description;
  //TODO REMOVE HARDCODE
  const NasaErrorWidget({super.key, this.description = 'Not found information. Please try again later'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultHorizontalPadding(
        child: Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}