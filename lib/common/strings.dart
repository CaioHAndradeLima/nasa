
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Strings {
  final AppLocalizations appLocalizations;
  Strings({required this.appLocalizations});

  AppLocalizations call(BuildContext context) {
    return appLocalizations;
  }
}