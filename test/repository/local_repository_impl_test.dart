
import 'package:flutter_test/flutter_test.dart';
import 'package:localstore/localstore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/repository/local/local_repository_impl.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'local_repository_impl_test.mocks.dart';

@GenerateMocks([
  Localstore, CollectionRef, DocumentRef
], customMocks: [
  MockSpec<Localstore>(
    as: #MockLocalstoreRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<CollectionRef>(
    as: #MockCollectionRefRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<DocumentRef>(
    as: #MockDocumentRefRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late LocalRepositoryImpl localRepository;
  late MockLocalstoreRelaxed mockLocalstore;

  setUp(() {
    mockLocalstore = MockLocalstoreRelaxed();
    localRepository = LocalRepositoryImpl(instance: mockLocalstore);
  });

  group('LocalRepository Tests', () {
    test('findPictures - Returns list of pictures', () async {
      final collectionRef = MockCollectionRefRelaxed();
      when(mockLocalstore.collection('picture')).thenAnswer((_) => collectionRef);
      when(collectionRef.get()).thenAnswer((_) async {
        return {
          '1': {'id': '1', 'title': 'Photo 1', 'url': 'url1', 'date': '2022', 'explanation': 'explanation'},
          '2': {'id': '2', 'title': 'Photo 2', 'url': 'url2', 'date': '2022', 'explanation': 'explanation'},
        };
      });

      final result = await localRepository.findPictures();

      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[1].title, 'Photo 2');
    });

    test('findOnePicture - Returns a picture', () async {
      final collectionRef = MockCollectionRefRelaxed();
      final documentRef = MockDocumentRefRelaxed();
      when(mockLocalstore.collection('picture')).thenAnswer((_) => collectionRef);
      when(collectionRef.doc('1')).thenAnswer((_) => documentRef);
      when(documentRef.get()).thenAnswer((_) async {
        return {'id': '1', 'title': 'Photo 1', 'url': 'url1', 'date': '2022', 'explanation': 'explanation'};
      });

      final result = await localRepository.findOnePicture('1');

      expect(result!.id, '1');
      expect(result.title, 'Photo 1');
    });

    test('insertAll - Inserts pictures', () async {
      final pictures = [
        NasaPicture(id: '1', title: 'Photo 1', url: 'url1', date: '2022', explanation: 'explanation'),
        NasaPicture(id: '2', title: 'Photo 2', url: 'url2', date: '2022', explanation: 'explanation'),
      ];

      final collectionRef = MockCollectionRefRelaxed();
      final documentRef = MockDocumentRefRelaxed();
      when(mockLocalstore.collection('picture')).thenAnswer((_) => collectionRef);
      when(collectionRef.doc(any)).thenAnswer((_) => documentRef);

      await localRepository.insertAll(pictures);

      verify(documentRef.set(pictures.first.toMap())).called(1);
      verify(documentRef.set(pictures.last.toMap())).called(1);
    });
  });
}
