// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> bn = {
    " welcome_to_flutter": "স্বাগতম",
    "welcome_to_second_page": "স্বাগতম দ্বিতীয় পৃষ্ঠায়"
  };
  static const Map<String, dynamic> en = {
    " welcome_to_flutter": "Welcome to Flutter",
    "welcome_to_second_page": "Welcome to Second Page"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "bn": bn,
    "en": en
  };
}
