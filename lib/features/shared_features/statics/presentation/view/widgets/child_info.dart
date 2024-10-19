part of '../../../statics.dart';


class ChildInfoWidgetForStatics extends StatelessWidget {
  final UserEntity userData;

  const ChildInfoWidgetForStatics({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppReference.deviceHeight(context) * 0.14.responsiveHeightRatio,
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.appBorderRadiusR10.responsiveSize,
        ),
        color: AppColors.white,
        boxShadow: [AppShadow.appBoxShadow()],
      ),
      child: LayoutBuilder(builder: (context, constrains) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: constrains.maxHeight * 0.2,
              child: FittedBox(
                child: Text(
                  AppReference.userIsGuest()?"زائر":
                  userData.name,
                  style: const AppTextStyle().titleSmall18.copyWith(
                        fontSize: AppFontSize.sp10.responsiveFontSize,
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            (constrains.maxHeight * 0.02).sizedBoxHeight,
            SizedBox(
              height: constrains.maxHeight * 0.3,
              child: LayoutBuilder(builder: (context, consRow) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      //width: consRow.maxWidth * 0.35,
                      child: TextWithBackGroundColor(
                      isOneLine: true,
                        text: userData.gender=="male" ? AppStrings.male : AppStrings.female,
                        verticalPadding:  0,
                        horizontalPadding: 0,
                        textColor: AppColors.textColor,
                        backgroundColor: AppColors.backgroundColor,
                        fontSize: AppFontSize.sp10.responsiveFontSize,
                      ),
                    ),
                    AppReference.deviceIsTablet?AppSize.s16.sizedBoxWidth:AppSize.s36.sizedBoxWidth,
                    SizedBox(
                      width: consRow.maxWidth * 0.5,
                      child: TextWithBackGroundColor(
                        text: userData.classroomName ?? '',
                        isOneLine: true,
                        textColor: AppColors.black,
                        fontSize: 12,
                        verticalPadding: 0,
                        horizontalPadding: 0,
                        backgroundColor: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                );
              }),
            ),
            (constrains.maxHeight * 0.06).sizedBoxHeight,
            SizedBox(
              height: constrains.maxHeight * 0.32,
              child: CustomInkWell(
                onTap: AppReference.userIsGuest() ? (){
                  AppReference.guestDialogMustLogin(context);
                }: () {
                  RouteManager.rPushNamed(
                    context: context,
                    rName: AppRoutesNames.rAllSubscriptionClassroomScreen,
                    arguments: userData,
                  );
                },
                child: const TextWithBackGroundColor(
                  text: ' الاشتراكات  الأخرى  ⬅  ',
                  textColor: AppColors.black,
                  isOneLine: true,
                  verticalPadding: 0,
                  fontSize: 12,
                  horizontalPadding: 0,
                  backgroundColor: AppColors.backgroundColor,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
