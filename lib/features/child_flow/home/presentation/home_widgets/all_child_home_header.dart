part of '../../home.dart';

class HomeHeaderForAllChild extends StatelessWidget {
  final UserEntity? userData;

  const HomeHeaderForAllChild({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppReference.deviceIsTablet?AppReference.deviceHeight(context) * 0.045.responsiveHeightRatio:AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
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
              width: AppReference.deviceIsTablet?constrains.maxWidth * 0.2:constrains.maxWidth * 0.5,
              child: LayoutBuilder(builder: (context, consColumn) {
                return SizedBox(
                  height: consColumn.maxHeight * 0.5,
                  width: consColumn.maxWidth,
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: FittedBox(
                      child: Text(
                        AppReference.userIsGuest()?"زائر":
                        userData != null
                            ? userData!.name.split(' ').first
                            : getIt<UserLocalDataSource>()
                                .getUserData()!
                                .name.split(' ').first,
                        textAlign: TextAlign.start,
                        style: AppReference.themeData.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
            ),
            if(AppReference.deviceIsTablet&&!AppReference.isPortrait(context))
            SizedBox(
              width: constrains.maxWidth * 0.35,
              child: CustomInkWell(
                onTap: (){
                  showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return  const _MoveBetweenClassroomsDialog();
                      });
                },
                child: Container(
                  height: AppSize.s50.responsiveHeight,
                  alignment: AlignmentDirectional.centerStart,
                  padding: EdgeInsets.symmetric(horizontal: 15.responsiveWidth,vertical: 5.responsiveHeight),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor2,
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR15.responsiveSize
                      //,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset(AppIconsAssets.sDropDownMenu),
                      AppSize.s6.sizedBoxWidth,
                      Text(
                        getIt<UserLocalDataSource>()
                            .getUserData()!
                            .classroomName ??
                            '',
                        style: const AppTextStyle().bodyLarge16.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      AppSize.s6.sizedBoxWidth,
                      SvgPicture.asset(AppIconsAssets.sArrowDown),

                    ],
                  ),
                ),
              ),
            ),

            AppReference.deviceIsTablet?(constrains.maxWidth * 0.03).sizedBoxWidth:(constrains.maxWidth * 0.0125).sizedBoxWidth,
            Container(
              padding: EdgeInsets.all(AppPadding.p6.responsiveSize),
              width: constrains.maxWidth * 0.09,
              height: constrains.maxHeight * .9,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR15.responsiveSize),
                border: Border.all(
                  color: AppColors.primaryColor2,
                  width: 2
                )
              ),
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("نقاطي",
                      style: const AppTextStyle().balooBhaijaan2.w600.bodySmall12.copyWith(
                        color: AppColors.primaryColor2,
                        fontSize: AppFontSize.sp10.responsiveFontSize
                      ),
                      ),
                    ),
                  ) ,
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        userData != null
                            ?
                        userData!.points.toString() : getIt<UserLocalDataSource>().getUserData()!.points.toString(),
                      style: const AppTextStyle().balooBhaijaan2.w500.bodySmall12.copyWith(
                        fontSize: AppFontSize.sp10.responsiveFontSize
                      ),
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
            ),
            GestureDetector(
              onTap: () {
                if(!AppReference.userIsGuest()) {
                  RouteManager.rPushNamed(
                  context: context,
                  rName: AppRoutesNames.rNotificationScreen,
                );
                }else{
                  AppReference.guestDialogMustLogin(context);
                }
              },
              child: SvgPicture.asset(
                AppIconsAssets.sNotificationHomeIcon,
                fit: BoxFit.contain,
                height: constrains.maxHeight * .7,
                width: constrains.maxWidth * .1,
              ),
            )
          ],
        );
      }),
    );
  }
}



