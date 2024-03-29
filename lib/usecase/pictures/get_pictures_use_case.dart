

import 'package:nasa_pictures/repository/local/local_repository.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/repository/remote/remote_repository.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures.dart';
import 'package:nasa_pictures/usecase/use_case.dart';

class GetPicturesUseCase extends UseCase<void, GetPictures> {
  final LocalRepository localRepository;
  final RemoteRepository remoteRepository;

  GetPicturesUseCase({required this.localRepository, required this.remoteRepository}) : super();

  @override
  Future<GetPictures> call(void init) async {
    final List<NasaPicture>? listPictures = await localRepository.findPictures();

    if(listPictures != null) {
      return GetPicturesSuccess(listPicture: listPictures);
    }

    try {
      final listPictures = await remoteRepository.findPictures();
      return GetPicturesSuccess(listPicture: listPictures);
    } catch(e) {
      return GetPicturesRequestFail();
    }
  }
}