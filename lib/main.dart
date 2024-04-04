
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:nasa_pictures/di/dependency_injection.dart';
import 'package:nasa_pictures/route/app_route.dart';
import 'package:nasa_pictures/theme/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  DependencyInject.setup();
  WidgetsFlutterBinding.ensureInitialized();
  final FluroRouter router = FluroRouter();
  AppRouter().routes(router);
  await DependencyInject.setupLocalizations();

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final FluroRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.defaultTheme(context),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generator,
      initialRoute: 'home',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
