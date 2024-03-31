
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/detail/get_detail.dart';

class GetDetailPictureSuccess extends GetDetailPicture {
  final NasaPicture picture;
  GetDetailPictureSuccess({required this.picture});
}