
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/data/local/local_repository.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_not_found.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_success.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_use_case.dart';
import 'get_pictures_use_case_test.mocks.dart';

@GenerateMocks([
  LocalRepository
])
void main() {
  late GetDetailPictureUseCase useCase;
  late MockLocalRepositoryRelaxed mockLocalRepository;

  setUp(() {
    mockLocalRepository = MockLocalRepositoryRelaxed();
    useCase = GetDetailPictureUseCase(localRepository: mockLocalRepository);
  });

  group('GetDetailPictureUseCase Tests', () {
    test('Picture found', () async {
      final picture = NasaPicture(id: '1', title: 'Photo 1', url: 'url1', date: '2022', explanation: 'explanation');
      when(mockLocalRepository.findOnePicture(any)).thenAnswer((_) async => picture);

      final result = await useCase('1');

      expect(result, isA<GetDetailPictureSuccess>());
      expect((result as GetDetailPictureSuccess).picture, picture);
    });

    test('Picture not found', () async {
      when(mockLocalRepository.findOnePicture(any)).thenAnswer((_) async => null);

      final result = await useCase('1');

      expect(result, isA<GetDetailPictureNotFound>());
    });
  });
}
