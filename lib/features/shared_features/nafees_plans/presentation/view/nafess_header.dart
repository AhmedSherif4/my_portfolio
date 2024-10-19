import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import '../../../../../config/resources/app_assets.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_constants.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../core/shared_widget/rank_button.dart';
import '../../../../../my_app/app_reference.dart';
import '../../../rank/presentation/rank_screen/rank_data.dart';

class NafeesHeaderForAllChild extends StatelessWidget {
  final UserEntity? userData;
  final String title;
  final Color textColor;
  final bool notFirst;
  final bool haveIcon;
  final Function()? onBack;

  const NafeesHeaderForAllChild(
      {super.key,
      this.userData,
      required this.title,
        this.textColor = AppColors.black,
        this.notFirst = true,
        this.haveIcon = false,
      this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppReference.deviceIsTablet
          ? AppReference.deviceHeight(context) * 0.045.responsiveHeightRatio
          : AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AppImagesAssets.sLogoWithoutName,
              height: constrains.maxHeight * 0.8,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: AppReference.deviceIsTablet
                  ? constrains.maxWidth * 0.2
                  : constrains.maxWidth * 0.5,
              child: LayoutBuilder(builder: (context, consColumn) {
                return SizedBox(
                  height: consColumn.maxHeight * 0.5,
                  width: consColumn.maxWidth,
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: AppReference.themeData.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
            AppReference.deviceIsTablet
                ? (constrains.maxWidth * 0.03).sizedBoxWidth
                : (constrains.maxWidth * 0.0125).sizedBoxWidth,
            if(AppReference.userIsChild())...[
            Container(
              padding: EdgeInsets.all(AppPadding.p6.responsiveSize),
              width: constrains.maxWidth * 0.09,
              height: constrains.maxHeight * .9,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadiusR15.responsiveSize),
                  border: Border.all(color: AppColors.primaryColor2, width: 2)),
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "نقاطي",
                        style: const AppTextStyle()
                            .balooBhaijaan2
                            .w600
                            .bodySmall12
                            .copyWith(
                                color: AppColors.primaryColor2,
                                fontSize: AppFontSize.sp10.responsiveFontSize),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        userData != null
                            ? userData!.points.toString()
                            : getIt<UserLocalDataSource>()
                                .getUserData()!
                                .points
                                .toString(),
                        style: const AppTextStyle()
                            .balooBhaijaan2
                            .w500
                            .bodySmall12
                            .copyWith(
                                fontSize: AppFontSize.sp10.responsiveFontSize),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.08,
              height: constrains.maxHeight * .9,
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
            )],
            switch (notFirst) {
              true => GestureDetector(
                  onTap: onBack ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      height: constrains.maxHeight,
                      padding: EdgeInsetsDirectional.all(
                          AppPadding.p12.responsiveSize),
                      child: Text(
                        "رجوع",
                        style: const AppTextStyle()
                            .balooBhaijaan2
                            .w700
                            .bodyMedium14
                            .copyWith(
                                fontSize: AppFontSize.sp14.responsiveFontSize,
                                color: AppColors.primaryColor2),
                      )),
                ),
              false => (constrains.maxWidth * 0.1).sizedBoxWidth
            }
          ],
        );
      }),
    );
  }
}
