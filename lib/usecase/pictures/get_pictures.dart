
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

abstract class GetPictures {}
class GetPicturesRequestFail extends GetPictures {}
class GetPicturesSuccess extends GetPictures {
  final List<NasaPicture> listPicture;
  GetPicturesSuccess({required this.listPicture});
}