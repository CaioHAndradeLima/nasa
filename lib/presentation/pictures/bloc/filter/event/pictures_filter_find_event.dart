
import 'package:nasa_pictures/presentation/pictures/bloc/filter/event/picture_filter_event.dart';

class PicturesFindByFilter extends PictureFilterEvent {
  final String? title;
  final String? date;

  PicturesFindByFilter({required this.title, required this.date});
}
