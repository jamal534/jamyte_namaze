import 'package:flutter/cupertino.dart';

import 'app.dart';
import 'core/binding/binding.dart';
import 'core/helper/select_language_sharedprefer.dart';
import 'core/helper/shared_preference_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesHelper().init();
  Locale? savedLocale = await SharedPrefsHelper.getLocale('user_locale');


  AppBinding().dependencies();

  runApp(MyApp(locale: savedLocale ?? Locale('en', 'US')));
}

