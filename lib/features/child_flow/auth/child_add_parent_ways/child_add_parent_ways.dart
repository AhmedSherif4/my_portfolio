import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/features/auth/shared_screens/base%20screens/base_person_add_person_ways.dart';

import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';

class ChildAddParentWays extends StatelessWidget {
  final bool fromParentsScreen;

  const ChildAddParentWays({
    super.key,
    this.fromParentsScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return BasePersonAddPersonWays(
      fromParentsScreen: fromParentsScreen,
      title: AppStrings.addYourParent,
      buttonTitle1: AppStrings.parentAlreadyRegistered,
      buttonOnPressed1: () {
        RouteManager.rPushNamed(
            context: context, rName: AppRoutesNames.rChildAddExistParentScreen);
      },
      buttonTitle2: AppStrings.registerParentFromStartAndAddHim,
      buttonOnPressed2: () {
        RouteManager.rPushNamed(
            context: context, rName: AppRoutesNames.rChildAddNewParentScreen);
      },
    );
  }
}
