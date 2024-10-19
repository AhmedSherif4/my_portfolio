import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/presentation/lessons_widgets/lesson_item.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/shared_functions/question_shared_funtion.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_constants.dart';
import '../../../../../../config/resources/app_values.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../shared/data/go_to_question_parameter.dart';
import '../../../shared/data/go_to_questions_data.dart';
import '../../lessons.dart';

class LessonBuilder extends StatefulWidget {
  final DataToGoQuestions data;

  const LessonBuilder({super.key, required this.data});

  @override
  State<LessonBuilder> createState() => _LessonBuilderState();
}

class _LessonBuilderState extends State<LessonBuilder> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        switch (state.getAllLessonsState) {
          case RequestStates.loading:
            return Expanded(
                child: LoadingShimmerList(
              height: 100.responsiveHeight,
            ));
          case RequestStates.loaded:
            if (widget.data.subjectsHaveUnits) {
              if (state.allLessonsByUnits.isNotEmpty) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _refreshLessonWithUnits(context);
                    },
                    child: AppReference.deviceIsTablet
                        ? MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemBuilder: (context, unitIndex) {
                              if (state.allLessonsByUnits[unitIndex].unitLessons
                                  .isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: AppColors.white,
                                          color: AppColors.secondaryColor,
                                          borderRadius: BorderRadius.circular(
                                              AppConstants.appBorderRadiusR20.responsiveSize),
                                        ),
                                        child: ExpansionTile(
                                          title: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppIconsAssets.sBookLesson),
                                              AppSize.s10.sizedBoxWidth,
                                              Text(
                                                state
                                                    .allLessonsByUnits[
                                                        unitIndex]
                                                    .unitName,
                                                style: const AppTextStyle()
                                                    .w500
                                                    .bodySmall12
                                                    .copyWith(
                                                      color: AppColors.white,
                                                      height: 2,
                                                    ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Colors.transparent,
                                          collapsedBackgroundColor:
                                              AppColors.secondaryColor,
                                          textColor: AppColors.textColor4,
                                          collapsedTextColor:
                                              AppColors.textColor4,
                                          iconColor: AppColors.white,
                                          collapsedIconColor: AppColors.white,
                                          controlAffinity:
                                              ListTileControlAffinity.platform,
                                          collapsedShape:
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.responsiveSize),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.responsiveSize),
                                          ),
                                          children: [
                                            if (state
                                                .allLessonsByUnits[unitIndex]
                                                .unitLessons
                                                .isEmpty)
                                              Center(
                                                  child: Text(
                                                AppStrings.noLessonsInThisUnit,
                                                style:
                                                    AppTextStyle.bodyMedium14,
                                              )),
                                            if (state
                                                .allLessonsByUnits[unitIndex]
                                                .unitLessons
                                                .isNotEmpty)
                                              Container(
                                                color:
                                                    AppColors.backgroundColor,
                                                child: Column(
                                                  children: [
                                                    AppSize.s10.sizedBoxHeight,
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (state
                                                            .allLessonsByUnits
                                                            .isEmpty) {
                                                          return const EmptyListWidgets(
                                                            message: AppStrings
                                                                .emptyLessonList,
                                                          );
                                                        } else {
                                                          return LessonItemWidget(
                                                            isLock: QuestionSharedFunction
                                                                .lockUnitsLessons(
                                                                    unitIndex:
                                                                        unitIndex,
                                                                    lessonIndex:
                                                                        index,
                                                                    userQuestionPoints: (unitIndex ==
                                                                                0 &&
                                                                            index ==
                                                                                0)
                                                                        ? state
                                                                            .allLessonsByUnits[
                                                                                unitIndex]
                                                                            .unitLessons[
                                                                                index]
                                                                            .lessonUserPoints
                                                                        : (unitIndex != 0 &&
                                                                                index == 0)
                                                                            ? state.allLessonsByUnits[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? unitIndex - 1 : unitIndex - 2].unitLessons[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? state.allLessonsByUnits[unitIndex - 1].unitLessons.length - 1 : state.allLessonsByUnits[unitIndex - 2].unitLessons.length - 1].lessonUserPoints
                                                                            : state.allLessonsByUnits[unitIndex].unitLessons[index - 1].lessonUserPoints,
                                                                    skipQuestionPoints: (unitIndex == 0 && index == 0)
                                                                        ? state.allLessonsByUnits[unitIndex].unitLessons[index].lessonSkipPoints
                                                                        : (unitIndex != 0 && index == 0)
                                                                            ? state.allLessonsByUnits[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? unitIndex - 1 : unitIndex - 2].unitLessons[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? state.allLessonsByUnits[unitIndex - 1].unitLessons.length - 1 : state.allLessonsByUnits[unitIndex - 2].unitLessons.length - 1].lessonSkipPoints
                                                                            : state.allLessonsByUnits[unitIndex].unitLessons[index - 1].lessonSkipPoints),
                                                            onTap: () {
                                                              final updateDataWithLessonId = widget.data.copyWith(
                                                                  lessonId: state
                                                                      .allLessonsByUnits[
                                                                          unitIndex]
                                                                      .unitLessons[
                                                                          index]
                                                                      .lessonId,
                                                                  subjectHaveUnits:
                                                                      widget
                                                                          .data
                                                                          .subjectsHaveUnits,
                                                                  lessonEntity: state
                                                                          .allLessonsByUnits[
                                                                              unitIndex]
                                                                          .unitLessons[
                                                                      index],
                                                                  unitIndex:
                                                                      unitIndex,
                                                                  itemIndex:
                                                                      index);
                                                              _goToQuestionScreen(
                                                                context,
                                                                updateDataWithLessonId,
                                                              );
                                                            },
                                                            imagePath: state
                                                                .allLessonsByUnits[
                                                                    unitIndex]
                                                                .unitLessons[
                                                                    index]
                                                                .imgPath,
                                                            notHaveImage: state
                                                                .allLessonsByUnits[
                                                                    unitIndex]
                                                                .unitLessons[
                                                                    index]
                                                                .imgPath
                                                                .isEmpty,
                                                            isCompleted:
                                                                QuestionSharedFunction
                                                                    .isCompleted(
                                                              userQuestionPoints: state
                                                                  .allLessonsByUnits[
                                                                      unitIndex]
                                                                  .unitLessons[
                                                                      index]
                                                                  .lessonUserPoints,
                                                              skipQuestionPoints: state
                                                                  .allLessonsByUnits[
                                                                      unitIndex]
                                                                  .unitLessons[
                                                                      index]
                                                                  .lessonSkipPoints,
                                                            ),
                                                            lessonName: state
                                                                .allLessonsByUnits[
                                                                    unitIndex]
                                                                .unitLessons[
                                                                    index]
                                                                .name,
                                                            description: state
                                                                    .allLessonsByUnits[
                                                                        unitIndex]
                                                                    .unitLessons[
                                                                        index]
                                                                    .description
                                                                    .isEmpty
                                                                ? ''
                                                                : state
                                                                    .allLessonsByUnits[
                                                                        unitIndex]
                                                                    .unitLessons[
                                                                        index]
                                                                    .description,
                                                          );
                                                        }
                                                      },
                                                      separatorBuilder: (context,
                                                              index) =>
                                                          AppSize.s16
                                                              .sizedBoxHeight,
                                                      itemCount: state
                                                          .allLessonsByUnits[
                                                              unitIndex]
                                                          .unitLessons
                                                          .length,
                                                    ),
                                                    AppSize.s30.sizedBoxHeight,
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                            itemCount: state.allLessonsByUnits.length,
                          )
                        : ListView.separated(
                            itemBuilder: (context, unitIndex) {
                              if (state.allLessonsByUnits[unitIndex].unitLessons
                                  .isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: AppColors.white,
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.appBorderRadiusR20.responsiveSize),
                                      ),
                                      child: ExpansionTile(
                                        title: Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppIconsAssets.sBookLesson),
                                            AppSize.s10.sizedBoxWidth,
                                            Expanded(
                                              child: Text(
                                                state.allLessonsByUnits[unitIndex]
                                                    .unitName,
                                                style: const AppTextStyle()
                                                    .w500
                                                    .bodySmall12
                                                    .copyWith(
                                                      color: AppColors.white,
                                                      height: 2,
                                                    ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.transparent,
                                        collapsedBackgroundColor:
                                            AppColors.secondaryColor,
                                        textColor: AppColors.textColor4,
                                        collapsedTextColor:
                                            AppColors.textColor4,
                                        iconColor: AppColors.white,
                                        collapsedIconColor: AppColors.white,
                                        //childrenPadding: EdgeInsets.symmetric(horizontal:  10.responsiveSize),
                                        controlAffinity:
                                            ListTileControlAffinity.platform,
                                        collapsedShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.responsiveSize),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.responsiveSize),
                                        ),
                                        children: [
                                          if (state.allLessonsByUnits[unitIndex]
                                              .unitLessons.isEmpty)
                                            Center(
                                                child: Text(
                                              AppStrings.noLessonsInThisUnit,
                                              style: AppTextStyle.bodyMedium14,
                                            )),
                                          if (state.allLessonsByUnits[unitIndex]
                                              .unitLessons.isNotEmpty)
                                            Container(
                                              color: AppColors.backgroundColor,
                                              child: Column(
                                                children: [
                                                  AppSize.s10.sizedBoxHeight,
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (state
                                                          .allLessonsByUnits
                                                          .isEmpty) {
                                                        return const EmptyListWidgets(
                                                          message: AppStrings
                                                              .emptyLessonList,
                                                        );
                                                      } else {
                                                        return LessonItemWidget(
                                                          isLock: QuestionSharedFunction
                                                              .lockUnitsLessons(
                                                                  unitIndex:
                                                                      unitIndex,
                                                                  lessonIndex:
                                                                      index,
                                                                  userQuestionPoints: (unitIndex ==
                                                                              0 &&
                                                                          index ==
                                                                              0)
                                                                      ? state
                                                                          .allLessonsByUnits[
                                                                              unitIndex]
                                                                          .unitLessons[
                                                                              index]
                                                                          .lessonUserPoints
                                                                      : (unitIndex != 0 &&
                                                                              index ==
                                                                                  0)
                                                                          ? state
                                                                              .allLessonsByUnits[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? unitIndex - 1 : unitIndex - 2]
                                                                              .unitLessons[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? state.allLessonsByUnits[unitIndex - 1].unitLessons.length - 1 : state.allLessonsByUnits[unitIndex - 2].unitLessons.length - 1]
                                                                              .lessonUserPoints
                                                                          : state.allLessonsByUnits[unitIndex].unitLessons[index - 1].lessonUserPoints,
                                                                  skipQuestionPoints: (unitIndex == 0 && index == 0)
                                                                      ? state.allLessonsByUnits[unitIndex].unitLessons[index].lessonSkipPoints
                                                                      : (unitIndex != 0 && index == 0)
                                                                          ? state.allLessonsByUnits[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? unitIndex - 1 : unitIndex - 2].unitLessons[state.allLessonsByUnits[unitIndex - 1].unitLessons.isNotEmpty ? state.allLessonsByUnits[unitIndex - 1].unitLessons.length - 1 : state.allLessonsByUnits[unitIndex - 2].unitLessons.length - 1].lessonSkipPoints
                                                                          : state.allLessonsByUnits[unitIndex].unitLessons[index - 1].lessonSkipPoints),
                                                          onTap: () {
                                                            final updateDataWithLessonId = widget.data.copyWith(
                                                                lessonId: state
                                                                    .allLessonsByUnits[
                                                                        unitIndex]
                                                                    .unitLessons[
                                                                        index]
                                                                    .lessonId,
                                                                subjectHaveUnits:
                                                                    widget.data
                                                                        .subjectsHaveUnits,
                                                                lessonEntity: state
                                                                        .allLessonsByUnits[
                                                                            unitIndex]
                                                                        .unitLessons[
                                                                    index],
                                                                unitIndex:
                                                                    unitIndex,
                                                                itemIndex:
                                                                    index);
                                                            _goToQuestionScreen(
                                                              context,
                                                              updateDataWithLessonId,
                                                            );
                                                          },
                                                          imagePath: state
                                                              .allLessonsByUnits[
                                                                  unitIndex]
                                                              .unitLessons[
                                                                  index]
                                                              .imgPath,
                                                          notHaveImage: state
                                                              .allLessonsByUnits[
                                                                  unitIndex]
                                                              .unitLessons[
                                                                  index]
                                                              .imgPath
                                                              .isEmpty,
                                                          isCompleted:
                                                              QuestionSharedFunction
                                                                  .isCompleted(
                                                            userQuestionPoints: state
                                                                .allLessonsByUnits[
                                                                    unitIndex]
                                                                .unitLessons[
                                                                    index]
                                                                .lessonUserPoints,
                                                            skipQuestionPoints: state
                                                                .allLessonsByUnits[
                                                                    unitIndex]
                                                                .unitLessons[
                                                                    index]
                                                                .lessonSkipPoints,
                                                          ),
                                                          lessonName: state
                                                              .allLessonsByUnits[
                                                                  unitIndex]
                                                              .unitLessons[
                                                                  index]
                                                              .name,
                                                          description: state
                                                                  .allLessonsByUnits[
                                                                      unitIndex]
                                                                  .unitLessons[
                                                                      index]
                                                                  .description
                                                                  .isEmpty
                                                              ? ''
                                                              : state
                                                                  .allLessonsByUnits[
                                                                      unitIndex]
                                                                  .unitLessons[
                                                                      index]
                                                                  .description,
                                                        );
                                                      }
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            AppSize.s16
                                                                .sizedBoxHeight,
                                                    itemCount: state
                                                        .allLessonsByUnits[
                                                            unitIndex]
                                                        .unitLessons
                                                        .length,
                                                  ),
                                                  AppSize.s30.sizedBoxHeight,
                                                ],
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                            separatorBuilder: (context, unitIndex) =>
                                AppSize.s10.sizedBoxHeight,
                            itemCount: state.allLessonsByUnits.length,
                          ),
                  ),
                );
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    child: EmptyLessonWidget(
                      onRefresh: () {
                        _refreshLessonWithUnits(context);
                      },
                    ),
                  ),
                );
              }
            } else {
              if (state.allLessons.isNotEmpty) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _refreshLessonWithoutUnits(context);
                    },
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return LessonItemWidget(
                          isLock: QuestionSharedFunction.checkIsLock(
                            index: index,
                            userQuestionPoints: index == 0
                                ? state.allLessons[index].lessonUserPoints
                                : state.allLessons[index - 1].lessonUserPoints,
                            skipQuestionPoints: index == 0
                                ? state.allLessons[index].lessonSkipPoints
                                : state.allLessons[index - 1].lessonSkipPoints,
                          ),
                          onTap: () {
                            final updateDataWithLessonId = widget.data.copyWith(
                              lessonId: state.allLessons[index].lessonId,
                              itemIndex: index,
                              subjectHaveUnits: widget.data.subjectHaveUnits,
                              lessonEntity: state.allLessons[index],
                            );
                            _goToQuestionScreen(
                                context, updateDataWithLessonId);
                          },
                          imagePath: state.allLessons[index].imgPath,
                          notHaveImage: state.allLessons[index].imgPath.isEmpty,
                          isCompleted: QuestionSharedFunction.isCompleted(
                            userQuestionPoints:
                                state.allLessons[index].lessonUserPoints,
                            skipQuestionPoints:
                                state.allLessons[index].lessonSkipPoints,
                          ),
                          lessonName: state.allLessons[index].name,
                          description:
                              state.allLessons[index].description.isEmpty
                                  ? AppStrings.noDescription
                                  : state.allLessons[index].description,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          AppSize.s16.sizedBoxHeight,
                      itemCount: state.allLessons.length,
                    ),
                  ),
                ).animateBottomToTop(duration: AppConstants.animationTime);
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    child: EmptyLessonWidget(
                      onRefresh: () {
                        _refreshLessonWithoutUnits(context);
                      },
                    ),
                  ),
                );
              }
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.errorMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }

  void _goToQuestionScreen(context, updateDataWithLessonId) {
    if (!AppReference.userIsGuest()) {
      RouteManager.rPushNamedAndRemoveUntil(
        context: context,
        rName: AppRoutesNames.rQuestionsScreen,
        arguments: updateDataWithLessonId,
      );
    } else {
      AppReference.guestDialogMustLogin(context);
    }
  }

  void _refreshLessonWithoutUnits(context) {
    BlocProvider.of<LessonsBloc>(context).add(
      GetAllLessonsEvent(
        ParameterGoToQuestions(
          subjectId: widget.data.subjectId,
          stageId: widget.data.stageId,
          classRoomId: widget.data.classRoomId,
          termId: widget.data.termId,
        ),
      ),
    );
  }

  void _refreshLessonWithUnits(context) {
    BlocProvider.of<LessonsBloc>(context).add(
      GetAllLessonsByUnitsEvent(
        ParameterGoToQuestions(
          subjectId: widget.data.subjectId,
          stageId: widget.data.stageId,
          classRoomId: widget.data.classRoomId,
          termId: widget.data.termId,
        ),
      ),
    );
  }
}

class EmptyLessonWidget extends StatelessWidget {
  final Function() onRefresh;
  const EmptyLessonWidget({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * .5.responsiveHeightRatio,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: EmptyListWidgets(
              message: AppStrings.noLessons,
            ),
          ),
          AppSize.s20.sizedBoxHeight,
          DefaultButtonWidget(
            onPressed: onRefresh,
            label: AppStrings.reload,
          ),
        ],
      ),
    );
  }
}

