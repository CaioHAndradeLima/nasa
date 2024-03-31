
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering.dart';

class GetPicturesFilteringSuccess extends GetPicturesFiltering {
  final List<NasaPicture> pictures;
  GetPicturesFilteringSuccess({required this.pictures});
}