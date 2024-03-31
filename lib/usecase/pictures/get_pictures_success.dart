
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures.dart';

class GetPicturesSuccess extends GetPictures {
  final List<NasaPicture> listPicture;
  GetPicturesSuccess({required this.listPicture});
}