import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_questions_data.dart';
import 'package:my_portfolio/features/shared_features/child_subscriptions/data/models/data_go_to_subscriptions_ques.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/routes/route_manager.dart';
import '../../../../../../config/routes/routes_names.dart';
import '../../../../../../core/services/services_locator.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../child_flow/exams/exams/data_to_go_exams.dart';
import '../../../more/presentation/more_widgets/header_for_more.dart';

class LessonOrExamsScreen extends StatefulWidget {
  final DataToGoQuestions data;

  const LessonOrExamsScreen({super.key, required this.data});

  @override
  State<LessonOrExamsScreen> createState() => _LessonOrExamsScreenState();
}

class _LessonOrExamsScreenState extends State<LessonOrExamsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          RouteManager.rPushNamedAndRemoveUntil(
            context: context,
            rName: AppRoutesNames.rSubscriptionsSubjectsScreen,
            arguments: DataGoToSubscriptionsQuestions(
              systemId: widget.data.systemId,
              stageId: widget.data.stageId,
              classRoomId: widget.data.classRoomId,
              termId: widget.data.termId,
              pathId: widget.data.pathId,
            ),
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderForMore(
                    title: widget.data.subjectName,
                    onBack: () {
                      RouteManager.rPushNamedAndRemoveUntil(
                        context: context,
                        rName: AppRoutesNames.rSubscriptionsSubjectsScreen,
                        arguments: DataGoToSubscriptionsQuestions(
                          systemId: widget.data.systemId,
                          stageId: widget.data.stageId,
                          classRoomId: widget.data.classRoomId,
                          termId: widget.data.termId,
                          pathId: widget.data.pathId,
                        ),
                      );
                    }),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.subjectName,
                        textAlign: TextAlign.center,
                        style: AppReference.themeData.textTheme.titleMedium,
                      ),
                    ),
                    Expanded(
                      child: NullableNetworkImage(
                        imagePath: widget.data.imgUrl,
                        notHaveImage: widget.data.imgUrl.isEmpty,
                        width: 200,
                        height: 120.responsiveHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                20.sizedBoxHeight,
                CustomInkWell(
                  onTap: () {
                    RouteManager.rPushNamedAndRemoveUntil(
                      context: context,
                      rName: AppRoutesNames.rLessonScreen,
                      arguments: widget.data,
                    );
                  },
                  child: const CardSubscriptionsWidget(
                    title: AppStrings.myLessons,
                    subtitle:
                        "استمتع بمجموعات من الأسئلة والاختبارات في كل درس مع مراجعة نهائية رائعة!",
                    imagePath: AppImagesAssets.sBook,
                  ),
                ),
                30.sizedBoxHeight,
                GestureDetector(
                  onTap: () {
                    final userData = getIt<UserLocalDataSource>().getUserData();

                    RouteManager.rPushNamed(
                      context: context,
                      rName: widget.data.isPrimary
                          ? AppRoutesNames.rPrimaryChildChallengeScreen
                          : AppRoutesNames.rChildChallengeScreen,
                      arguments: DataToGoExams(
                        subjects: widget.data.subjects,
                        user: userData!,
                        isPrimary: widget.data.isPrimary,
                        termId: widget.data.termId,
                        pathId: widget.data.pathId,
                        fromSubscription: true,
                        dataToGoQuestions: widget.data,
                      ),
                    );
                  },
                  child: const CardSubscriptionsWidget(
                    title: 'التحديات',
                    subtitle: AppStrings.enjoySubjects,
                    imagePath: AppImagesAssets.sBike,
                  ),
                ),
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }
}

class CardSubscriptionsWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? price;
  final String? priceBeforeDiscount;
  final String? imagePath;

  const CardSubscriptionsWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.price,
    this.priceBeforeDiscount,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.responsiveSize),
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      width: double.infinity,
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: constraints.maxWidth * 0.8,
              padding: EdgeInsets.all(10.responsiveSize),
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.responsiveSize),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          title,
                          style: const AppTextStyle().gray.w600.bodyLarge16,
                        ),
                        Text(
                          subtitle,
                          style: const AppTextStyle().gray.w500.s10.bodySmall12,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (price != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${price!} ريال',
                                style: const AppTextStyle()
                                    .w500
                                    .orange
                                    .bodySmall12,
                              ),
                              if (priceBeforeDiscount != null)
                                Text(
                                  '$priceBeforeDiscount',
                                  style: const AppTextStyle()
                                      .w500
                                      .bodyLarge16
                                      .copyWith(
                                        color: AppColors.secondaryColor4,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            AppColors.secondaryColor4,
                                      ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    imagePath == null
                        ? AppIconsAssets.sCardSubscriptions3
                        : imagePath!,
                    width: constraints.maxWidth * 0.3,
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              AppIconsAssets.sBlueCircleBack,
              height: constraints.maxHeight * 0.2,
            ),
          ],
        );
      }),
    );
  }
}
