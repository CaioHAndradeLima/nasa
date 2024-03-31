
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_pictures/bloc/picture/event/picture_event.dart';
import 'package:nasa_pictures/bloc/picture/event/picture_find_event.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_error_state.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_loading_state.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_state.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_success_state.dart';
import 'package:nasa_pictures/usecase/detail/get_detail.dart';
import 'package:nasa_pictures/usecase/detail/get_detail_picture_not_found.dart';
import 'package:nasa_pictures/usecase/detail/get_detail_picture_success.dart';
import 'package:nasa_pictures/usecase/detail/get_detail_picture_use_case.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {

  PictureBloc({required GetDetailPictureUseCase getDetailPicture}) : super(PictureLoadingState()) {

    on<PictureFindEvent>((event, emit) async {
      final GetDetailPicture answer = await getDetailPicture.call(event.idPicture);

      switch(answer.runtimeType) {
        case const (GetDetailPictureNotFound):
          emit(PictureErrorState());
        case const (GetDetailPictureSuccess):
          emit(PictureSuccessState(picture: (answer as GetDetailPictureSuccess).picture));
      }
    });
  }
}