
import 'package:nasa_pictures/repository/local/local_repository.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/detail/get_detail.dart';
import 'package:nasa_pictures/usecase/use_case.dart';

class GetDetailPictureUseCase extends UseCase<String, GetPictureDetail> {
  final LocalRepository localRepository;

  GetDetailPictureUseCase({required this.localRepository}) : super();

  @override
  Future<GetPictureDetail> call(String init) async {
    final NasaPicture? picture = await localRepository.findOnePicture();

    if(picture != null) {
      return PictureDetailSuccess(picture: picture);
    }

    return PictureDetailNotFound();
  }
}