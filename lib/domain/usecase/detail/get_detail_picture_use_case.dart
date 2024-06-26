
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_success.dart';
import 'package:nasa_pictures/data/local/local_repository.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_not_found.dart';
import 'package:nasa_pictures/domain/usecase/use_case.dart';

class GetDetailPictureUseCase extends UseCase<String, GetDetailPicture> {
  late final LocalRepository _localRepository;

  GetDetailPictureUseCase({required LocalRepository localRepository}) : super() {
    _localRepository = localRepository;
  }

  @override
  Future<GetDetailPicture> call(String init) async {
    final NasaPicture? picture = await _localRepository.findOnePicture(init);

    if(picture != null) {
      return GetDetailPictureSuccess(picture: picture);
    }

    return GetDetailPictureNotFound();
  }
}