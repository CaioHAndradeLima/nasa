
import 'package:nasa_pictures/data/model/nasa_picture.dart';

class PictureLocalFilter {
  late final String? _title;
  late final String? _date;

  PictureLocalFilter({String? date, String? title}) {
    _title = title;
    _date = date;
  }

  List<NasaPicture> applyFilter(List<NasaPicture> pictures) {
    return pictures
        .where((picture) =>
            picture.date == _date || (_title != null && picture.title.toLowerCase().contains(_title.toLowerCase())))
        .toList();
  }
}