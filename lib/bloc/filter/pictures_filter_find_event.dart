
import 'package:nasa_pictures/bloc/filter/picture_filter_event.dart';

class PicturesFindByFilter extends PictureFilterEvent {
  final String? title;
  final String? date;

  PicturesFindByFilter({required this.title, required this.date});
}
