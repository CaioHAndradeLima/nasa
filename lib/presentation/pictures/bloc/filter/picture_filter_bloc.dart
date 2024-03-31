
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_empty_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/event/picture_filter_event.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_no_results_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_success_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/event/pictures_filter_find_event.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_in.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_no_results.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_success.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_use_case.dart';

class PicturesFilterBloc extends Bloc<PictureFilterEvent, PictureFilterState> {
  PicturesFilterBloc({
    required GetPicturesFilteringUseCase getPicturesFilteringUseCase
  }) : super(PictureFilterEmptyState()) {
    on<PicturesFindByFilter>((event, emit) async {
      final GetPicturesFiltering answer = await getPicturesFilteringUseCase.call(
          GetPicturesFilteringIn(
            title: event.title,
            date: event.date,
          )
      );

      switch(answer.runtimeType) {
        case const (GetPicturesFilteringNoResults):
          emit(PictureFilterNoResultsState());
        case const (GetPicturesFilteringSuccess):
          emit(PictureFilterSuccessState(pictures: (answer as GetPicturesFilteringSuccess).pictures));
      }
    });
  }
}