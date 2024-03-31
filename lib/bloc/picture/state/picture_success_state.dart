
import 'package:nasa_pictures/bloc/picture/state/picture_state.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

class PictureSuccessState extends PictureState {
  final NasaPicture picture;

  PictureSuccessState({required this.picture});
}