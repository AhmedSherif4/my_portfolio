part of '../../quran.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                height: AppReference.deviceHeight(context),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppReference.deviceIsTablet&&!AppReference.isPortrait(context)
                            ? AppImagesAssets.pQuranForTabletBg
                            : AppImagesAssets.pQuranForMobileBg),
                        fit: BoxFit.fill)),
                child: ResponsiveWidgetForTablet(
                  mobile: const _HomeQuranScreenPortraitView(),
                  tablet: OrientationItem(
                    portraitWidget:  const _HomeQuranScreenPortraitView(),
                    landscapeWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const _GoToQuranWithSuruhSortCard(),
                        AppSize.s20.sizedBoxHeight,
                       const _GoToQuranWithJuzSortCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeQuranScreenPortraitView extends StatelessWidget {
  const _HomeQuranScreenPortraitView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _GoToQuranWithSuruhSortCard(),
        AppSize.s20.sizedBoxHeight,
        const _GoToQuranWithJuzSortCard(),
      ],
    );
  }
}

class _GoToQuranWithJuzSortCard extends StatelessWidget {
  const _GoToQuranWithJuzSortCard();

  @override
  Widget build(BuildContext context) {
    return _CardWidget(
      icon: AppIconsAssets.sJuzSort,
      title: 'المصحف بترتيب الأجزاء',
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rJuzScreen,
        );
      },
    );
  }
}

class _GoToQuranWithSuruhSortCard extends StatelessWidget {
  const _GoToQuranWithSuruhSortCard();

  @override
  Widget build(BuildContext context) {
    return _CardWidget(
      icon: AppIconsAssets.sSuruhSort,
      title: 'المصحف بترتيب السور',
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rSurahScreen,
          arguments: TypeOfSelection.surah,
        );
      },
    );
  }
}

class _CardWidget extends StatelessWidget {
  final String title, icon;
  final VoidCallback onTap;

  const _CardWidget({
    required this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width:AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceWidth(context) * 0.3: AppReference.deviceWidth(context) * 0.7,
        height: AppReference.deviceHeight(context) * 0.17.responsiveHeightRatio,
        margin: EdgeInsets.only(right: 10.responsiveWidth),
        padding: EdgeInsets.all(7.responsiveSize),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.quranColor.withOpacity(0.2),
          border: Border.all(
            color: AppColors.quranColor,
            width: 1.responsiveSize,
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(0),
            topRight: Radius.circular(22.responsiveSize),
            bottomLeft: Radius.circular(22.responsiveSize),
            bottomRight: const Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              icon,
              width: 50.responsiveWidth,
              height: 50.responsiveHeight,
              fit: BoxFit.contain,
            ),
            AppSize.s10.sizedBoxWidth,
            Expanded(
              child: Text(
                title,
                style: AppReference.themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.secondaryColor4,
                ),
              ),
            ),
            AppSize.s10.sizedBoxWidth,
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.secondaryColor4,
              size: AppSize.s12.responsiveSize,
            ),
          ],
        ),
      ),
    );
  }
}
