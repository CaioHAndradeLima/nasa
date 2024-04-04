
import 'package:get_it/get_it.dart';
import 'package:nasa_pictures/common/strings.dart';

mixin StringsMixin {
  final strings = GetIt.I<Strings>().appLocalizations;
}