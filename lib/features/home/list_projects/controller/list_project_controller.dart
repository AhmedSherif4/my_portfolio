import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../model/project_model.dart';

class ListProjectsController {
  double itemSize(context) => MediaQuery.sizeOf(context).shortestSide < 550
      ? 200.responsiveWidth
      : 180.0.responsiveWidth;
  late ScrollController listController;

  double getScale(int index, BuildContext context) {
    double scale = getPercent(index, context);
    if (scale > 1.0) scale = 1.0;
    return scale.clamp(0.5, 1.5);
  }

  double getPercent(int index, BuildContext context) {
    final offset = index * itemSize(context);
    final diference = listController.offset - offset;
    final percent = 1 - (diference / (itemSize(context) / 2));
    return percent;
  }

  double getOpacity(int index, BuildContext context) {
    final percent = getPercent(index, context);
    double opacity = percent;
    if (opacity > 1.0) opacity = 1.0;
    if (opacity < 0.0) opacity = 0.0;
    return opacity;
  }

  List<ProjectsModel> projects = [
    ProjectsModel(
      name: "Tasesse",
      description:
          "Education App Education App Education App Education App Education App Education App Education App Education App Education App Education App Education App Education App ",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
    ProjectsModel(
      name: "Tasesse",
      description: "Education App",
      imageUrl: AppIconsAssets.pPostman,
    ),
  ];
}
