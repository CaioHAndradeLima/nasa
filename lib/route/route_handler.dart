
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/presentation/detail/bloc/picture_bloc.dart';
import 'package:nasa_pictures/presentation/detail/widget/nasa_details_widget.dart';
import 'package:nasa_pictures/presentation/pictures/widget/nasa_pictures_widget.dart';

mixin RouteHandler {
  final picturesHandler = Handler(
    handlerFunc: (
        BuildContext? context,
        Map<String, List<String>> parameters,
        ) {
      return const NasaPicturesWidget();
    },
  );

  final detailHandler = Handler(
    handlerFunc: (
        BuildContext? context,
        Map<String, List<String>> parameters,
        ) {
      final String? idPicture = parameters['id']?[0];
      return NasaDetailWidget(idPicture: idPicture!);
    },
  );
}