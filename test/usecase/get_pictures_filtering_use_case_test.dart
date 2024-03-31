import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/data/local/picture_local_filter.dart';
import 'package:nasa_pictures/data/local/local_repository.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_in.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_no_results.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_success.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_use_case.dart';
import '../model/nasa_picture.dart';
import 'get_pictures_use_case_test.mocks.dart';

@GenerateMocks([
  LocalRepository,
], customMocks: [
  MockSpec<LocalRepository>(
    as: #MockLocalRepositoryRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late GetPicturesFilteringUseCase useCase;
  late MockLocalRepositoryRelaxed mockLocalRepository;

  setUp(() {
    mockLocalRepository = MockLocalRepositoryRelaxed();
    useCase = GetPicturesFilteringUseCase(localRepository: mockLocalRepository);
  });

  group('GetPicturesFilteringUseCase Tests', () {
    test('Pictures found with filter', () async {
      final List<NasaPicture> pictures = [
        NasaPictureTest(title: 'title', id: '1'),
        NasaPictureTest(title: 'another', id: '2'),
      ];

      final filter = GetPicturesFilteringIn(date: '2022', title: 'title');
      when(mockLocalRepository.findPictures(
        filter: anyNamed('filter'),
      )).thenAnswer((_) async => pictures);

      final result = await useCase(filter);

      expect(result, isA<GetPicturesFilteringSuccess>());
      expect((result as GetPicturesFilteringSuccess).pictures, pictures);
    });

    test('No pictures found with filter', () async {

      final filter = GetPicturesFilteringIn(date: '2022', title: 'title');
      when(mockLocalRepository.findPictures(
        filter: anyNamed('filter'),
      )).thenAnswer((_) async => null);

      final result = await useCase(filter);

      expect(result, isA<GetPicturesFilteringNoResults>());
    });

    test('No pictures found with empty filter', () async {
      final filter = GetPicturesFilteringIn(date: '', title: '');

      final result = await useCase(filter);

      expect(result, isA<GetPicturesFilteringNoResults>());
    });
  });
}
