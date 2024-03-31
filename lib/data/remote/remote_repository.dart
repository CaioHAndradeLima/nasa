
import 'package:nasa_pictures/data/model/nasa_picture.dart';

abstract class RemoteRepository {

  Future<List<NasaPicture>> findPictures();
}