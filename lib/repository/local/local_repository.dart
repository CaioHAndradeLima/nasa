
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

abstract class LocalRepository {

  Future<List<NasaPicture>?> findPictures();
  Future<NasaPicture?> findOnePicture();
}