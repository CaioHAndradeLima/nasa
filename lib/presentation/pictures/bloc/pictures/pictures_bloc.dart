
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/event/pictures_event.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/event/pictures_find_all_event.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_error_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_loading_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_success_state.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures_request_fail.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures_success.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures_use_case.dart';

class PicturesBloc extends Bloc<PicturesEvent, PicturesState> {
  PicturesBloc({
    required GetPicturesUseCase getPicturesUseCase,
  }) : super(PicturesLoadingState()) {
    on<PicturesFindAllEvent>((event, emit) async {
      emit(PicturesLoadingState());

      final GetPictures answer = await getPicturesUseCase.call();

      switch(answer.runtimeType) {
        case const (GetPicturesRequestFail):
          emit(PicturesErrorState());
        case const (GetPicturesSuccess):
          emit(PicturesSuccessState(listPicture: (answer as GetPicturesSuccess).listPicture));
      }
    });
  }
}