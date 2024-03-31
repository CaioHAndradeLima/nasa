
import 'dart:convert';

import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/repository/remote/exception/connection_exception.dart';
import 'package:nasa_pictures/repository/remote/exception/invalid_code_exception.dart';
import 'package:nasa_pictures/repository/remote/remote_repository.dart';
import 'package:http/http.dart' as http;

class RemoteRepositoryImpl extends RemoteRepository {

  @override
  Future<List<NasaPicture>> findPictures() async {

    //hardcode just because its a test, real scenery use environments settings
    const apiUrl = "https://api.nasa.gov/planetary/apod?count=16&api_key=Gv5aQ2LgrOR0SZ08nEpRDpajMPvjLLjzYG9R51K7";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<NasaPicture> list = data
            .map((movieData) => NasaPicture.fromMap(movieData))
            .toList();

        return list;
      } else {
        throw InvalidCodeException();
      }
    } catch (error) {
      throw ConnectionException();
    }
  }
}