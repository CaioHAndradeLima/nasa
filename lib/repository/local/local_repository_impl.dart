
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

import 'local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {

  @override
  Future<List<NasaPicture>> findPictures() {
    throw UnimplementedError();
  }

  @override
  Future<NasaPicture?> findOnePicture() {
    throw UnimplementedError();
  }
}