part of '../../quran.dart';

class JuzScreen extends StatelessWidget {
  const JuzScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: AppReference.deviceHeight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppReference.deviceIsTablet&&!AppReference.isPortrait(context)
                  ? AppImagesAssets.pQuranForTabletBg
                  : AppImagesAssets.pQuranForMobileBg),
              fit: BoxFit.fill
          )),
        child:Column(
          children: [
            const HeaderForMore(
              title: 'أجزاء القرآن',
              textColor: AppColors.primaryColor,
            ),
            AppSize.s30.sizedBoxHeight,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      if (AppReference.deviceIsTablet&&!AppReference.isPortrait(context))...[
                        GridView.builder(
                            itemCount:StaticDataForQuran.quranJuzs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder:(context, index) =>  _JuzWidget(index),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 8/1.3,
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,)
                        ),

                      ],
                      if (!AppReference.deviceIsTablet||AppReference.deviceIsTablet&&AppReference.isPortrait(context))...[
                        // _filteredSurahs.isEmpty?SliverToBoxAdapter(child: EmptyListWidgets(message: "message")):
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _JuzWidget(index),
                          itemCount:StaticDataForQuran.quranJuzs.length,
                        ),
                      ]
                    ]
                ),
              ),
            ),
          ],
        ).paddingBody(),
      ),
    ));
  }
}

class _JuzWidget extends StatelessWidget {
  final int index;
  const _JuzWidget(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rQuranViewScreen,
          arguments: QuranParameter(
            typeOfSelection: TypeOfSelection.juz,
            selectionId: StaticDataForQuran.quranJuzs[index]['id'],
            selectionText: StaticDataForQuran.quranJuzs[index]['name'],
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.responsiveHeight,
          horizontal: AppPadding.p30.responsiveWidth,
        ),
        margin: EdgeInsets.symmetric(
          vertical: AppPadding.p16.responsiveHeight,
          horizontal: AppPadding.p16.responsiveWidth,
        ),
        width: AppReference.deviceWidth(context) * 0.7,
        decoration: BoxDecoration(
          color: AppColors.quranColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              StaticDataForQuran.quranJuzs[index]['name'],
              style: const AppTextStyle()
                  .quranFont
                  .orange
                  .bodyLarge16
                  .copyWith(color: AppColors.secondaryColor4),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSize.s16.responsiveSize,
              color: AppColors.secondaryColor4,
            ),
          ],
        ),
      ),
    );
  }
}
