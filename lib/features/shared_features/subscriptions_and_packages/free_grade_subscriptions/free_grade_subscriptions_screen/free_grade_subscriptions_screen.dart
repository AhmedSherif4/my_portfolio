part of '../free_grade_subscriptions.dart';

class FreeGradeSubscriptionsScreen extends StatelessWidget {
  final UserEntity userData;
  const FreeGradeSubscriptionsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PackagesBloc>(),
      child: BlocListener<PackagesBloc, PackagesState>(
        listener: (context, state) {
          switch (state.addClassroomToCartState) {
            case RequestStates.loading:
              showLoadingDialog(context);
              break;
            case RequestStates.loaded:
              Navigator.pop(context);
              if (state.addClassroomToCartData!.allTerms.isNotEmpty) {
                showChoosingOptionalSubjectsDialog(
                  allTerms: state.addClassroomToCartData!.allTerms,
                  allSubjects: state.addClassroomToCartData!.allSubjects,
                  childId: userData.userId,
                  context: context,
                );
              } else {
                showSnackBar(
                    description: state.addClassroomToCartMessage,
                    state: ToastStates.congrats,
                    context: context);
              }
              break;
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addClassroomToCartMessage,
                  state: ToastStates.error,
                  context: context);
              break;
            default:
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                 AppBarSubscriptionsWidget(
                  childID:userData.userId ,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.gradeSubscription,
                    style: const AppTextStyle().w600.s15.gray.bodyLarge16,
                  ),
                ),
                45.0.sizedBoxHeight,
                BlocBuilder<FreeGradeSubscriptionsBloc,
                    FreeGradeSubscriptionsState>(builder: (context, state) {
                  switch (state.getSystemState) {
                    case RequestStates.loading:
                      return LoadingShimmerStructure(
                        height: 40.responsiveHeight,
                      );
                    case RequestStates.loaded:
                      return DefaultDropDownButton<StudyingModel>(
                          studyingData: state.systems,
                          selectedItem: state.currentSystem,
                          displayText: (system) => system.name,
                          onChange: (value) {
                            state.currentSystem == value
                                ? null
                                : context
                                    .read<FreeGradeSubscriptionsBloc>()
                                    .add(ChangeSystemFreeGrade(value!));
                          });
                    default:
                      return const SizedBox.shrink();
                  }
                }),
                45.0.sizedBoxHeight,
                BlocBuilder<FreeGradeSubscriptionsBloc,
                    FreeGradeSubscriptionsState>(builder: (context, state) {
                  switch (state.getStagesState) {
                    case RequestStates.loading:
                      return Column(
                        children: [
                          LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              AppStrings.chooseClassrooms,
                              style: const AppTextStyle().w500.titleSmall18,
                            ),
                          ),
                          10.sizedBoxHeight,
                          const LoadingShimmerList(),
                        ],
                      );
                    case RequestStates.loaded:
                      return DefaultDropDownButton<StudyingModel>(
                        studyingData: state.stages,
                        selectedItem: state.currentStage,
                        displayText: (stage) => stage.name,
                        onChange: (value) {
                          state.currentStage == value
                              ? null
                              : context
                                  .read<FreeGradeSubscriptionsBloc>()
                                  .add(ChangeStagesFreeGrade(value!));
                          // selectedStage = value as StudyingModel;
                        },
                      );
                    default:
                      return const SizedBox();
                  }
                }),
                45.0.sizedBoxHeight,
                Expanded(
                  child: BlocBuilder<FreeGradeSubscriptionsBloc,
                      FreeGradeSubscriptionsState>(
                    builder: (context, state) {
                      switch (state.getClassroomsState) {
                        case RequestStates.loading:
                          return Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  AppStrings.chooseClassrooms,
                                  style: const AppTextStyle().w500.titleSmall18,
                                ),
                              ),
                              10.sizedBoxHeight,
                              const LoadingShimmerList(),
                            ],
                          );
                        case RequestStates.loaded:
                          if (state.classRooms.isEmpty) {
                            return const EmptyListWidgets(
                                message: 'لا يوجد فصول دراسيه الأن');
                          } else {
                            return ListView.builder(
                              itemCount: state.classRooms.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return CustomSelectWidget(
                                  title: state.classRooms[index].name,
                                  price: state.classRooms[index].price!,
                                  onTap: () {
                                    if (state.classRooms[index].isPath ??
                                        false) {
                                      PathsInClassroomModel current =
                                          state.classRooms[index].paths!.first;
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return PopScope(
                                              canPop: false,
                                              child: SizedBox(
                                                child: AlertDialog(
                                                  scrollable: true,
                                                    title: Text(
                                                      'برجاء اختيار المسار',
                                                      style:
                                                          const AppTextStyle()
                                                              .w500
                                                              .titleSmall18,
                                                    ),
                                                    actions: [
                                                      DefaultButtonWidget(
                                                          label: 'تم',
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ],
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return DefaultDropDownButton<
                                                          PathsInClassroomModel>(
                                                        studyingData: state
                                                            .classRooms[index]
                                                            .paths!,
                                                        selectedItem: current,
                                                        displayText:
                                                            (subject) => subject
                                                                .pathName,
                                                        onChange:
                                                            (selectedValue) {
                                                          setState(() {
                                                            current =
                                                                selectedValue!;
                                                          });
                                                          //   ;
                                                        },
                                                      );
                                                    })),
                                              ),
                                            );
                                          }).then((value) {
                                            AppAnalytics.logAddClassroomToCart(classroomName: state.classRooms[index].name);
                                            if(!context.mounted) return;
                                            context.read<PackagesBloc>().add(AddClassroomToCartEvent(
                                              AddItemToCartParameters(
                                                userID: userData.userId,
                                                id: state.classRooms[index].id,
                                                pathId: current.pathId,
                                              ),
                                            ));
                                      });
                                    } else {
                                      AppAnalytics.logAddClassroomToCart(classroomName: state.classRooms[index].name);
                                      context.read<PackagesBloc>().add(AddClassroomToCartEvent(
                                            AddItemToCartParameters(
                                              userID: userData.userId,
                                              id: state.classRooms[index].id,
                                            ),
                                          ));
                                    }
                                  },
                                );
                              },
                            );
                          }
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
                10.sizedBoxHeight,
                BlocBuilder<FreeGradeSubscriptionsBloc,
                    FreeGradeSubscriptionsState>(
                  builder: (context, state) {
                    switch (state.getClassroomsState) {
                      case RequestStates.loading:
                        return LoadingShimmerStructure(
                          height: 45.responsiveHeightRatio,
                          width: 210.responsiveWidth,
                        );
                      case RequestStates.loaded:
                        return ToCartButton(
                          childID: userData.userId,
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}
