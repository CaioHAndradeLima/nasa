
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering.dart';

class GetPicturesFilteringSuccess extends GetPicturesFiltering {
  final List<NasaPicture> pictures;
  GetPicturesFilteringSuccess({required this.pictures});
}