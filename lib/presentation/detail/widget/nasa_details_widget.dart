import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/presentation/detail/bloc/event/picture_find_event.dart';
import 'package:nasa_pictures/presentation/detail/bloc/picture_bloc.dart';
import 'package:nasa_pictures/presentation/detail/bloc/state/picture_error_state.dart';
import 'package:nasa_pictures/presentation/detail/bloc/state/picture_loading_state.dart';
import 'package:nasa_pictures/presentation/detail/bloc/state/picture_state.dart';
import 'package:nasa_pictures/presentation/detail/bloc/state/picture_success_state.dart';
import 'package:nasa_pictures/common/ui/circle_close_button.dart';
import 'package:nasa_pictures/common/ui/default_horizontal_padding.dart';
import 'package:nasa_pictures/common/ui/loading_widget.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';

class NasaDetailWidget extends StatefulWidget {
  final String idPicture;

  const NasaDetailWidget({super.key, required this.idPicture});

  @override
  State<NasaDetailWidget> createState() => _NasaDetailWidgetState();
}

class _NasaDetailWidgetState extends State<NasaDetailWidget> {
  double _opacityLevel = 0.0;
  late double heightImage = MediaQuery.of(context).size.height * 0.7;

  @override
  void initState() {
    GetIt.instance<PictureBloc>().add(PictureFindEvent(idPicture: widget.idPicture));
    super.initState();
    _toggleOpacity();
  }

  void _toggleOpacity() {
    setState(() {
      _opacityLevel = 0.85;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<PictureBloc>(
                create: (context) => GetIt.instance<PictureBloc>(),
              ),
            ],
            child: BlocBuilder<PictureBloc, PictureState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (PictureLoadingState):
                    return const LoadingWidget();
                  case const (PictureErrorState):
                    return NasaErrorWidget();
                  case const (PictureSuccessState):
                    return _buildPictureUI(
                      (state as PictureSuccessState).picture,
                    );
                }

                return NasaErrorWidget();
              },
            ),
          ),
          AnimatedOpacity(
            opacity: _opacityLevel,
            duration: const Duration(milliseconds: 250),
            child: const SafeArea(
              child: DefaultHorizontalPadding(
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleCloseButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(NasaPicture picture) {
    return Hero(
      tag: 'picture_${picture.url}',
      child: CachedNetworkImage(
        imageUrl: picture.url,
        height: heightImage,
        fit: BoxFit.fitWidth,
        placeholder: (context, string) {
          return const Center(
            child: LoadingWidget(),
          );
        },
        errorWidget: (context, url, error) {
          return const Center(
            child: LoadingWidget(),
          );
        },
      ),
    );
  }

  Widget _buildPictureUI(NasaPicture nasaPicture) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImage(nasaPicture),
          Align(
            alignment: Alignment.topRight,
            child: DefaultHorizontalPadding(
              child: Text(
                nasaPicture.date,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          DefaultHorizontalPadding(
            child: Text(
              nasaPicture.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultHorizontalPadding(
            child: Text(
              nasaPicture.explanation,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SafeArea(
            child: SizedBox(
              height: 8,
            ),
          ),
        ],
      ),
    );
  }
}
