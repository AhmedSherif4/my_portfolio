import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../core/base_widgets/loading_shimmer_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/shared_widget/error_widget.dart';
import '../../../../../my_app/app_reference.dart';
import '../../home.dart';

class PuzzleWidget extends StatelessWidget {
  final String puzzle;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;
  final String puzzleImagePath;

  const PuzzleWidget({
    super.key,
    required this.puzzle,
    required this.puzzleImagePath,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => PuzzleDialog(
            message: puzzle,
            answer1: answer1,
            answer2: answer2,
            answer3: answer3,
            answer4: answer4,
            correctAnswer: correctAnswer,
          ),
        );
      },
      child: Container(
        width: (AppReference.deviceIsTablet&&!AppReference.isPortrait(context))?AppReference.deviceWidth(context)*0.45:double.infinity,
        height: (AppReference.deviceIsTablet&&!AppReference.isPortrait(context))?AppReference.deviceHeight(context)*0.25:AppReference.deviceHeight(context) * 0.18.responsiveHeightRatio,
        alignment: AlignmentDirectional.topStart,
        padding: EdgeInsets.all(AppPadding.p14.responsiveSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
          color: AppColors.primary2,
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constrains.maxWidth * 0.6,
                child: LayoutBuilder(builder: (context, consColumn) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: consColumn.maxWidth,
                        height: consColumn.maxHeight * 0.25,
                        child: Align(
                          alignment: AppReference.deviceIsTablet?AlignmentDirectional.center:AlignmentDirectional.topStart,
                          child: FittedBox(
                            child: Text(
                              AppStrings.puzzleDay,
                              style:AppReference
                                  .themeData.textTheme.titleLarge!
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: consColumn.maxWidth,
                        height: consColumn.maxHeight * 0.75,
                        child: Align(
                          alignment: AppReference.deviceIsTablet?AlignmentDirectional.center:AlignmentDirectional.topStart,
                          child: Text(
                            puzzle,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style:AppReference.deviceIsTablet?const AppTextStyle().w600.white.bodySmall12.copyWith(color: AppColors.white): const AppTextStyle().w500.white.bodySmall12,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SvgPicture.asset(
                puzzleImagePath,
                height: constrains.maxHeight * 0.9,
                width: constrains.maxWidth * 0.35,
                fit: BoxFit.cover,
              ),
            ],
          );
        }),
      ),
    );
  }

}

class PuzzleBuilder extends StatelessWidget {
  final GlobalKey one;
  final String puzzleImagePath;

  const PuzzleBuilder(
      {super.key, required this.one, required this.puzzleImagePath});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.getPuzzleAndAdviceState) {
          case RequestStates.loading:
            return LoadingShimmerStructure(
              height: 100.responsiveHeight,
            );
          case RequestStates.loaded:
            return Showcase(
              key: one,
              tooltipPosition: TooltipPosition.bottom,
              tooltipPadding: EdgeInsets.all(10.responsiveSize),
              targetPadding: EdgeInsets.all(15.responsiveSize),
              description:
              AppStrings.showCaseOne,
              disableDefaultTargetGestures: true,
              child: PuzzleWidget(
                puzzle: state.puzzleAndAdviceEntity.content,
                puzzleImagePath: puzzleImagePath,
                answer1: state.puzzleAndAdviceEntity.select1 ?? '',
                answer2: state.puzzleAndAdviceEntity.select2 ?? '',
                answer3: state.puzzleAndAdviceEntity.select3 ?? '',
                answer4: state.puzzleAndAdviceEntity.select4 ?? '',
                correctAnswer: state.puzzleAndAdviceEntity.correctSelect ?? '',
              ),
            );
          case RequestStates.error:
            return CustomErrorWidget(
                errorMessage: state.puzzleAndAdviceMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
