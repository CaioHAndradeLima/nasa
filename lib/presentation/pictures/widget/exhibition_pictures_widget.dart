import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/common/ui/strings_mixin.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/picture_filter_bloc.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_empty_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_no_results_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_success_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/event/pictures_filter_find_event.dart';
import 'package:nasa_pictures/common/ui/default_horizontal_padding.dart';
import 'package:nasa_pictures/common/ui/loading_widget.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/route/navigate.dart';

class ExhibitionPicturesWidget extends StatelessWidget with StringsMixin {
  final List<NasaPicture> listPicture;

  ExhibitionPicturesWidget({super.key, required this.listPicture});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        TextField(
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: (String text) {
            GetIt.instance.get<PicturesFilterBloc>().add(
                  PicturesFindByFilter(
                    title: text,
                    date: text,
                  ),
                );
          },
          decoration: InputDecoration(
            hintText: strings.text_field_hint_message,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<PicturesFilterBloc>(
                create: (context) => GetIt.instance<PicturesFilterBloc>(),
              ),
            ],
            child: BlocBuilder<PicturesFilterBloc, PictureFilterState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (PictureFilterEmptyState):
                    return _getPicturesWidget(listPicture);
                  case const (PictureFilterNoResultsState):
                    return NasaErrorWidget(
                      description: strings.error_filter_message,
                    );
                  case const (PictureFilterSuccessState):
                    return _getPicturesWidget(
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
        return Material(
          color: Theme.of(context).colorScheme.background,
          child: InkWell(
            onTap: () {
              Navigate.toDetail(context, idPicture: pictures[index].id);
            },
            child: Column(
              children: [
                const SizedBox(height: 4,),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Hero(
                      tag: 'picture_${pictures[index].url}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          imageUrl: pictures[index].url,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => const LoadingWidget(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          DefaultHorizontalPadding(
                            child: Text(
                              pictures[index].title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          DefaultHorizontalPadding(
                            child: Text(
                              listPicture[index].date,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4,),
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Theme.of(context).dividerColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
