import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/core/shared_widget/text_with_background_color.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../features/shared_features/rank/presentation/rank_screen/rank_data.dart';
import '../shared_models/user/user_entity/user_entity.dart';
import 'rank_button.dart';



class HeaderForTermsAndLevelsAndGroup extends StatelessWidget {
  final UserEntity? userData;
  final String title;
  final Function()? backTo;
  final bool? withTitle;
  final bool? withRank;
  const HeaderForTermsAndLevelsAndGroup({super.key, this.title = AppStrings.lessonAndLevel,  this.backTo, this.withTitle=true, this.withRank=false, this.userData,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          children: [
            SvgPicture.asset(
              AppImagesAssets.sLogoWithoutName,
              width: constrains.maxWidth * 0.15,
              height: constrains.maxHeight * 0.6,
              fit: BoxFit.contain,
            ),
            if(withTitle!)...[
            AppSize.s4.sizedBoxWidth,
            TextWithBackGroundColor(
              // backgroundColor: const Color.fromRGBO(63, 41, 117, 0.2),
              backgroundColor: AppColors.white.withOpacity(.5),
              text: title,
              width: constrains.maxWidth * 0.7,
              height: constrains.maxHeight * 0.6,
              fontSize: 12,
              textColor: AppColors.black,
              verticalPadding: 0,
              horizontalPadding: 5.responsiveSize,
            ),
            ],
            const Spacer(),
            if(withRank!)...[
              AppSize.s4.sizedBoxWidth,
        SizedBox(
        width: constrains.maxWidth * 0.1,
        height: AppReference.deviceIsTablet? constrains.maxHeight * .6:constrains.maxHeight * .9,
        child: RankButton(
        rankData: !AppReference.userIsChild()
        ? RankData(
        stageId: userData!.stageId!,
        systemId: userData!.systemId!,
        pathId: userData!.pathId!,
        classroomId: userData!.classroomId!,
        termId: userData!.termId!,
        childId: userData!.userId,
        )
            : null,
        ),
        ),
              AppSize.s10.sizedBoxWidth,
            ],
             TextBackButton(
               backTo: backTo,
             ),
          ],
        );
      }),
    );
  }
}
