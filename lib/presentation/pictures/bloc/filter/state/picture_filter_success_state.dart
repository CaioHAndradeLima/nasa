
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_state.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';

class PictureFilterSuccessState extends PictureFilterState {
  final List<NasaPicture> pictures;

  PictureFilterSuccessState({required this.pictures});
}