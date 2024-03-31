
import 'dart:convert';
import 'package:http/http.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/data/remote/exception/connection_exception.dart';
import 'package:nasa_pictures/data/remote/exception/invalid_code_exception.dart';
import 'package:nasa_pictures/data/remote/remote_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {

  late final Client _httpClient;
  RemoteRepositoryImpl({required Client httpClient}) {
    _httpClient = httpClient;
  }

  @override
  Future<List<NasaPicture>> findPictures() async {
    //hardcode just because its a test, real scenery use environments settings
    const apiUrl = "https://api.nasa.gov/planetary/apod?count=16&api_key=Gv5aQ2LgrOR0SZ08nEpRDpajMPvjLLjzYG9R51K7";

    Response response;
    try {
      response = await _httpClient.get(Uri.parse(apiUrl));
    } catch (error) {
      throw ConnectionException();
    }

    if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<NasaPicture> list = data
            .map((movieData) => NasaPicture.fromMap(movieData))
            .toList();

        return list;
      } else {
        throw InvalidCodeException();
      }
  }
}