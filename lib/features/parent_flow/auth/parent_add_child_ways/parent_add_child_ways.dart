import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/features/auth/shared_screens/base%20screens/base_person_add_person_ways.dart';

import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';

class ParentAddChildWays extends StatelessWidget {
  const ParentAddChildWays({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePersonAddPersonWays(
      
      title: AppStrings.addYourChild,
      buttonTitle1: AppStrings.childAlreadyRegistered,
      buttonOnPressed1: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rParentAddExistChildScreen,
        );
      },
      buttonTitle2: AppStrings.registerChildFromStartAndAddHim,
      buttonOnPressed2: () {
        RouteManager.rPushNamed(
          rName: AppRoutesNames.rInstitutionAddChildScreen,
          arguments: getIt<UserLocalDataSource>().getUserData()!.userId,
          context: context,
        );
      },
    );
  }
}

