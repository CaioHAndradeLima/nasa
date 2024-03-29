
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

abstract class GetPictureDetail {}
class PictureDetailNotFound extends GetPictureDetail {}
class PictureDetailSuccess extends GetPictureDetail {
  final NasaPicture picture;
  PictureDetailSuccess({required this.picture});
}