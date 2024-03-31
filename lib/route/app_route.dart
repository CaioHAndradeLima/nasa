
import 'package:fluro/fluro.dart';
import 'package:nasa_pictures/route/route_handler.dart';

class AppRouter with RouteHandler {
  static final AppRouter routesInstance = AppRouter._();

  factory AppRouter() {
    return routesInstance;
  }

  AppRouter._();

  void routes(FluroRouter fluroRouter) {
    const TransitionType transitionType = TransitionType.cupertino;

    fluroRouter.define(
      'home',
      handler: picturesHandler,
      transitionType: transitionType,
    );

    fluroRouter.define(
      'detail/:id',
      handler: detailHandler,
      transitionType: transitionType,
    );
  }
}
