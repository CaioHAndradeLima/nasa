
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa_pictures/bloc/picture/picture_bloc.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_error_state.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_loading_state.dart';
import 'package:nasa_pictures/bloc/picture/state/picture_success_state.dart';
import 'package:nasa_pictures/common/ui/circle_close_button.dart';
import 'package:nasa_pictures/common/ui/loading_widget.dart';
import 'package:nasa_pictures/common/ui/nasa_error_widget.dart';
import 'package:nasa_pictures/feature/detail/nasa_details_widget.dart';
import 'package:nasa_pictures/repository/model/nasa_picture.dart';
import 'package:nasa_pictures/usecase/detail/get_detail_picture_use_case.dart';
import 'nasa_details_widget_test.mocks.dart';

@GenerateMocks([
  GetDetailPictureUseCase
], customMocks: [
  MockSpec<GetDetailPictureUseCase>(
    as: #MockGetDetailPictureUseCaseRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  group('NasaDetailWidget Tests', () {
    late PictureBloc mockPictureBloc;
    GetIt.I.registerLazySingleton<PictureBloc>(() => mockPictureBloc);

    setUp(() {
      mockPictureBloc = PictureBloc(getDetailPicture: MockGetDetailPictureUseCaseRelaxed());
      GetIt.I.resetLazySingleton<PictureBloc>();
    });

    testWidgets('Widget builds correctly with PictureLoadingState', (WidgetTester tester) async {

      mockPictureBloc.emit(PictureLoadingState());
      await tester.pumpWidget(
        const MaterialApp(
            home: Scaffold(
                body: NasaDetailWidget(
          idPicture: '1',
        ))),
      );

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('Widget builds correctly with PictureErrorState', (WidgetTester tester) async {
      mockPictureBloc.emit(PictureErrorState());
      await tester.pumpWidget(
        const MaterialApp(
          home: NasaDetailWidget(idPicture: '1'),
        ),
      );

      expect(find.byType(NasaErrorWidget), findsOneWidget);
    });

    testWidgets('Widget builds correctly with PictureSuccessState', (WidgetTester tester) async {
      final picture = NasaPicture(
        id: '1',
        title: 'Picture Title',
        url: 'picture_url',
        date: '2022-01-01',
        explanation: 'Picture Explanation',
      );

      mockPictureBloc.emit(PictureSuccessState(picture: picture));

      await tester.pumpWidget(
        const MaterialApp(
          home: NasaDetailWidget(idPicture: '1'),
        ),
      );

      expect(find.text('2022-01-01'), findsOneWidget);
      expect(find.text('Picture Title'), findsOneWidget);
      expect(find.text('Picture Explanation'), findsOneWidget);
      expect(find.byType(CircleCloseButton), findsOneWidget);
    });
  });
}
