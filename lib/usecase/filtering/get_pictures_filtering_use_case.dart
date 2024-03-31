
import 'package:nasa_pictures/repository/local/filter/picture_local_filter.dart';
import 'package:nasa_pictures/repository/local/local_repository.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_in.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_no_results.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_success.dart';
import 'package:nasa_pictures/usecase/use_case.dart';

class GetPicturesFilteringUseCase extends UseCase<GetPicturesFilteringIn, GetPicturesFiltering> {
  late final LocalRepository _localRepository;

  GetPicturesFilteringUseCase({
    required LocalRepository localRepository,
  }) : super() {
    _localRepository = localRepository;
  }

  @override
  Future<GetPicturesFiltering> call(GetPicturesFilteringIn init) async {
    final List<NasaPicture>? listPictures = await _localRepository.findPictures(
      filter: PictureLocalFilter(
        date: init.date,
        title: init.title,
      )
    );

    if(listPictures != null && listPictures.isNotEmpty) {
      return GetPicturesFilteringSuccess(pictures: listPictures);
    }

    return GetPicturesFilteringNoResults();
  }
}