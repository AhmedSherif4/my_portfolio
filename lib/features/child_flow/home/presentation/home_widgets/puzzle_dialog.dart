part of '../../home.dart';

class PuzzleDialog extends StatefulWidget {
  final String message;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;

  const PuzzleDialog({
    super.key,
    required this.message,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });

  @override
  State<PuzzleDialog> createState() => _PuzzleDialogState();
}

class _PuzzleDialogState extends State<PuzzleDialog> {
  int _isSelectedPuzzle = -1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          ),
          borderSide: BorderSide.none),
      content: BlocProvider(
        create: (context) => getIt<HomeBloc>()..add(const CheckPuzzleEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Container(
              width: !AppReference.isPortrait(context)
                  ? AppReference.deviceWidth(context) * 0.4
                  : AppReference.deviceWidth(context) * 0.8,
              padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadiusR20.responsiveSize),
                  gradient: AppGradientColors.adviceGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomInkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          AppImagesAssets.sPuzzleAndAdviceCancel,
                          height: AppReference.isPortrait(context)
                              ? AppSize.s26.responsiveHeightRatio
                              : AppSize.s16.responsiveHeightRatio,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "لغز اليوم",
                            style: AppReference.themeData.textTheme.titleSmall!
                                .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          AppSize.s10.sizedBoxWidth,
                          SvgPicture.asset(
                            AppImagesAssets.sPrimaryPuzzle,
                            height: AppSize.s22.responsiveHeightRatio,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  Container(
                    padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR20.responsiveSize),
                    ),
                    child: Text(
                      widget.message,
                      style: const AppTextStyle().s16.titleMedium20,
                    ),
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  if (widget.answer1 != "") ...[
                    PuzzleAnswerWidget(
                      correct: state.puzzleAnswer,
                      title: widget.answer1,
                      index: 1,
                      selectItem: () {
                        setState(() {
                          _isSelectedPuzzle = 1;
                        });
                      },
                      isSelectedPuzzle: _isSelectedPuzzle,
                    ),
                  ],
                  if (widget.answer2 != "") ...[
                    (AppSize.s10).sizedBoxHeight,
                    PuzzleAnswerWidget(
                      title: widget.answer2,
                      correct: state.puzzleAnswer,
                      index: 2,
                      selectItem: () {
                        setState(() {
                          _isSelectedPuzzle = 2;
                        });
                      },
                      isSelectedPuzzle: _isSelectedPuzzle,
                    ),
                  ],
                  if (widget.answer3 != "") ...[
                    (AppSize.s10).sizedBoxHeight,
                    PuzzleAnswerWidget(
                      correct: state.puzzleAnswer,
                      title: widget.answer3,
                      index: 3,
                      selectItem: () {
                        setState(() {
                          _isSelectedPuzzle = 3;
                        });
                      },
                      isSelectedPuzzle: _isSelectedPuzzle,
                    ),
                  ],
                  (AppSize.s10).sizedBoxHeight,
                  if (widget.answer4 != "") ...[
                    PuzzleAnswerWidget(
                      correct: state.puzzleAnswer,
                      title: widget.answer4,
                      index: 4,
                      selectItem: () {
                        setState(() {
                          _isSelectedPuzzle = 4;
                        });
                      },
                      isSelectedPuzzle: _isSelectedPuzzle,
                    ),
                  ],
                  if ((state.puzzleAnswer != widget.correctAnswer)) ...[
                    (AppSize.s10).sizedBoxHeight,
                    if (widget.answer1 != "" && widget.answer2 != "")
                      DefaultButtonWidget(
                        label: 'إنهاء',
                        buttonColor: AppColors.primaryColor2,
                        borderColor: Colors.transparent,
                        isExpanded: true,
                        textVerticalPadding: 0,
                        onPressed: () {
                          if (_isSelectedPuzzle == -1) {
                            showSnackBar(
                                description: "الرجاء تحديد الجواب",
                                state: ToastStates.error,
                                context: context);
                            return;
                          } else {
                            if ("$_isSelectedPuzzle" == widget.correctAnswer) {
                              getIt<HomeLocalDataSource>()
                                  .saveSelectedAnswerOfPuzzle(
                                      value: "$_isSelectedPuzzle")
                                  .then((value) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  showSnackBar(
                                      description: "تم التسليم بنجاح",
                                      state: ToastStates.congrats,
                                      context: context);
                                  setState(() {});
                                }
                              });
                            } else {
                              showSnackBar(
                                  description: "المحاولة مرة اخرى",
                                  state: ToastStates.error,
                                  context: context);
                            }
                          }
                          // Navigator.pop(context);
                        },
                      )
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PuzzleAnswerWidget extends StatelessWidget {
  const PuzzleAnswerWidget(
      {super.key,
      required this.selectItem,
      required this.index,
      required this.correct,
      required this.title,
      required this.isSelectedPuzzle});
  final Function() selectItem;
  final int index;
  final int isSelectedPuzzle;
  final String correct;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: correct != "" ? () {} : selectItem,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20.responsiveSize),
              height: AppSize.s50.responsiveHeight,
              decoration: BoxDecoration(
                color: (correct == "$index")
                    ? AppColors.successColor
                    : isSelectedPuzzle == index
                        ? AppColors.primaryColor2
                        : AppColors.white,
                borderRadius: BorderRadius.circular(
                    AppConstants.appBorderRadiusR15.responsiveSize),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: AppSize.s12.responsiveSize,
                    backgroundColor: isSelectedPuzzle == index
                        ? AppColors.white
                        : AppColors.textColor6,
                    child: Text(
                      "$index",
                      style: const AppTextStyle().s16.titleMedium20,
                    ),
                  ),
                  AppSize.s10.sizedBoxWidth,
                  Expanded(
                    child: Text(
                      title,
                      style: const AppTextStyle().s16.titleMedium20.copyWith(
                            color:
                                isSelectedPuzzle == index || correct == "$index"
                                    ? AppColors.white
                                    : AppColors.black,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSize.s10.sizedBoxWidth,
          Container(
            height: AppSize.s24.responsiveHeight,
            width: AppSize.s24.responsiveHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: AppColors.white),
            ),
            child: CircleAvatar(
                radius: AppSize.s10.responsiveSize,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.circle,
                  color: (correct == "$index")
                      ? AppColors.successColor
                      : isSelectedPuzzle == index
                          ? AppColors.primaryColor2
                          : Colors.transparent,
                )),
          ),
        ],
      ),
    );
  }
}
