
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/base_widgets/loading_shimmer_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_bloc.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_event.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_state.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_text_style.dart';


class ShowChildParentOtherSide extends StatelessWidget {
  const ShowChildParentOtherSide({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => getIt<MoreBloc>()..add(GetScreens()),
  child: Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<MoreBloc, MoreState>(
        builder: (context, state) {
          return switch (state.getScreenState) {
            RequestStates.loaded =>
                CustomInkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppReference.userIsChild()
                                ? AppStrings.watchAsParent
                                : AppStrings.watchAsChild,
                            style: AppTextStyle.titleMedium20.copyWith(
                                fontWeight: AppFontWeight.semiBoldW600,
                                color: AppColors.white),
                          ),
                          //ToDo : add this section
                          // AppSize.s20.sizedBoxHeight,
                          // Text("اسم الاسكرين",style:
                          // AppTextStyle.bodyLarge16.copyWith(
                          //     fontWeight: AppFontWeight.semiBoldW600,
                          //     color: AppColors.white),),
                          AppSize.s20.sizedBoxHeight,
                          CarouselDemo(
                            parentOtherSideList: state.parentScreens,
                            childOtherSideList: state.childScreens,
                          ).paddingBody(
                            start: AppPadding.p24.responsiveSize,
                            end: AppPadding.p24.responsiveSize,
                          )
                        ]),
                  ),
                ),
              ),
            RequestStates.loading => const LoadingView(),
            RequestStates.error => Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('برجاء المحاولة في وقت لاحق',style: const AppTextStyle().white.titleSmall18,)),
                const TextBackButton(),
              ],
            )),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    ),
);
  }
}

class CarouselDemo extends StatefulWidget {
  final List<String> parentOtherSideList;
  final List<String> childOtherSideList;
  const CarouselDemo({
    super.key,
    required this.parentOtherSideList,
    required this.childOtherSideList,
  });

  @override
  State<StatefulWidget> createState() {
    return _CarouselDemoState();
  }
}

var current = 0;

class _CarouselDemoState extends State<CarouselDemo> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
// ToDo: Refactor this part

    return CarouselSlider.builder(
      itemCount:  AppReference.userIsChild()
          ? widget.parentOtherSideList.length
          : widget.childOtherSideList.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        width: AppReference.deviceWidth(context) / 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20),
          color: AppColors.white,
        ),
        child: NullableNetworkImage(
          imagePath: AppReference.userIsChild()
              ? widget.parentOtherSideList[itemIndex]
              : widget.childOtherSideList[itemIndex],
          fit: BoxFit.fill,
          notHaveImage: false,
        ),
      ),
      carouselController: _controller,
      options: CarouselOptions(
          autoPlay: false,
          viewportFraction: 250 / 400,
          enlargeCenterPage: true,
          padEnds: true,
          aspectRatio: 2.5 / 3.5,
          onPageChanged: (index, reason) {
            setState(() {
              current = index;
            });
          }),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppReference.userIsChild()
                  ? AppStrings.watchAsParent
                  : AppStrings.watchAsChild,
              style: AppTextStyle.titleMedium20.copyWith(
                  fontWeight: AppFontWeight.semiBoldW600,
                  color: AppColors.white),
            ),
            AppSize.s20.sizedBoxHeight,
            CarouselSlider.builder(
              itemCount:  3,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    width: AppReference.deviceWidth(context) / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20),
                      color: AppColors.white,
                    ),
                    child: LoadingShimmerStructure(
                      height: 10.0.responsiveHeight,
                    ),
                  ),
              //child: Image.asset("assets/images/child_flow_images/1.png"),
              carouselController: CarouselSliderController(),
              options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 250 / 400,
                  enlargeCenterPage: true,
                  padEnds: true,
                  aspectRatio: 2.5 / 3.5,
                  onPageChanged: (index, reason) {
                  }),
            ).paddingBody(
              start: AppPadding.p24.responsiveSize,
              end: AppPadding.p24.responsiveSize,
            )
          ]),
    );
  }
}
