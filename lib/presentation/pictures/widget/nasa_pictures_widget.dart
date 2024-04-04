
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/common/ui/strings_mixin.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/event/pictures_find_all_event.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/pictures_bloc.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_error_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_loading_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_success_state.dart';
import 'package:nasa_pictures/common/app_bar_widget.dart';
import 'package:nasa_pictures/common/ui/loading_widget.dart';
import 'package:nasa_pictures/presentation/pictures/widget/exhibition_pictures_widget.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';

class NasaPicturesWidget extends StatefulWidget {
  const NasaPicturesWidget({super.key});

  @override
  State<NasaPicturesWidget> createState() => _NasaPicturesWidgetState();
}

class _NasaPicturesWidgetState extends State<NasaPicturesWidget> with StringsMixin {

  @override
  void initState() {
    super.initState();
    GetIt.instance<PicturesBloc>().add(PicturesFindAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        Text(
          strings.name_app,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PicturesBloc>(
            create: (context) => GetIt.instance<PicturesBloc>(),
          ),
        ],
        child: BlocBuilder<PicturesBloc, PicturesState>(
          builder: (context, state) {

            switch(state.runtimeType) {
              case const (PicturesLoadingState): return const LoadingWidget();
              case const (PicturesErrorState): return NasaErrorWidget();
              case const (PicturesSuccessState): return ExhibitionPicturesWidget(
                  listPicture: (state as PicturesSuccessState).listPicture,
              );
            }

            return NasaErrorWidget();
          },
        ),
      ),
    );
  }
}
