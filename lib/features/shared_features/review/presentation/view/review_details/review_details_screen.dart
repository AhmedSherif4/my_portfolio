import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/shared_features/review/domain/entity/review_entity_outputs.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_bloc.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_event.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_state.dart';
import '../../../../../../config/resources/app_assets.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_text_style.dart';
import '../../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../../core/shared_widget/custom_inkwell.dart';
import '../../../../../../my_app/app_reference.dart';
import '../../../../../child_flow/home/home.dart';
import '../../../../more/presentation/more_widgets/header_for_more.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const RatingDialog(
              message: "",
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderForMore(
                title: "التقييمات",
              ).paddingBody(),
              BlocConsumer<ReviewBloc, ReviewState>(
                listener: (context, state) {

                  switch(state.deleteReviewState) {
                    case RequestStates.loading:
                      showLoadingDialog(context);
                      break;
                    case RequestStates.loaded:
                      RouteManager.rPopRoute(context);
                      context.read<ReviewBloc>().add(
                        GetAllReviewDataEvent(),
                      );
                      showSnackBar(
                          description: state.deleteReviewMessage,
                          state: ToastStates.congrats,
                          context: context);
                      break;
                    case RequestStates.error:
                      RouteManager.rPopRoute(context);
                      showSnackBar(
                          description: state.deleteReviewMessage,
                          state: ToastStates.error,
                          context: context);
                      break;
                    default:
                  }
                },
                builder: (context, state) {
                  switch (state.reviewsState) {
                    case RequestStates.loading:
                      return const LoadingShimmerList();
                    case RequestStates.loaded:
                      return state.reviews.isEmpty?Column(
                        children: [
                          200.sizedBoxHeight,
                          const EmptyListWidgets(message: "لا يوجد تقييمات"),
                        ],
                      ):ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.reviews.length,
                        separatorBuilder: (context, index) =>
                        AppSize.s10.sizedBoxHeight,
                        itemBuilder: (context, index) {
                          return CustomInkWell(
                            onTap: () {
                              RouteManager.rPushReplacementNamed(
                                  context: context,
                                  rName: AppRoutesNames.rReviewDetailsScreen,
                                  arguments: state.reviews[index]);
                            },
                            child: ReviewItem(
                              reviewEntityOutputs: state.reviews[index],
                            ),
                          );
                        },
                      );
                    case RequestStates.error:
                      return ErrorWidget(state.viewReviewMessage);

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final ReviewEntityOutputs reviewEntityOutputs;

  const ReviewItem({super.key, required this.reviewEntityOutputs});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(AppPadding.p10.responsiveSize),
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.p16.responsiveSize,
              horizontal: AppPadding.p30.responsiveSize),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s14),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: -8,
                  blurRadius: 11,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewEntityOutputs.reviewText!,
                      style: const AppTextStyle()
                          .balooBhaijaan2
                          .w500
                          .bodyMedium14
                          .copyWith(
                        fontSize: AppReference.deviceIsTablet
                            ? AppFontSize.sp14.responsiveFontSize
                            : AppFontSize.sp14.responsiveFontSize,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSize.s6.sizedBoxHeight,
                    Text(
                      reviewEntityOutputs.createdAt.toString(),
                      style: const AppTextStyle()
                          .balooBhaijaan2
                          .w400
                          .bodySmall12
                          .copyWith(
                        fontSize: AppFontSize.sp10.responsiveFontSize,
                        color: AppColors.textColor4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSize.s6.sizedBoxHeight,
                    RatingBar.builder(
                      ignoreGestures: true,
                      allowHalfRating: false,
                      initialRating: reviewEntityOutputs.starsNum!.toDouble(),
                      maxRating: 5,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemSize: AppSize.s16.responsiveSize,
                      direction: Axis.horizontal,
                      itemBuilder: (context, _) =>
                          SvgPicture.asset(AppIconsAssets.sRatingStarFill),
                      onRatingUpdate: (value){},
                    ),
                  ],
                ),
              ),
              AppSize.s16.sizedBoxWidth,
              Column(
                children: [
                  CustomInkWell(
                    onTap: () {
                      context.read<ReviewBloc>().add(DeleteReviewDataEvent(
                          reviewID: reviewEntityOutputs.id));
                    },
                    child: SvgPicture.asset(
                      AppIconsAssets.sDeleteNotification,
                      width: !AppReference.isPortrait(context)
                          ? AppSize.s40.responsiveWidth
                          : AppSize.s28.responsiveWidth,
                      height: !AppReference.isPortrait(context)
                          ? AppSize.s40.responsiveHeight
                          : AppSize.s28.responsiveHeight,
                    ),
                  ),
                  AppSize.s16.sizedBoxHeight,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                    size: AppSize.s16.responsiveSize,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}