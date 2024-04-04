
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import 'package:nasa_pictures/di/dependency_injection.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/picture_filter_bloc.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_empty_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_no_results_state.dart';
import 'package:nasa_pictures/presentation/pictures/bloc/filter/state/picture_filter_success_state.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';
import 'package:nasa_pictures/presentation/pictures/widget/exhibition_pictures_widget.dart';
import 'package:nasa_pictures/domain/usecase/filtering/get_pictures_filtering_use_case.dart';
import '../bloc/picture_filter_bloc_test.mocks.dart';

@GenerateMocks([
  GetPicturesFilteringUseCase
], customMocks: [
  MockSpec<GetPicturesFilteringUseCase>(
    as: #MockGetPicturesFilteringUseCaseRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  group('ExhibitionPicturesWidget Tests', () {
    late PicturesFilterBloc mockPicturesFilterBloc;
    GetIt.I.registerLazySingleton<PicturesFilterBloc>(() => mockPicturesFilterBloc);
    DependencyInject.setupLocalizations();

    setUp(() {
      mockPicturesFilterBloc = PicturesFilterBloc(getPicturesFilteringUseCase: MockGetPicturesFilteringUseCaseRelaxed());
      GetIt.I.resetLazySingleton<PicturesFilterBloc>();
    });

    testWidgets('Widget builds correctly with PictureFilterEmptyState', (WidgetTester tester) async {
      final List<NasaPicture> listPicture = [
        NasaPicture(id: '1', title: 'Title 1', url: 'url1', date: '2022-01-01', explanation: 'Explanation 1'),
        NasaPicture(id: '2', title: 'Title 2', url: 'url2', date: '2022-01-02', explanation: 'Explanation 2'),
      ];

      mockPicturesFilterBloc.emit(PictureFilterEmptyState());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExhibitionPicturesWidget(listPicture: listPicture),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Title 1'), findsOneWidget);
      expect(find.text('Title 2'), findsOneWidget);
    });

    testWidgets('Widget builds correctly with PictureFilterNoResultsState', (WidgetTester tester) async {
      final List<NasaPicture> listPicture = [];

      mockPicturesFilterBloc.emit(PictureFilterNoResultsState());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExhibitionPicturesWidget(listPicture: listPicture),
          ),
        ),
      );

      expect(find.byType(NasaErrorWidget), findsOneWidget);
    });

    testWidgets('Widget builds correctly with PictureFilterSuccessState', (WidgetTester tester) async {
      final List<NasaPicture> listPicture = [
        NasaPicture(id: '1', title: 'Title 1', url: 'url1', date: '2022-01-01', explanation: 'Explanation 1'),
        NasaPicture(id: '2', title: 'Title 2', url: 'url2', date: '2022-01-02', explanation: 'Explanation 2'),
      ];

      mockPicturesFilterBloc.emit(PictureFilterSuccessState(pictures: listPicture));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExhibitionPicturesWidget(listPicture: listPicture),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Title 1'), findsOneWidget);
      expect(find.text('Title 2'), findsOneWidget);
    });
  });
}
