
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/state/pictures_state.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';

class PicturesSuccessState extends PicturesState {
  final List<NasaPicture> listPicture;

  PicturesSuccessState({required this.listPicture});
}