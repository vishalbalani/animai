import 'package:flutter/material.dart';

enum AppLanguage {
  english(
    code: 'en',
    locale: Locale('en', 'US'),
    name: 'English',
    localizedName: 'English',
  ),
  arabic(
    code: 'ar',
    locale: Locale('ar', 'SA'),
    name: 'Arabic',
    localizedName: 'العربية',
  ),
  hindi(
    code: 'hi',
    locale: Locale('hi', 'IN'),
    name: 'Hindi',
    localizedName: 'हिंदी',
  ),
  spanish(
    code: 'es',
    locale: Locale('es', 'ES'),
    name: 'Spanish',
    localizedName: 'Español',
  );

  final String code;
  final Locale locale;
  final String name;
  final String localizedName;

  const AppLanguage({
    required this.code,
    required this.locale,
    required this.name,
    required this.localizedName,
  });

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}
