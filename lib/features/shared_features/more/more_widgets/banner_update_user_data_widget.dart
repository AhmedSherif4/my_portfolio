part of 'more_widgets.dart';

class BannerUpdateUserDataWidget extends StatelessWidget {
  final String username;
  final String grade;

  const BannerUpdateUserDataWidget({
    super.key,
    required this.username,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(AppPadding.p10.responsiveSize),
      padding: EdgeInsetsDirectional.all(AppPadding.p10.responsiveSize),
      width: AppReference.deviceWidth(context) * 0.6,
      height: AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio,
      decoration: ShapeDecoration(
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppConstants.appPaddingR20.responsiveSize),
        ),
      ),
      child: LayoutBuilder(builder: (context, constrains) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SizedBox(
                  width: constrains.maxWidth * 0.8,
                  child: Text(
                    username,
                    style: const AppTextStyle().w700.white.bodyMedium14,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomInkWell(
                  onTap: () {
                    RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rEditProfileScreen,
                      arguments: DataToGoToEditProfileScreen(
                        title: AppStrings.name,
                        oldData: username,
                      ),
                    );
                  },
                  child: SizedBox(
                    width: constrains.maxWidth * 0.2,
                    child: Text(
                      AppStrings.edit,
                      style: const AppTextStyle()
                          .w700
                          .white
                          .s8
                          .bodyMedium14
                          .copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            if (AppReference.userIsChild())
              Row(
                children: [
                  SizedBox(
                    width: constrains.maxWidth * 0.8,
                    child: Text(
                      grade,
                      style: const AppTextStyle()
                          .balooBhaijaan2
                          .w500
                          .white
                          .bodySmall12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rGradeChoosingScreen,
                        arguments: true,
                      );
                    },
                    child: SizedBox(
                      width: constrains.maxWidth * 0.2,
                      child: Text(
                        AppStrings.edit,
                        style: const AppTextStyle()
                            .w700
                            .white
                            .s8
                            .bodyMedium14
                            .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      }),
    );
  }
}
