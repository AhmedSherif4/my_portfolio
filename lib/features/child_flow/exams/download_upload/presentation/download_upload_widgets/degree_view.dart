part of '../../download_upload.dart';

class DegreeView extends StatelessWidget {
  final int totalPoints;
  final int? degree;
  final bool isPrimary;
  final String? childLevel;
  final List<String>? description;

  const DegreeView({
    super.key,
    required this.totalPoints,
    required this.degree,
    this.isPrimary = false,
    required this.childLevel,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidgetForTablet(
      mobile: Column(
        children: [
          _TitleAssignment(
            title: AppStrings.degreeOfAssignment,
            isPrimary: isPrimary,
          ),
          AppSize.s20.sizedBoxHeight,
          isPrimary
              ? CustomPaint(
                  size: Size(
                      AppReference.deviceWidth(context),
                      (AppReference.deviceWidth(context) * 0.8312236286919831)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: DegreeViewCustomPainter(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: AppReference.deviceIsTablet ? 40 : 100),
                      child: Text(
                        "$degree/$totalPoints",
                        style: const AppTextStyle()
                            .balooBhaijaan2
                            .w700
                            .s50
                            .displayLarge32
                            .copyWith(color: AppColors.successColor),
                      )),
                )
              : _DegreeWidget(
                  degree: degree,
                  totalPoints: totalPoints,
                  isPrimary: isPrimary,
                ),
          if (childLevel != null) AppSize.s40.sizedBoxHeight,
          if (childLevel != null)
            _TitleAssignment(
              title: 'مستواك: $childLevel',
              isPrimary: isPrimary,
            ),
          // if (description != null) AppSize.s20.sizedBoxHeight,
          // if (description != null)
          //   _DescriptionWidget(
          //     description: description ?? [],
          //     isPrimary: isPrimary,
          //   ),
          AppSize.s40.sizedBoxHeight,
          if (description != null && description!.isNotEmpty) ...[
            _TitleAssignment(
              title: isPrimary ? AppStrings.greatAdvice : AppStrings.recommendations,
              isPrimary: isPrimary,
            ),
            AppSize.s20.sizedBoxHeight,
            SizedBox(
              width: AppReference.deviceIsTablet
                  ? AppReference.deviceWidth(context) * .4
                  : AppReference.deviceWidth(context),

              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return AppSize.s10.sizedBoxHeight;
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: description!.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: AppReference.deviceHeight(context) * 0.08.responsiveHeightRatio,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: AppSize.s12.responsiveSize,
                            backgroundColor: isPrimary
                                ? AppColors.successColor
                                : AppColors.white,
                            child: Text(
                              "${index + 1}",
                              style: const AppTextStyle().white.s16.titleMedium20.copyWith(
                                color: isPrimary? AppColors.white : AppColors.black,
                              ),
                            ),
                          ),
                          AppSize.s10.sizedBoxWidth,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p20.responsiveSize),
                              decoration: BoxDecoration(
                                color: isPrimary
                                    ? AppColors.primaryColor2
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(AppConstants
                                    .appBorderRadiusR15.responsiveSize),
                                border: Border.all(color: AppColors.textColor6),
                              ),
                              child: Center(
                                child: Text(
                                  description![index],
                                  style: const AppTextStyle()
                                      .s16
                                      .bodyLarge16
                                      .copyWith(
                                        color: isPrimary
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppReference.deviceWidth(context) * .4,
            child: Column(
              children: [
                _TitleAssignment(
                  title: AppStrings.degreeOfAssignment,
                  isPrimary: isPrimary,
                ),
                AppSize.s20.sizedBoxHeight,
                isPrimary
                    ? CustomPaint(
                        size: Size(
                            AppReference.deviceWidth(context),
                            (AppReference.deviceWidth(context) *
                                    0.8312236286919831)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: DegreeViewCustomPainter(),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical:
                                    AppReference.deviceIsTablet ? 40 : 100),
                            child: Text(
                              "$degree/$totalPoints",
                              style: const AppTextStyle()
                                  .balooBhaijaan2
                                  .w700
                                  .s50
                                  .displayLarge32
                                  .copyWith(color: AppColors.successColor),
                            )),
                      )
                    : _DegreeWidget(
                        degree: degree,
                        totalPoints: totalPoints,
                        isPrimary: isPrimary,
                      ),
                if (childLevel != null) AppSize.s50.sizedBoxHeight,
                if (childLevel != null)
                  _TitleAssignment(
                    title: 'مستواك: $childLevel',
                    isPrimary: isPrimary,
                  ),
                if (description != null) AppSize.s20.sizedBoxHeight,
                // if (description != null)
                //   _DescriptionWidget(
                //     description: description ?? [],
                //     isPrimary: isPrimary,
                //   ),
              ],
            ),
          ),
          AppSize.s50.sizedBoxHeight,
          SizedBox(
            width: AppReference.deviceWidth(context) * .4,
            child: Column(
              children: [
                _TitleAssignment(
                  title: isPrimary ? AppStrings.greatAdvice : AppStrings.recommendations,
                  isPrimary: isPrimary,
                ),
                AppSize.s20.sizedBoxHeight,
                SizedBox(
                  width: AppReference.deviceIsTablet
                      ? AppReference.deviceWidth(context) * .4
                      : AppReference.deviceWidth(context),
                  child:ListView.separated(
                      separatorBuilder: (context, index) {
                        return AppSize.s10.sizedBoxHeight;
                      },
                      shrinkWrap: true,
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: description!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: AppSize.s12.responsiveSize,
                              backgroundColor: isPrimary
                                  ? AppColors.successColor
                                  : AppColors.white,
                              child: Text(
                                "${index + 1}",
                                style: const AppTextStyle().white.s16.titleMedium20,
                              ),
                            ),
                            AppSize.s10.sizedBoxWidth,
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p20.responsiveSize),
                                height: AppSize.s50.responsiveHeight,
                                decoration: BoxDecoration(
                                  color: isPrimary
                                      ? AppColors.primaryColor2
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(AppConstants
                                      .appBorderRadiusR15.responsiveSize),
                                  border: Border.all(color: AppColors.textColor4),
                                ),
                                child: Center(
                                  child: Text(
                                    description![index],
                                    style: const AppTextStyle()
                                        .s16
                                        .bodyLarge16
                                        .copyWith(
                                      color: isPrimary
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DegreeWidget extends StatelessWidget {
  const _DegreeWidget({
    required this.degree,
    required this.totalPoints,
    this.isPrimary = false,
  });

  final int? degree;
  final int totalPoints;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AppReference.deviceWidth(context) * 0.5,
      height:AppReference.deviceHeight(context) * 0.1.responsiveHeightRatio,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: isPrimary ? 10.responsiveWidth : 2.responsiveWidth,
            color: isPrimary ? AppColors.primaryColor2 : AppColors.textColor6,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: FittedBox(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: '${degree ?? ''}/',
              style: AppReference.themeData.textTheme.titleSmall!.copyWith(
                fontSize: AppFontSize.sp30.responsiveFontSize,
                fontWeight: FontWeight.w700,
                color: isPrimary
                    ? AppColors.secondaryColor2
                    : AppColors.primaryColor2,
              ),
              children: [
                TextSpan(
                  text: '$totalPoints',
                  style: AppReference.themeData.textTheme.titleSmall!.copyWith(
                    fontSize: AppFontSize.sp30.responsiveFontSize,
                    fontWeight: FontWeight.w500,
                    color: isPrimary
                        ? AppColors.secondaryColor2
                        : AppColors.primaryColor2,
                  ),
                ),
              ]),
        ),
      ),
    ).animateFlipHorizontal();
  }
}

class _TitleAssignment extends StatelessWidget {
  final String title;
  final bool isPrimary;

  const _TitleAssignment({
    required this.title,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: isPrimary
                ? const AppTextStyle()
                    .balooBhaijaan2
                    .w700
                    .bodyMedium14
                    .copyWith(
                      color: AppColors.secondaryColor4,
                    )
                : AppReference.themeData.textTheme.bodyLarge,
          ),
          Divider(
            color: isPrimary ? AppColors.secondaryColor4 : AppColors.primary2,
            thickness: 3.responsiveSize,
            endIndent: 250.responsiveWidth,
          ),
        ],
      ),
    );
  }
}

