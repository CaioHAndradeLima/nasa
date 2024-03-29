
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

abstract class RemoteRepository {

  Future<List<NasaPicture>> findPictures();
}