
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/bloc/pictures/event/pictures_find_all_event.dart';
import 'package:nasa_pictures/bloc/pictures/state/pictures_error_state.dart';
import 'package:nasa_pictures/bloc/pictures/state/pictures_loading_state.dart';
import 'package:nasa_pictures/bloc/pictures/state/pictures_success_state.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_request_fail.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_success.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_use_case.dart';
import 'package:nasa_pictures/bloc/pictures/pictures_bloc.dart';
import '../model/nasa_picture.dart';
import 'picture_bloc_test.mocks.dart';

@GenerateMocks([
  GetPicturesUseCase
], customMocks: [
  MockSpec<GetPicturesUseCase>(
    as: #MockGetPicturesUseCaseRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late PicturesBloc bloc;
  late GetPicturesUseCase mockGetPicturesUseCase;

  setUp(() {
    mockGetPicturesUseCase = MockGetPicturesUseCaseRelaxed();
    bloc = PicturesBloc(getPicturesUseCase: mockGetPicturesUseCase);
  });

  group('PicturesBloc Tests', () {
    test('Emits loading state and then success state', () async* {
      final pictures = [NasaPictureTest()];
      when(mockGetPicturesUseCase.call()).thenAnswer((_) async => GetPicturesSuccess(listPicture: pictures));

      bloc.add(PicturesFindAllEvent());

      await expectLater(
        bloc.state,
        emitsInOrder([PicturesLoadingState(), PicturesSuccessState(listPicture: pictures)]),
      );
    });

    test('Emits loading state and then error state', () async* {
      when(mockGetPicturesUseCase.call()).thenAnswer((_) async => GetPicturesRequestFail());

      bloc.add(PicturesFindAllEvent());

      await expectLater(
        bloc,
        emitsInOrder([PicturesLoadingState(), PicturesErrorState()]),
      );
    });
  });
}
