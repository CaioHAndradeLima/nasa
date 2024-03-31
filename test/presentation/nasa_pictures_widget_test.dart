
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa_pictures/bloc/filter/picture_filter_bloc.dart';
import 'package:nasa_pictures/bloc/pictures/pictures_bloc.dart';
import 'package:nasa_pictures/bloc/pictures/state/pictures_error_state.dart';
import 'package:nasa_pictures/bloc/pictures/state/pictures_loading_state.dart';
import 'package:nasa_pictures/bloc/pictures/state/pictures_success_state.dart';
import 'package:nasa_pictures/common/app_bar_widget.dart';
import 'package:nasa_pictures/common/ui/loading_widget.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';
import 'package:nasa_pictures/feature/pictures/exhibition_pictures_widget.dart';
import 'package:nasa_pictures/feature/pictures/nasa_pictures_widget.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/filtering/get_pictures_filtering_use_case.dart';
import 'package:nasa_pictures/usecase/pictures/get_pictures_use_case.dart';
import '../bloc/picture_bloc_test.mocks.dart';
import '../bloc/picture_filter_bloc_test.mocks.dart';

@GenerateMocks([
  GetPicturesUseCase, GetPicturesFilteringUseCase
], customMocks: [
  MockSpec<GetPicturesUseCase>(
    as: #MockGetPicturesUseCaseRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<GetPicturesFilteringUseCase>(
    as: #MockGetPicturesFilteringUseCaseRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  group('NasaPicturesWidget Tests', () {
    late PicturesBloc mockPicturesBloc;
    GetIt.I.registerLazySingleton<PicturesBloc>(() => mockPicturesBloc);
    GetIt.I.registerLazySingleton<PicturesFilterBloc>(() => PicturesFilterBloc(
      getPicturesFilteringUseCase: MockGetPicturesFilteringUseCaseRelaxed()
    ));

    setUp(() {
      mockPicturesBloc = PicturesBloc(getPicturesUseCase: MockGetPicturesUseCaseRelaxed());
      GetIt.I.resetLazySingleton<PicturesBloc>();
    });

    testWidgets('Widget builds correctly with PicturesLoadingState', (WidgetTester tester) async {
      mockPicturesBloc.emit(PicturesLoadingState());

      await tester.pumpWidget(
        const MaterialApp(
          home: NasaPicturesWidget(),
        ),
      );

      expect(find.byType(AppBarWidget), findsOneWidget);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('Widget builds correctly with PicturesErrorState', (WidgetTester tester) async {
      mockPicturesBloc.emit(PicturesErrorState());

      await tester.pumpWidget(
        const MaterialApp(
          home: NasaPicturesWidget(),
        ),
      );

      expect(find.byType(AppBarWidget), findsOneWidget);
      expect(find.byType(NasaErrorWidget), findsOneWidget);
    });

    testWidgets('Widget builds correctly with PicturesSuccessState', (WidgetTester tester) async {
      final List<NasaPicture> listPicture = [
        NasaPicture(id: '1', title: 'Title 1', url: 'url1', date: '2022-01-01', explanation: 'Explanation 1'),
        NasaPicture(id: '2', title: 'Title 2', url: 'url2', date: '2022-01-02', explanation: 'Explanation 2'),
      ];

      mockPicturesBloc.emit(PicturesSuccessState(listPicture: listPicture));

      await tester.pumpWidget(
        const MaterialApp(
          home: NasaPicturesWidget(),
        ),
      );

      expect(find.byType(AppBarWidget), findsOneWidget);
      expect(find.byType(ExhibitionPicturesWidget), findsOneWidget);
    });
  });
}
