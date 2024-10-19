import 'package:flutter/material.dart';

import '../../config/routes/route_manager.dart';
import '../../config/routes/routes_names.dart';
import '../../features/shared_features/rank/presentation/rank_screen/rank_data.dart';
import '../../my_app/app_reference.dart';
import '../services/services_locator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';

import '../shared_models/user/data/user_local_data_source/user_local_data_source.dart';


class RankButton extends StatelessWidget {
  final RankData? rankData;

  const RankButton({super.key, this.rankData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rRankScreen,
            arguments: rankData ??
                RankData(
                  stageId: getIt<UserLocalDataSource>().getUserData()!.stageId!,
                  systemId: getIt<UserLocalDataSource>().getUserData()!.systemId!,
                  pathId: getIt<UserLocalDataSource>().getUserData()!.pathId!,
                  classroomId:
                  getIt<UserLocalDataSource>().getUserData()!.classroomId!,
                  termId: getIt<UserLocalDataSource>().getUserData()!.termId!,
                  childId: getIt<UserLocalDataSource>().getUserData()!.userId,
                ),
          );
        }else{
          AppReference.guestDialogMustLogin(context);
        }
      },
      child: SvgPicture.asset(
        AppImagesAssets.sRankIcon,
      ),
    );
  }
}
