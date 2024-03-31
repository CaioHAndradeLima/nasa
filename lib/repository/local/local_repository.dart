
import 'package:nasa_pictures/repository/local/filter/picture_local_filter.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

abstract class LocalRepository {

  Future<List<NasaPicture>?> findPictures({PictureLocalFilter filter});
  Future<NasaPicture?> findOnePicture(String id);
  Future<void> insertAll(List<NasaPicture> pictures);
}