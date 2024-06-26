// Mocks generated by Mockito 5.4.4 from annotations
// in nasa_pictures/test/presentation/nasa_details_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nasa_pictures/domain/usecase/detail/get_detail.dart' as _i2;
import 'package:nasa_pictures/domain/usecase/detail/get_detail_picture_use_case.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetDetailPicture_0 extends _i1.SmartFake
    implements _i2.GetDetailPicture {
  _FakeGetDetailPicture_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetDetailPictureUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDetailPictureUseCase extends _i1.Mock
    implements _i3.GetDetailPictureUseCase {
  MockGetDetailPictureUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.GetDetailPicture> call(String? init) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [init],
        ),
        returnValue:
            _i4.Future<_i2.GetDetailPicture>.value(_FakeGetDetailPicture_0(
          this,
          Invocation.method(
            #call,
            [init],
          ),
        )),
      ) as _i4.Future<_i2.GetDetailPicture>);
}

/// A class which mocks [GetDetailPictureUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDetailPictureUseCaseRelaxed extends _i1.Mock
    implements _i3.GetDetailPictureUseCase {
  @override
  _i4.Future<_i2.GetDetailPicture> call(String? init) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [init],
        ),
        returnValue:
            _i4.Future<_i2.GetDetailPicture>.value(_FakeGetDetailPicture_0(
          this,
          Invocation.method(
            #call,
            [init],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.GetDetailPicture>.value(_FakeGetDetailPicture_0(
          this,
          Invocation.method(
            #call,
            [init],
          ),
        )),
      ) as _i4.Future<_i2.GetDetailPicture>);
}
