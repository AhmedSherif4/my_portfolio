import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/features/home/view_model/home_cubit.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import 'package:my_portfolio/my_app/splash/presentation/components/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/app_colors.dart';
import '../../../config/resources/app_constants.dart';
import '../../../config/responsive/responsive_text_widget.dart';
import '../../../config/responsive/responsive_widget.dart';
import '../../list_projects/widgets/list_projects.dart';
import '../components/app_bar.dart';
import '../components/article_widget.dart';
import '../components/custom_bottom_app_bar.dart';
import '../components/dividerWidget.dart';
import '../components/lottie_widget.dart';
import '../components/youtube_view.dart';
import '../data/cosnt_data.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  void initState() {
    final HomeCubit homeCubit = context.read<HomeCubit>();

    super.initState();
    homeCubit.scrollController.addListener(homeCubit.scrollListener);
  }

  // @override
  // void dispose() {
  //   final HomeCubit homeCubit = context.read<HomeCubit>();
  //   homeCubit.scrollController.removeListener(homeCubit.scrollListener);
  //   homeCubit.scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: homeCubit.scrollController,
              child: Column(
                children: [
                  const CustomAppBarWidget(),
                  ResponsiveDisplayLargeAnimatedWidget(
                    label: AppStrings.welcome.tr(),
                  ).paddingBody().animateBottomToTop(
                      isFromBottom: false,
                      duration: const Duration(seconds: 2)),
                  ResponsiveBodyMediumAnimatedWidget(
                          key: ConstData.sectionsOfHome[AppStrings.about],
                          label: 'Software Engineer specializing in Flutter')
                      .paddingBody()
                      .animateBottomToTop(duration: const Duration(seconds: 2)),
                  30.responsiveHeight.sizedBoxHeight,
                  ResponsiveWidgetForTablet(
                    mobile: Column(
                      children: [
                        const DividerWidget(
                          isVertical: false,
                        ),
                        30.responsiveHeight.sizedBoxHeight,
                        Container(
                          height: AppReference.deviceHeight(context) * 0.5,
                          width: AppReference.deviceWidth(context) * 0.5,
                          decoration: AppConstants.containerDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                AppConstants.appBorderRadiusR10),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              AppImagesAssets.pMe,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ).animateRightLeft(
                            isFromStart: context.locale.languageCode == 'ar'
                                ? true
                                : false),
                        30.responsiveHeight.sizedBoxHeight,
                        Text(
                          AppStrings.aLittleAboutMe.tr(),
                          style: const AppTextStyle().titleMedium26w5.copyWith(
                              fontFamily: AppTextStyle.playfairDisplay),
                        ),
                        20.responsiveHeight.sizedBoxHeight,
                        Text(
                          AppStrings.descriptionALittleAboutMe.tr(),
                          style: const AppTextStyle().labelMedium14w5,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    tablet: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: AppReference.deviceHeight(context) * 0.5,
                            width: 300,
                            decoration: AppConstants.containerDecoration(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppConstants.appBorderRadiusR10),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                AppImagesAssets.pMe,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ).animateRightLeft(
                            isFromStart: context.locale.languageCode == 'ar'
                                ? true
                                : false),
                        const DividerWidget(
                          isVertical: true,
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                AppStrings.aLittleAboutMe.tr(),
                                style: const AppTextStyle()
                                    .titleMedium26w5
                                    .copyWith(
                                        fontFamily:
                                            AppTextStyle.playfairDisplay),
                              ),
                              Text(
                                AppStrings.descriptionALittleAboutMe.tr(),
                                style: const AppTextStyle().labelMedium14w5,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).paddingBody(),
                  60.responsiveHeight.sizedBoxHeight,
                  const DividerWidget(
                    isVertical: false,
                  ),
                  150.responsiveHeight.sizedBoxHeight,
                  ResponsiveWidgetForTablet(
                    key: ConstData.sectionsOfHome[AppStrings.skills],
                    mobile: Column(
                      children: [
                        Text(
                          AppStrings.someTechnologiesIveWorkedUpon.tr(),
                          style: const AppTextStyle().titleMedium26w5.copyWith(
                              fontFamily: AppTextStyle.playfairDisplay),
                        ),
                        30.responsiveHeight.sizedBoxHeight,
                        GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 40,
                                  crossAxisSpacing: 40),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            ConstData.listOfIconsTechnologies.length,
                            (index) => Container(
                              padding: EdgeInsets.only(left: 5.responsiveSize),
                              child: Image.asset(
                                ConstData.listOfIconsTechnologies[index],
                                height: 100.responsiveHeight,
                              ),
                            ),
                          ),
                        ),
                        10.responsiveWidth.sizedBoxWidth,
                        Text(
                          AppStrings.somePrinciplesArchitecturesIveWorkedBy
                              .tr(),
                          style: const AppTextStyle().titleMedium26w5.copyWith(
                              fontFamily: AppTextStyle.playfairDisplay),
                        ),
                        30.responsiveHeight.sizedBoxHeight,
                        GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3 / 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            ConstData.listOfPrinciplesArchitectures.length,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10.responsiveSize),
                              decoration: AppConstants.containerDecoration(
                                backgroundColor:
                                    AppColors.primaryColor4(context),
                              ),
                              padding: EdgeInsets.all(5.responsiveSize),
                              child: Text(
                                ConstData.listOfPrinciplesArchitectures[index],
                                style: const AppTextStyle()
                                    .labelSmall12w5
                                    .copyWith(
                                        color:
                                            AppColors.backgroundColor(context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).paddingBody(),
                    tablet: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                AppStrings.someTechnologiesIveWorkedUpon.tr(),
                                style: const AppTextStyle()
                                    .titleMedium26w5
                                    .copyWith(
                                        fontFamily:
                                            AppTextStyle.playfairDisplay),
                              ),
                              30.responsiveHeight.sizedBoxHeight,
                              GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 40,
                                        crossAxisSpacing: 40),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  ConstData.listOfIconsTechnologies.length,
                                  (index) => Container(
                                    padding:
                                        EdgeInsets.only(left: 5.responsiveSize),
                                    child: Image.asset(
                                      ConstData.listOfIconsTechnologies[index],
                                      height: 100.responsiveHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.responsiveWidth.sizedBoxWidth,
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                AppStrings
                                    .somePrinciplesArchitecturesIveWorkedBy
                                    .tr(),
                                style: const AppTextStyle()
                                    .titleMedium26w5
                                    .copyWith(
                                        fontFamily:
                                            AppTextStyle.playfairDisplay),
                              ),
                              30.responsiveHeight.sizedBoxHeight,
                              GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 3 / 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  ConstData
                                      .listOfPrinciplesArchitectures.length,
                                  (index) => Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10.responsiveSize),
                                    decoration:
                                        AppConstants.containerDecoration(
                                      backgroundColor:
                                          AppColors.primaryColor4(context),
                                    ),
                                    padding: EdgeInsets.all(5.responsiveSize),
                                    child: Text(
                                      ConstData
                                          .listOfPrinciplesArchitectures[index],
                                      style: const AppTextStyle()
                                          .labelSmall12w5
                                          .copyWith(
                                              color: AppColors.backgroundColor(
                                                  context)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).paddingBody(),
                  ),
                  60.responsiveHeight.sizedBoxHeight,
                  const DividerWidget(
                    isVertical: false,
                  ),
                  150.responsiveHeight.sizedBoxHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ResponsiveDisplayLargeAnimatedWidget(
                        key: ConstData.sectionsOfHome[AppStrings.projects],
                        label: AppStrings.myPreviousProjects.tr()),
                  ),
                  const ProjectsShowWidget(),
                  const DividerWidget(
                    isVertical: false,
                  ),
                  150.responsiveHeight.sizedBoxHeight,
                  Align(
                    key: ConstData.sectionsOfHome[AppStrings.articles],
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      AppStrings.article.tr(),
                      style: const AppTextStyle()
                          .displayMedium38w4
                          .copyWith(fontFamily: AppTextStyle.playfairDisplay),
                    ),
                  ).paddingBody(),
                  ResponsiveWidgetForTablet(
                    mobile: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ArticleWidget(
                          onTap: _catchDataInFlutterLaunch,
                          imageAssert: AppImagesAssets.pCatchDataInFlutter,
                          title:
                              '📂 Easiest way to Cache data in Flutter: A Step-by-Step Guide',
                          description:
                              'Are you looking to optimize your Flutter app’s data fetching process while minimizing server requests and enhancing the user experience, even when offline? Look no further! In this blog post, I’ll walk you through an easy and efficient way to cache data from an API and save it locally with an expiration date using Flutter.',
                        ),
                        ArticleWidget(
                          onTap: _paginationLaunch,
                          imageAssert: AppImagesAssets.pPagination,
                          title:
                              '🚀📝Implementing Pagination using BLoC and Clean Architecture',
                          description:
                              'Are you looking to improve the performance of your Flutter app with pagination and caching while following clean architecture principles and using BLoC state management? Look no further! In this blog post, we’ll dive into a powerful Flutter code snippet that incorporates clean architecture and BLoC to handle pagination in lists and efficiently manage data caching. Let’s explore the code in detail:',
                        ),
                      ],
                    ),
                    tablet: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ArticleWidget(
                          onTap: _catchDataInFlutterLaunch,
                          imageAssert: AppImagesAssets.pCatchDataInFlutter,
                          title:
                              '📂 Easiest way to Cache data in Flutter: A Step-by-Step Guide',
                          description:
                              'Are you looking to optimize your Flutter app’s data fetching process while minimizing server requests and enhancing the user experience, even when offline? Look no further! In this blog post, I’ll walk you through an easy and efficient way to cache data from an API and save it locally with an expiration date using Flutter.',
                        ),
                        ArticleWidget(
                          onTap: _paginationLaunch,
                          imageAssert: AppImagesAssets.pPagination,
                          title:
                              '🚀📝Implementing Pagination using BLoC and Clean Architecture',
                          description:
                              'Are you looking to improve the performance of your Flutter app with pagination and caching while following clean architecture principles and using BLoC state management? Look no further! In this blog post, we’ll dive into a powerful Flutter code snippet that incorporates clean architecture and BLoC to handle pagination in lists and efficiently manage data caching. Let’s explore the code in detail:',
                        ),
                      ],
                    ),
                  ),
                  60.responsiveHeight.sizedBoxHeight,
                  const DividerWidget(
                    isVertical: false,
                  ),
                  150.responsiveHeight.sizedBoxHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ResponsiveDisplayLargeAnimatedWidget(
                        key: ConstData.sectionsOfHome[AppStrings.lectures],
                        label: AppStrings.oneOfMyLectures.tr()),
                  ),
                  const YoutubeViewWidget(),
                  SizedBox(
                    width: AppReference.deviceWidth(context) * 0.7,
                    child: DefaultButtonWidget(
                      label: AppStrings.visitMyChannel.tr(),
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://www.youtube.com/@ahmedsherif948');
                        await launchUrl(url);
                      },
                      isExpanded: false,
                      labelColor: AppColors.primaryColor4(context),
                    ),
                  ),
                  60.responsiveHeight.sizedBoxHeight,
                  const DividerWidget(
                    isVertical: false,
                  ),
                  60.responsiveHeight.sizedBoxHeight,
                  ChatIconLottieWidget(
                    key: ConstData.sectionsOfHome[AppStrings.contact],
                  ),
                  ResponsiveDisplayLargeAnimatedWidget(
                      label: AppStrings.getInTouch.tr()),
                  ResponsiveBodyMediumAnimatedWidget(
                    label: AppStrings.getInTouchDescription.tr(),
                    isCentered: true,
                  ),
                  const CustomBottomAppBar(),
                ],
              ),
            ),
            Positioned(
              width: AppReference.deviceWidth(context),
              top: 5,
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  ...ConstData.sectionsOfHome.entries.map(
                    (e) => Container(
                      decoration: AppConstants.containerDecoration(
                          backgroundColor: AppColors.darkColor3),
                      margin: EdgeInsets.all(5.responsiveSize),
                      padding: EdgeInsets.all(10.responsiveSize),
                      child: GestureDetector(
                        onTap: () => homeCubit.scrollToSection(e.value),
                        child: Text(
                          e.key.tr(),
                          style: const AppTextStyle()
                              .labelMedium14w5
                              .copyWith(color: AppColors.darkColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: context.watch<HomeCubit>().state.showTopButton
          ? FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColors.darkColor3,
              onPressed: homeCubit.scrollToTop,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  void _catchDataInFlutterLaunch() async {
    Uri url = Uri.parse(
        'https://medium.com/@ahmedsherif4175/easiest-way-to-cache-data-in-flutter-a-step-by-step-guide-7e983d64198b');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  void _paginationLaunch() async {
    Uri url = Uri.parse(
        'https://medium.com/@ahmedsherif4175/implementing-pagination-using-bloc-and-clean-architecture-3828f3030d62');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Welcome',
          style: const AppTextStyle()
              .displayLarge40w4
              .copyWith(fontFamily: AppTextStyle.playfairDisplay),
        ),
      ),
    );
  }
}
