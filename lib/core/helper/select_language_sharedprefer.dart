import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Save Locale as a String (e.g., 'en_US')
  static Future<void> setLocale(String key, Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String localeString = "${locale.languageCode}_${locale.countryCode}";
    await preferences.setString(key, localeString);
  }

  // Get Locale from a String (e.g., 'en_US' => Locale('en', 'US'))
  static Future<Locale?> getLocale(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? localeString = preferences.getString(key);

    if (localeString != null) {
      List<String> parts = localeString.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      }
    }
    return null; // Return null if no locale is found
  }

  // Save String Data to SharedPreferences
  static Future<void> setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  // Get String Data from SharedPreferences
  static Future<String?> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}
