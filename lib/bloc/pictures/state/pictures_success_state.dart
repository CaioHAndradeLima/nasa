
import 'package:nasa_pictures/bloc/pictures/state/pictures_state.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';

class PicturesSuccessState extends PicturesState {
  final List<NasaPicture> listPicture;

  PicturesSuccessState({required this.listPicture});
}