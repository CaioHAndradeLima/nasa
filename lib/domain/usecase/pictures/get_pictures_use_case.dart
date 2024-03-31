
import 'package:nasa_pictures/data/local/local_repository.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/data/remote/remote_repository.dart';
import 'package:nasa_pictures/domain/usecase/empty_in_use_case.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures_request_fail.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures_success.dart';

class GetPicturesUseCase extends EmptyInUseCase<GetPictures> {
  late final LocalRepository _localRepository;
  late final RemoteRepository _remoteRepository;

  GetPicturesUseCase({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
  }) : super() {
    _remoteRepository = remoteRepository;
    _localRepository = localRepository;
  }

  @override
  Future<GetPictures> call() async {
    final List<NasaPicture>? listPictures = await _localRepository.findPictures();

    if(listPictures != null) {
      return GetPicturesSuccess(listPicture: listPictures);
    }

    try {
      final listPictures = await _remoteRepository.findPictures();
      await _localRepository.insertAll(listPictures);
      return GetPicturesSuccess(listPicture: listPictures);
    } catch(e) {
      return GetPicturesRequestFail();
    }
  }
}