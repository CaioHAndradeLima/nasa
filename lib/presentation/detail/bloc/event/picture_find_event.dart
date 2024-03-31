
import 'package:nasa_pictures/presentation/detail/bloc/event/picture_event.dart';

class PictureFindEvent extends PictureEvent {
  final String idPicture;

  PictureFindEvent({required this.idPicture});
}