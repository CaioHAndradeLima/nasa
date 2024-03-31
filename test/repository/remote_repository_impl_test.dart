
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/repository/remote/exception/connection_exception.dart';
import 'package:nasa_pictures/repository/remote/exception/invalid_code_exception.dart';
import 'package:nasa_pictures/domain/remote_repository_impl.dart';
import 'remote_repository_impl_test.mocks.dart';

@GenerateMocks([
  http.Client
], customMocks: [
  MockSpec<http.Client>(
    as: #MockHttpRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  group('RemoteRepositoryImpl Tests', () {
    late RemoteRepositoryImpl remoteRepository;
    late MockHttpRelaxed mockClient;

    setUp(() {
      mockClient = MockHttpRelaxed();
      remoteRepository = RemoteRepositoryImpl(httpClient: mockClient);
    });

    test('Successful API call returns list of NasaPictures', () async {
      const apiUrl = "https://api.nasa.gov/planetary/apod?count=16&api_key=Gv5aQ2LgrOR0SZ08nEpRDpajMPvjLLjzYG9R51K7";
      const responseBody = '[{"id": "1", "title": "Picture 1", "url": "url1", "date": "2022-01-01", "explanation": "Explanation 1"}, {"id": "2", "title": "Picture 2", "url": "url2", "date": "2022-01-02", "explanation": "Explanation 2"}]';

      when(mockClient.get(Uri.parse(apiUrl)))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      final result = await remoteRepository.findPictures();

      expect(result.length, 2);
      expect(result[0].id, "1");
      expect(result[0].title, "Picture 1");
      expect(result[1].id, "2");
      expect(result[1].title, "Picture 2");
    });

    test('API call with invalid response code throws InvalidCodeException', () async {
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('', 400));

      expect(() => remoteRepository.findPictures(), throwsA(isA<InvalidCodeException>()));
    });

    test('Failed API call throws ConnectionException', () async {
      const apiUrl = "https://api.nasa.gov/planetary/apod?count=16&api_key=Gv5aQ2LgrOR0SZ08nEpRDpajMPvjLLjzYG9R51K7";

      when(mockClient.get(Uri.parse(apiUrl)))
          .thenAnswer((_) async => throw Exception('Failed to connect'));

      expect(() => remoteRepository.findPictures(), throwsA(isA<ConnectionException>()));
    });
  });
}
