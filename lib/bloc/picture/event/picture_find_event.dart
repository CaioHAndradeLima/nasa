
import 'package:nasa_pictures/bloc/picture/event/picture_event.dart';

class PictureFindEvent extends PictureEvent {
  final String idPicture;

  PictureFindEvent({required this.idPicture});
}