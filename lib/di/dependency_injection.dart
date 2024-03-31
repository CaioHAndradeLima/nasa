
import 'package:get_it/get_it.dart';
import 'package:localstore/localstore.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/picture_filter_bloc.dart';
import 'package:nasa_pictures/presentation/detail/bloc/picture_bloc.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/pictures/pictures_bloc.dart';
import 'package:nasa_pictures/data/local/local_repository.dart';
import 'package:nasa_pictures/domain/repository/local_repository_impl.dart';
import 'package:nasa_pictures/data/remote/remote_repository.dart';
import 'package:nasa_pictures/domain/repository/remote_repository_impl.dart';
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_use_case.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_use_case.dart';
import 'package:nasa_pictures/domain/usecase/pictures/get_pictures_use_case.dart';
import 'package:http/http.dart' as http;

class DependencyInject {
  static void setup() {
    final getIt = GetIt.instance;

    //repositories
    getIt.registerSingleton<LocalRepository>(LocalRepositoryImpl(
        instance: Localstore.instance
    ), signalsReady: true);
    getIt.registerSingleton<RemoteRepository>(
      RemoteRepositoryImpl(httpClient: http.Client()),
        signalsReady: true,
    );

    //use cases
    getIt.registerSingleton<GetPicturesUseCase>(
      GetPicturesUseCase(
        localRepository: getIt<LocalRepository>(),
        remoteRepository: getIt<RemoteRepository>(),
      ),
    );
    getIt.registerSingleton<GetPicturesFilteringUseCase>(
      GetPicturesFilteringUseCase(
        localRepository: getIt<LocalRepository>(),
      ),
    );
    getIt.registerSingleton<GetDetailPictureUseCase>(
      GetDetailPictureUseCase(localRepository: getIt<LocalRepository>()),
    );

    //blocs
    getIt.registerSingleton<PicturesBloc>(
      PicturesBloc(
          getPicturesUseCase: getIt<GetPicturesUseCase>(),
      ),
    );
    getIt.registerSingleton<PicturesFilterBloc>(
      PicturesFilterBloc(
          getPicturesFilteringUseCase: getIt<GetPicturesFilteringUseCase>(),
      ),
    );
    getIt.registerLazySingleton<PictureBloc>(() {
      return PictureBloc(getDetailPicture: getIt<GetDetailPictureUseCase>());
    });
  }
}
