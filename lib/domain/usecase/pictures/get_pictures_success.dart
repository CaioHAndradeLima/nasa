
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures.dart';

class GetPicturesSuccess extends GetPictures {
  final List<NasaPicture> listPicture;
  GetPicturesSuccess({required this.listPicture});
}