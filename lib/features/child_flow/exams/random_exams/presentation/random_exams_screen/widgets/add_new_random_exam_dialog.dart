part of'../../../random_exams.dart';


//ToDo : convert this widget to stateless widget and handle changes with bloc or state full Builder widget
// ToDo : if show StatefulWidget and using set state any where again ........................
class AddNewRandomExamDialog extends StatefulWidget {
  final DataToGoExams dataToGoExams;
  const AddNewRandomExamDialog({super.key, required this.dataToGoExams});

  @override
  State<AddNewRandomExamDialog> createState() => _AddNewRandomExamDialogState();
}

class _AddNewRandomExamDialogState extends State<AddNewRandomExamDialog> {
  int questionNum = 5;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<RandomExamsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SharedSubjectsBloc>()
            ..add(GetSharedSubjectsEvent(
                parameter: ParameterGoToQuestions(
                    termId: widget.dataToGoExams.termId ??
                        getIt<UserLocalDataSource>().getUserData()!.termId!,
                    stageId:
                        getIt<UserLocalDataSource>().getUserData()!.stageId!,
                    classRoomId: getIt<UserLocalDataSource>()
                        .getUserData()!
                        .classroomId!,
                    pathId: widget.dataToGoExams.pathId ??
                        getIt<UserLocalDataSource>().getUserData()!.pathId!,
                    systemId:
                        getIt<UserLocalDataSource>().getUserData()!.systemId!,
                    subjectType: SubjectType.subscriptions))),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<RandomExamsBloc, RandomExamsState>(
          listener: (context, state) {
            switch (state.createRandomExamsRequestState) {
              case RequestStates.loading:
                showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rRandomQuestionScreen,
                      arguments: widget.dataToGoExams.copyWith(
                        data: state.createdRandomExam,
                      ));
                  showSnackBar(
                      description: state.createRandomExamsErrorMessage,
                      state: ToastStates.congrats,
                      context: context);
                case RequestStates.error:
                  Navigator.of(context).pop();
                  showSnackBar(
                      description: state.createRandomExamsErrorMessage,
                      state: ToastStates.error,
                      context: context);
                  default:

            }
          },
          child: AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.zero,
            elevation: 5,
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            iconPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
              width: AppReference.deviceIsTablet &&
                      !(AppReference.isPortrait(context))
                  ? AppReference.deviceWidth(context) * 0.4
                  : AppReference.deviceWidth(context) * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadiusR20.responsiveSize),
                  color: AppColors.backgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomInkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        AppImagesAssets.sPuzzleAndAdviceCancel,
                        height: AppReference.isPortrait(context)?AppSize.s30.responsiveHeightRatio:AppSize.s20.responsiveHeightRatio,
                      ),
                    ),
                  ),
                  AppSize.s10.sizedBoxHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: AppPadding.p20.responsiveSize,
                          bottom: AppPadding.p20.responsiveSize,
                          right: AppPadding.p20.responsiveSize,
                        ),
                        alignment: Alignment.center,
                        width: AppReference.deviceIsTablet
                            ? AppReference.deviceWidth(context) * 0.2
                            : AppReference.deviceWidth(context) * 0.45,
                        height: AppReference.deviceHeight(context) *
                            0.045.responsiveHeightRatio,
                        decoration: ShapeDecoration(
                          color: AppColors.primary2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(AppConstants
                                  .appBorderRadiusR20.responsiveSize),
                              bottomRight: Radius.circular(AppConstants
                                  .appBorderRadiusR20.responsiveSize),
                            ),
                          ),
                        ),
                        child: Text(
                          AppStrings.randomExamTitle,
                          style: AppReference.themeData.textTheme.bodyLarge!
                              .copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        AppImagesAssets.sExamChallenge,
                        height: AppReference.isPortrait(context)?AppSize.s30.responsiveHeightRatio:AppSize.s20.responsiveHeightRatio,
                      )
                    ],
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "اختر المادة",
                      style: const AppTextStyle()
                          .titleSmall18
                          .copyWith(fontWeight: AppFontWeight.semiBoldW600),
                    ),
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                    builder: (context, state) {
                      return switch (state.getSubjectsState) {
                        RequestStates.loading =>  SizedBox(
                          height: AppSize.s100.responsiveHeight,
                          child: const Row(
                            children: [
                              Expanded(child: LoadingShimmerStructure()),
                              Expanded(child: LoadingShimmerStructure()),
                            ],
                          ),
                        ),
                        RequestStates.loaded => Column(
                            children: [
                              SubjectsWidget(
                                dataToGoExams: DataToGoExams(
                                  subjects: state.subjects,
                                  user: getIt<UserLocalDataSource>()
                                      .getUserData()!,
                                  isPrimary: AppReference.childIsPrimary(),
                                ),
                              ).animateFlipVertical(),
                              AppSize.s10.sizedBoxHeight,
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "اختر عدد الأسئلة",
                                  style: const AppTextStyle()
                                      .titleSmall18
                                      .copyWith(
                                      fontWeight:
                                      AppFontWeight.semiBoldW600),
                                ),
                              ),
                              (AppSize.s10).sizedBoxHeight,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              30.responsiveSize),
                                          boxShadow: const [
                                            AppShadow.outerShadow,
                                          ]),
                                      width: AppReference.deviceWidth(context) *
                                          0.2,
                                      child: CustomInkWell(
                                        onTap: () {
                                          setState(() {
                                            if (questionNum != 40) {
                                              questionNum = questionNum + 5;
                                            }
                                          });
                                          // controller.text = "$questionNum";
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  30.responsiveSize),
                                              boxShadow: const [
                                                AppShadow.outerShadow,
                                              ]),
                                          width: AppReference.deviceWidth(
                                              context) *
                                              0.2,
                                          child: Text(
                                            '+',
                                            style: const AppTextStyle()
                                                .white
                                                .titleLarge22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AppSize.s20.sizedBoxWidth,
                                  Expanded(child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      border: Border.all(color: AppColors.primary2),
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.appBorderRadiusR30.responsiveSize),
                                        boxShadow: const [
                                          AppShadow.outerShadow,
                                        ]),
                                    child: Text(
                                      "$questionNum",
                                      textAlign: TextAlign.center,
                                      style: const AppTextStyle()
                                          .white
                                          .titleLarge22,
                                    ),
                                  )),
                                  AppSize.s20.sizedBoxWidth,
                                  Expanded(
                                    child: CustomInkWell(
                                      onTap: () {
                                        setState(() {
                                          if (questionNum != 5) {
                                            questionNum = questionNum - 5;
                                          }
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                30.responsiveSize),
                                            boxShadow: const [
                                              AppShadow.outerShadow,
                                            ]),
                                        width:
                                        AppReference.deviceWidth(context) *
                                            0.2,
                                        child: Text(
                                          '-',
                                          style: const AppTextStyle()
                                              .white
                                              .titleLarge22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (AppSize.s10).sizedBoxHeight,
                              DefaultButtonWidget(
                                  label: 'إنشاء اختبار',
                                  textVerticalPadding:AppReference.isPortrait(context)?0: 6,
                                  onPressed: () {
                                    context
                                        .read<RandomExamsBloc>()
                                        .add(CreateRandomExamsOfThatSubject(
                                      createRandomExamInputs:
                                      CreateRandomExamInputs(
                                        subjectId: state.selectedSubject ==
                                            0
                                            ? state.subjects[0].subjectId
                                            : state.selectedSubjectId,
                                        questionsNum: questionNum,
                                      ),
                                    ));
                                  }
                              )
                            ],
                          ),
                        RequestStates.error => CustomErrorWidget(errorMessage: state.getSubjectsStateMessage,),
                        _ => const SizedBox()
                      };
                    },
                  ),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
