import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/repository/local/local_repository.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/repository/remote/remote_repository.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_request_fail.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_success.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_use_case.dart';
import '../model/nasa_picture.dart';
import 'get_pictures_use_case_test.mocks.dart';

@GenerateMocks([
  LocalRepository,
  RemoteRepository,
], customMocks: [
  MockSpec<LocalRepository>(
    as: #MockLocalRepositoryRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<RemoteRepository>(
    as: #MockRemoteRepositoryRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late GetPicturesUseCase useCase;
  late LocalRepository mockLocalRepository;
  late RemoteRepository mockRemoteRepository;

  setUp(() {
    mockLocalRepository = MockLocalRepositoryRelaxed();
    mockRemoteRepository = MockRemoteRepositoryRelaxed();
    useCase = GetPicturesUseCase(localRepository: mockLocalRepository, remoteRepository: mockRemoteRepository);
  });

  group('GetPicturesUseCase Tests', () {
    test('Get pictures from local repository', () async {
      final List<NasaPicture> pictures = [NasaPictureTest(explanation: 'explanation1', title: 'title1', url: 'url1', id: '1')];
      when(mockLocalRepository.findPictures()).thenAnswer((_) async => pictures);

      final result = await useCase();

      expect(result, isA<GetPicturesSuccess>());
      expect((result as GetPicturesSuccess).listPicture, pictures);
      verifyNever(mockRemoteRepository.findPictures());
    });

    test('Get pictures from remote repository', () async {
      final List<NasaPicture> pictures = [NasaPictureTest(explanation: 'explanation1', title: 'title1', url: 'url1', id: '1')];
      when(mockLocalRepository.findPictures()).thenAnswer((_) async => null);
      when(mockRemoteRepository.findPictures()).thenAnswer((_) async => pictures);

      final result = await useCase();

      expect(result, isA<GetPicturesSuccess>());
      expect((result as GetPicturesSuccess).listPicture, pictures);
      verify(mockLocalRepository.insertAll(pictures)).called(1);
    });

    test('Request fail', () async {
      when(mockLocalRepository.findPictures()).thenAnswer((_) async => null);
      when(mockRemoteRepository.findPictures()).thenThrow(Exception());

      final result = await useCase();

      expect(result, isA<GetPicturesRequestFail>());
    });
  });
}
