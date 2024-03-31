
import 'package:nasa_pictures/presentation/detail/bloc/state/picture_state.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';

class PictureSuccessState extends PictureState {
  final NasaPicture picture;

  PictureSuccessState({required this.picture});
}