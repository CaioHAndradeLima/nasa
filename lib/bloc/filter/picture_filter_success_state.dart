
import 'package:nasa_pictures/bloc/filter/picture_filter_state.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

class PictureFilterSuccessState extends PictureFilterState {
  final List<NasaPicture> pictures;

  PictureFilterSuccessState({required this.pictures});
}