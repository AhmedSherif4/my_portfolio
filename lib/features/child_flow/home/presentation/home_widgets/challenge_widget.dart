
part of'../../home.dart';

class ChallengeWidget extends StatelessWidget {
  final Function() onTap;
  final Color borderColor;
  final Color itemColor;
  final String imagePath;
  final String title;
  final String body;

  const ChallengeWidget(
      {super.key,
      required this.onTap,
      required this.borderColor,
      required this.itemColor,
      required this.imagePath,
      required this.title,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width: AppReference.deviceWidth(context) * 0.5,
        height: (AppReference.deviceIsTablet &&
                !AppReference.isPortrait(context))
            ? AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio
            : AppReference.deviceHeight(context) * 0.18.responsiveHeightRatio,
        padding: EdgeInsets.all(AppPadding.p8.responsiveSize),
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR15.responsiveSize),
          border: Border.symmetric(
            horizontal:
                BorderSide(color: borderColor, width: 3.responsiveWidth),
            vertical:
                BorderSide(color: borderColor, width: 1.5.responsiveWidth),
          ),
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: constrains.maxHeight * 0.33,
                child: LayoutBuilder(builder: (context, consRow) {
                  return Row(
                    children: [
                      SizedBox(
                        width: consRow.maxWidth * 0.6,
                        child: Text(
                          title,
                          style: (AppReference.deviceIsTablet &&
                                  !AppReference.isPortrait(context))
                              ? const AppTextStyle().white.w700.bodyMedium14
                              : const AppTextStyle().white.w700.titleSmall18,
                        ),
                      ),
                      SizedBox(
                        width: consRow.maxWidth * 0.2,
                        child: SvgPicture.asset(
                          imagePath,
                          alignment: Alignment.center,
                          height: constrains.maxHeight * 0.25,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              (constrains.maxHeight * 0.01).sizedBoxHeight,
              SizedBox(
                height: constrains.maxHeight * 0.5,
                child: Text(
                  body,
                  style: const AppTextStyle().white.w500.bodySmall12,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              (constrains.maxHeight * 0.01).sizedBoxHeight,
              SizedBox(
                  height: constrains.maxHeight * 0.07,
                  width: constrains.maxWidth * 0.9,
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Icon(
                      Icons.arrow_forward,
                      size: AppSize.s16.responsiveSize,
                      color: AppColors.white,
                    ),
                  )),
              (constrains.maxHeight * 0.03).sizedBoxHeight,
            ],
          );
        }),
      ),
    );
  }
}

class ChallengeItemBuilder extends StatelessWidget {
  final String routeName;
  final bool isPrimary;
  final GlobalKey three;
  final GlobalKey five;

  const ChallengeItemBuilder({
    super.key,
    required this.routeName,
    required this.isPrimary,
    required this.three,
    required this.five,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Showcase(
                key: three,
                tooltipPosition: TooltipPosition.bottom,
                tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
                description: AppStrings.haveExams,
                disableDefaultTargetGestures: true,
                child: ChallengeWidget(
                  borderColor: const Color(0x66eec43a).withOpacity(0.8),
                  itemColor: AppColors.primaryColor2,
                  title: AppStrings.challenges,
                  body: AppStrings.chanallegFreind,
                  imagePath: AppImagesAssets.sChallenge,
                  onTap: () {
                    RouteManager.rPushNamedAndRemoveUntil(
                      context: context,
                      rName: routeName,
                      arguments: DataToGoExams(
                        subjects: BlocProvider.of<SharedSubjectsBloc>(context)
                            .state
                            .subjects,
                        user: getIt<UserLocalDataSource>().getUserData()!,
                        isPrimary: isPrimary,
                        fromSubscription: false,
                      ),
                    );
                  },
                ),
              ),
            ),
            AppSize.s20.sizedBoxWidth,
            Expanded(
              child: Showcase(
                key: five,
                tooltipPosition: TooltipPosition.top,
                tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
                description: AppStrings.mySubscriptionShowCase,
                disableDefaultTargetGestures: true,
                child: ChallengeWidget(
                  borderColor: const Color(0xffE4CEFF),
                  itemColor: AppColors.secondaryColor,
                  title: AppStrings.mySubscriptions,
                  body: AppStrings.mySubscriptionsBody,
                  imagePath: AppImagesAssets.sSubscriptinoInHome,
                  onTap: () {
                    if (!AppReference.userIsGuest()) {
                      RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                          arguments: DataToGoRandomExams(
                            isRandomExam: false,
                              user: getIt<UserLocalDataSource>().getUserData()!,
                              isPrimary: isPrimary)
                              );
                    } else {
                      AppReference.guestDialogMustLogin(context);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
