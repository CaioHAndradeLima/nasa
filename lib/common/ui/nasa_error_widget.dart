
import 'package:flutter/material.dart';
import 'package:nasa_pictures/common/ui/default_horizontal_padding.dart';
import 'package:nasa_pictures/common/ui/strings_mixin.dart';

class NasaErrorWidget extends StatelessWidget with StringsMixin {
  final String? description;

  NasaErrorWidget({
    super.key,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultHorizontalPadding(
        child: Text(
          description ?? strings.error_general_message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}