part of '../../rank.dart';


class RankItemWidget extends StatelessWidget {
  final int rank;
  final int pointCount;
  final String name;

  final Color rankColor;
  final Color rankColorLabel;

  const RankItemWidget({
    super.key,
    required this.rank,
    required this.pointCount,
    required this.name,
    required this.rankColor,
    required this.rankColorLabel,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          children: [
            Container(
              width: constrains.maxWidth,
              height: constrains.maxHeight,
              padding: EdgeInsets.symmetric(
                horizontal: 10.responsiveWidth,
                vertical: 7.responsiveHeight,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.responsiveSize),
                color: rankColor,
              ),
              child: Row(
                children: [
                  FittedBox(
                    child: Text(
                      '$rank',
                      style:
                      AppReference.themeData.textTheme.displayMedium!.copyWith(
                        color: rankColorLabel,
                      ),
                    ),
                  ),
                  AppSize.s10.sizedBoxWidth,
                  SvgPicture.asset(AppImagesAssets.sMedalWinner),
                  AppSize.s10.sizedBoxWidth,
                  Text(
                    name,
                    style:
                    AppReference.themeData.textTheme.displaySmall!.copyWith(
                      color: rankColorLabel,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: constrains.maxWidth * 0.22,
                    height: constrains.maxHeight,
                    child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        PositionedDirectional(
                          end: 0,
                          child: Container(
                            width: constrains.maxWidth * 0.2,
                            height: constrains.maxHeight * 0.65,
                            alignment: AlignmentDirectional.centerEnd,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.responsiveWidth),
                            decoration: BoxDecoration(
                              // color: const Color(0xffFAE7BC),
                                color: const Color(0xffFAE7BC),
                                //color: Colors.yellowAccent.withOpacity(.3),
                                borderRadius:
                                BorderRadius.circular(20.responsiveSize)),
                            child: FittedBox(
                                child: Text(
                                  '$pointCount',
                                  style: const AppTextStyle().w700.bodyLarge16.copyWith(
                                      color: AppColors.primaryColor2
                                  ),
                                )),
                          ),
                        ),
                        PositionedDirectional(
                          start: 0,
                          child: SvgPicture.asset(
                            AppImagesAssets.sRankIcon,
                            height: constrains.maxHeight * 0.65,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}