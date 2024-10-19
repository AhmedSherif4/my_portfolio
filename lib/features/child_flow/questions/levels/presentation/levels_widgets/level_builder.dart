import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/shared_widget/base_list_tile_widget.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/core/shared_widget/lock_widget.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_questions_data.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/resources/app_constants.dart';
import '../../../../../../core/enum/enum_generation.dart';
import '../../../shared/shared_functions/question_shared_funtion.dart';
import '../../levels.dart';

class LevelBuilder extends StatelessWidget {
  final DataToGoQuestions dataToGoQuestions;

  const LevelBuilder({super.key, required this.dataToGoQuestions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelsBloc, LevelsState>(
      builder: (context, state) {
        switch (state.levelsStates) {
          case RequestStates.loading:
            return const LoadingShimmerList();
          case RequestStates.loaded:
            if (state.levels.isEmpty) {
              return SizedBox(
                  height:AppReference.deviceHeight(context) * .4,
                  child: const Center(
                      child:
                          EmptyListWidgets(message: AppStrings.noLevelsNow)));
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LockWidgets(
                    lockWidget: BaseListTile(
                      title: state.levels[index].name,
                      description: state.levels[index].description.isEmpty
                          ? AppStrings.noDescription
                          : state.levels[index].description,
                      imagePath: state.levels[index].imgPath,
                      imageBoxFit: BoxFit.contain,
                      notHaveImage: state.levels[index].imgPath.isEmpty,
                      titleStyle: const AppTextStyle().s16.displaySmall28,
                      descriptionStyle: const AppTextStyle().s16.displaySmall28,
                      onTap: () {
                        final data = dataToGoQuestions.copyWith(
                          levelId: state.levels[index].id,
                          levelImage: state.levels[index].imgPath,
                          levelImageNotFound: state.levels[index].imgPath.isEmpty,
                          levelName: state.levels[index].name,
                          levelColor: state.levels[index].itemColor,
                        );


                        RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rPrimaryCollectionsScreen,
                          arguments: data,
                        );
                      },
                      backgroundColor: state.levels[index].itemColor,
                    ),
                    isLocked: QuestionSharedFunction.checkIsLock(
                      index: index,
                      userQuestionPoints: index == 0
                          ? state.levels[index].userPoints
                          : state.levels[index - 1].userPoints,
                      skipQuestionPoints: index == 0
                          ? state.levels[index].skipPoints
                          : state.levels[index - 1].skipPoints,
                    ),
                    textLock: AppStrings.skipPreviousLevel,
                  ).animateBottomToTop(duration: AppConstants.animationTime);
                },
                separatorBuilder: (context, index) =>
                    15.responsiveHeight.sizedBoxHeight,
                itemCount: state.levels.length,
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.levelsErrorMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
