
import 'package:nasa_pictures/data/local/picture_local_filter.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';

abstract class LocalRepository {

  Future<List<NasaPicture>?> findPictures({PictureLocalFilter filter});
  Future<NasaPicture?> findOnePicture(String id);
  Future<void> insertAll(List<NasaPicture> pictures);
  Future<void> deleteAll();
}