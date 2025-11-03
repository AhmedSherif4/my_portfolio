import 'package:flutter/material.dart';

import '../../../config/resources/app_assets.dart';
import '../../../config/resources/app_strings.dart';

class ConstData {
  static const List listOfIconsTechnologies = [
    AppIconsAssets.pAndroidStudio,
    AppIconsAssets.pVscode,
    AppIconsAssets.pSupabase,
    AppIconsAssets.pDart,
    AppIconsAssets.pFlutter,
    AppIconsAssets.pFirebase,
    AppIconsAssets.pPostman,
    AppIconsAssets.pRestful,
    AppIconsAssets.pSql,
    AppIconsAssets.pGithub,
    AppIconsAssets.pAdobeXD,
    AppIconsAssets.pFigma,
    AppIconsAssets.pDocker,
    AppIconsAssets.pAgile,
    AppIconsAssets.pAtlassian,
    AppIconsAssets.pNotion,
  ];

  static const List listOfPrinciplesArchitectures = [
    'Data Structures',
    'Algorithms',
    'CI/CD Principle',
    'State Managements',
    'Web Socket',
    'Animations',
    'OOP Principle',
    'SOLID Principle',
    'Unit Testing',
    'Accessibility',
    'Security Principles',
    'Adaptive Design',
    'Responsive Design',
    'Clean Architecture',
    'Bloc Architecture',
  ];
  static final sectionsOfHome = {
    AppStrings.about: GlobalKey(),
    AppStrings.skills: GlobalKey(),
    AppStrings.projects: GlobalKey(),
    AppStrings.articles: GlobalKey(),
    AppStrings.lectures: GlobalKey(),
    AppStrings.contact: GlobalKey(),
  };
}
