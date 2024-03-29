
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/repository/local/local_repository.dart';
import 'package:nasa_pictures/repository/local/local_repository_impl.dart';
import 'package:nasa_pictures/repository/remote/remote_repository.dart';
import 'package:nasa_pictures/repository/remote/remote_repository_impl.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_use_case.dart';

class InjectDependency {

  static void setup() {
    final getIt = GetIt.instance;

    getIt.registerSingleton<LocalRepository>(LocalRepositoryImpl(), signalsReady: true);
    getIt.registerSingleton<RemoteRepository>(RemoteRepositoryImpl(), signalsReady: true);

    getIt.registerSingleton<GetPicturesUseCase>(
      GetPicturesUseCase(
        localRepository: getIt<LocalRepository>(),
        remoteRepository: getIt<RemoteRepository>(),
      ),
    );
    getIt.registerSingleton<RemoteRepository>(RemoteRepositoryImpl());

  }
}