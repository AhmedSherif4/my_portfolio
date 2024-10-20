import 'dart:ui';

enum Language {
  // english(
  //   Locale('en', 'US'),
  //   'English',
  // ),
  arabic(
    Locale('ar', 'SA'),
    'Arabic',
  );

  const Language(
      this.value,
      this.text,
      );

  final Locale value;
  final String text;
}