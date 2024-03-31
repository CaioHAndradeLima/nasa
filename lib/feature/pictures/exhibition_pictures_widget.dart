import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_bloc.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_empty_state.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_no_results_state.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_state.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_success_state.dart';
import 'package:nasa_pictures/bloc/filter/pictures_filter_find_event.dart';
import 'package:nasa_pictures/common/ui/default_horizontal_padding.dart';
import 'package:nasa_pictures/common/ui/loading_widget.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/route/navigate.dart';

class ExhibitionPicturesWidget extends StatelessWidget {
  final List<NasaPicture> listPicture;

  const ExhibitionPicturesWidget({super.key, required this.listPicture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        TextField(
          onChanged: (String text) {
            GetIt.instance.get<PicturesFilterBloc>().add(
              PicturesFindByFilter(
                title: text,
                date: text,
              ),
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<PicturesFilterBloc>(
                create: (context) => GetIt.instance<PicturesFilterBloc>(),
              ),
            ],
            child: BlocBuilder<PicturesFilterBloc, PictureFilterState>(
              builder: (context, state) {
                switch(state.runtimeType) {
                  case const (PictureFilterEmptyState): return _getPicturesWidget(listPicture);
                  case const (PictureFilterNoResultsState): return const NasaErrorWidget(
                    //TODO REMOVE HARDCODE STRING
                    description: 'not found information looking for contains title or date',
                  );
                  case const (PictureFilterSuccessState): return _getPicturesWidget(
                      (state as PictureFilterSuccessState).pictures,
                  );
                }

                return _getPicturesWidget(listPicture);
              },
            ),
          ),
        ),
      ],
    );
  }

  _getPicturesWidget(List<NasaPicture> pictures) {
    return ListView.builder(
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            DefaultHorizontalPadding(
              child: Text(
                pictures[index].title,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigate.toDetail(context, idPicture: pictures[index].id);
              },
              child: Hero(
                tag: 'picture_${pictures[index].url}',
                child: CachedNetworkImage(
                  imageUrl: pictures[index].url,
                  placeholder: (context, url) => const LoadingWidget(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            DefaultHorizontalPadding(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  listPicture[index].date,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                ),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
          ],
        );
      },
    );
  }
}
