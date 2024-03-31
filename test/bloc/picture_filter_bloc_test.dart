
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/bloc/filter/event/pictures_filter_find_event.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_bloc.dart';
import 'package:nasa_pictures/bloc/filter/state/picture_filter_empty_state.dart';
import 'package:nasa_pictures/bloc/filter/state/picture_filter_no_results_state.dart';
import 'package:nasa_pictures/bloc/filter/state/picture_filter_success_state.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_no_results.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_success.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_use_case.dart';
import '../model/nasa_picture.dart';
import 'picture_filter_bloc_test.mocks.dart';

@GenerateMocks([
  GetPicturesFilteringUseCase
], customMocks: [
  MockSpec<GetPicturesFilteringUseCase>(
    as: #MockGetPicturesFilteringUseCaseRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])

void main() {
  late PicturesFilterBloc bloc;
  late MockGetPicturesFilteringUseCaseRelaxed mockGetPicturesFilteringUseCase;

  setUp(() {
    mockGetPicturesFilteringUseCase = MockGetPicturesFilteringUseCaseRelaxed();
    bloc = PicturesFilterBloc(getPicturesFilteringUseCase: mockGetPicturesFilteringUseCase);
  });

  group('PicturesFilterBloc Tests', () {
    test('Emits empty state', () {
      expect(bloc.state, isA<PictureFilterEmptyState>());
    });

    test('Emits no results state', () async* {
      final event = PicturesFindByFilter(title: 'test', date: '2022');
      when(mockGetPicturesFilteringUseCase.call(any)).thenAnswer((_) async => GetPicturesFilteringNoResults());

      bloc.add(event);

      await expectLater(
        bloc,
        emitsInOrder([PictureFilterNoResultsState()]),
      );
    });

    test('Emits success state', () async* {
      final event = PicturesFindByFilter(title: 'test', date: '2022');
      final pictures = [NasaPictureTest()];
      when(mockGetPicturesFilteringUseCase.call(any)).thenAnswer((_) async => GetPicturesFilteringSuccess(pictures: pictures));

      bloc.add(event);

      await expectLater(
        bloc,
        emitsInOrder([PictureFilterSuccessState(pictures: pictures)]),
      );
    });
  });
}
