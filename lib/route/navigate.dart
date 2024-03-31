import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/feature/detail/nasa_details_widget.dart';

import '../bloc/picture/picture_bloc.dart';

class Navigate {

  static toDetail(BuildContext context, {required String idPicture}) {
    GetIt.instance.resetLazySingleton(instance: GetIt.instance<PictureBloc>());

    if (Platform.isAndroid || Platform.isIOS) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => NasaDetailWidget(idPicture: idPicture)
        ),
      );
    } else {
      Navigator.of(context).pushNamed("detail/$idPicture");
    }
  }
}