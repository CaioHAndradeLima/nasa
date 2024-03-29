
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/repository/remote/remote_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {

  @override
  Future<List<NasaPicture>> findPictures() {
    throw UnimplementedError();
  }
}