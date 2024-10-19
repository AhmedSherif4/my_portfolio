part of '../../on_boarding.dart';
class LandScapeView extends StatelessWidget {
  final int pageCount;
  final bool isLast;
  final Function() nextOrLastOnTap;
  final Function(int) onPageChanged;
  final PageController pageController;
  final Function() backStep;

  const LandScapeView(
      {super.key,
        required this.pageCount,
        required this.isLast,
        required this.nextOrLastOnTap,
        required this.onPageChanged,
        required this.pageController,
        required this.backStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (AppReference.deviceHeight(context) * 0.05).sizedBoxHeight,
        SizedBox(
          height: AppReference.deviceHeight(context) * 0.1,
          child: AppBarWidget(
            backStep: backStep,
            pageCount: pageCount,
          ),
        ),
        SizedBox(
          height: AppReference.deviceHeight(context) * 0.65,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return
                  LayoutBuilder(builder: (context, constrains) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: constrains.maxWidth*.5,
                            child:LayoutBuilder(builder: (context, consColumn) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      // height: consColumn.maxHeight * 0.4,
                                      child: Center(child: TitleWidget(pageCount: pageCount))),
                                  SizedBox(
                                      height: consColumn.maxHeight * 0.6,
                                      child: SingleChildScrollView(
                                          child:
                                          DescriptionWidget(pageCount: pageCount))),
                                ],
                              );
                            })
                        ),

                        SizedBox(
                          width: constrains.maxWidth *.5,
                          height: constrains.maxHeight*.6,
                          child: SvgPicture.asset(
                            onBoardingPagesData[pageCount]['image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  });

          }),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            height: AppReference.deviceIsTablet?AppReference.deviceHeight(context) * 0.08:AppReference.deviceHeight(context) * 0.1,
            child: FittedBox(
              child: DefaultButtonWidget(
                width: AppReference.deviceIsTablet?AppReference.deviceWidth(context) * 0.2:AppSize.s50.responsiveWidth,
                // textFontSize: 30,
                label: isLast
                    ? AppStrings.registerNow
                    : AppStrings.next,
                onPressed: nextOrLastOnTap,
              ),
            ),
          ),
        ),


      ],
    ).paddingBody(
      top: 5.responsiveHeight,
      bottom: 0.responsiveHeight,
      start: 5.responsiveWidth,
      end: 5.responsiveWidth,
    );
  }
}
