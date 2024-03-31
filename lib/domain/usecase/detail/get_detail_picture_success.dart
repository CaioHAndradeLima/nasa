
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail.dart';

class GetDetailPictureSuccess extends GetDetailPicture {
  final NasaPicture picture;
  GetDetailPictureSuccess({required this.picture});
}