part of '../free_term_subscriptions.dart';

class FreeTermSubscriptionsScreen extends StatelessWidget {
  final UserEntity userData;
  const FreeTermSubscriptionsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PackagesBloc>(),
      child: BlocListener<PackagesBloc, PackagesState>(
        listener: (context, state) {
          switch (state.addTermToCartState) {
            case RequestStates.loading:
              showLoadingDialog(context);
              break;
            case RequestStates.loaded:
              Navigator.pop(context);
              if (state.addTermToCartData!.allSubjects.isNotEmpty) {
                showChoosingOptionalSubjectsDialogForTerm(
                  termId: userData.termId!,
                  allSubjects: state.addTermToCartData!.allSubjects,
                  context: context,
                  childId: userData.userId,
                );
              }else {
                showSnackBar(
                    description: state.addTermToCartMessage,
                    state: ToastStates.congrats,
                    context: context);
              }
              break;
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addTermToCartMessage,
                  state: ToastStates.error,
                  context: context);
              break;
            default:
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   AppBarSubscriptionsWidget(
                    childID: userData.userId,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      AppStrings.termSubscription,
                      style: const AppTextStyle().w600.s15.gray.bodyLarge16,
                    ),
                  ),
                  45.0.sizedBoxHeight,
                  BlocBuilder<FreeTermSubscriptionsBloc, FreeTermSubscriptionsState>(
                    builder: (context, state) {
                      switch (state.getSystemState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 40.responsiveHeight,
                          );
                        case RequestStates.loaded:
                          return DefaultDropDownButton<StudyingModel>(
                            studyingData: state.systems,
                            displayText: (system) => system.name,
                            selectedItem: state.currentSystem,
                            onChange: (value) {
                              state.currentSystem == value
                                  ? null
                                  : context
                                  .read<FreeTermSubscriptionsBloc>()
                                  .add(ChangeSystemFreeTermEvent(value!));
              
                            }
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    }
                  ),
                  45.0.sizedBoxHeight,
                  BlocBuilder<FreeTermSubscriptionsBloc,
                      FreeTermSubscriptionsState>(builder: (context, state) {
                    switch (state.getStagesState) {
                      case RequestStates.loading:
                        return LoadingShimmerStructure(
                          height: 40.responsiveHeight,
                        );
                      case RequestStates.loaded:
                        return DefaultDropDownButton<StudyingModel>(
                          studyingData: state.stages,
                          displayText: (stage) => stage.name,
                          selectedItem: state.currentStage,
                          onChange: (value) {
                            state.currentStage == value
                                ? null
                                : context
                                .read<FreeTermSubscriptionsBloc>()
                                .add(ChangeStageFreeTermEvent(value!));
                          },
                        );
                      default:
                        return const SizedBox();
                    }
                  }),
                  45.0.sizedBoxHeight,
                  BlocBuilder<FreeTermSubscriptionsBloc,
                      FreeTermSubscriptionsState>(builder: (context, state) {
                    switch (state.getClassRoomsState) {
                      case RequestStates.loading:
                        return LoadingShimmerStructure(
                          height: 40.responsiveHeight,
                        );
                      case RequestStates.loaded:
                        return DefaultDropDownButton<StudyingModel>(
                          studyingData: state.classRooms,
                          selectedItem: state.currentClassRoom,
                          displayText: (classRooms) => classRooms.name,
                          onChange: (value) {
                            state.currentClassRoom == value
                                ? null
                                : context
                                .read<FreeTermSubscriptionsBloc>()
                                .add(ChangeClassRoomFreeTermEvent(value!));
                          },
                        );
                      default:
                        return const SizedBox();
                    }
                  }),
                  45.0.sizedBoxHeight,
                  BlocBuilder<FreeTermSubscriptionsBloc,
                      FreeTermSubscriptionsState>(
                    builder: (context, state) {
                      switch (state.getTermsState) {
                        case RequestStates.loading:
                          return Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  AppStrings.chooseTerms,
                                  style: const AppTextStyle().w500.titleSmall18,
                                ),
                              ),
                              10.sizedBoxHeight,
                              const LoadingShimmerList(count: 2),
                            ],
                          );
                        case RequestStates.loaded:
                          if (state.terms.isEmpty) {
                            return const EmptyListWidgets(
                                message: 'لا يوجد فصول دراسيه الأن');
                          } else {
                            if(state.terms[0].isPath ?? false){
                              return Column(
                                children: [
                                  DefaultDropDownButton<StudyingModel>(
                                    displayText: (term) => term.name,
                                    selectedItem: state.currentTerm,
                                    studyingData: state.terms,
                                    onChange: (value) {
                                      state.currentTerm == value
                                          ? null
                                          : context
                                          .read<FreeTermSubscriptionsBloc>()
                                          .add(ChangeTermFreeTermEvent(value!));
                                    }
                                  ),
              
                                  AppSize.s16.sizedBoxHeight,
                                  ListView.builder(
                                    itemCount: state.paths.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (_, index) {
                                      return CustomSelectWidget(
                                        title: state.paths[index].name,
                                        price:  state.currentTerm.price ?? 0,
                                        onTap: () {
                                          AppAnalytics.logAddTermToCart(termName: state.terms[index].name,);
                                          context.read<PackagesBloc>().add(AddTermToCartEvent(AddItemToCartParameters(
                                            userID: userData.userId,
                                            id:  state.currentTerm.id,
                                            pathId: state.paths[index].id,
                                          ),));
                                        },
                                      );
                                    },
                                  )
              
                                ],
                              );
                            }else {
                              return ListView.builder(
                              itemCount: state.terms.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return CustomSelectWidget(
                                  title: state.terms[index].name,
                                  price: state.terms[index].price!,
                                  onTap: () {
                                    AppAnalytics.logAddTermToCart(termName: userData.termName!);
                                    context.read<PackagesBloc>().add(AddTermToCartEvent(AddItemToCartParameters(
                                      userID: userData.userId,
                                      id: state.terms[index].id,
                                    ),));
                                  },
                                );
                              },
                            );
                            }
                          }
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
              
                  10.sizedBoxHeight,
                  BlocBuilder<FreeTermSubscriptionsBloc,
                      FreeTermSubscriptionsState>(
                    builder: (context, state) {
                      switch (state.getTermsState) {
                        case RequestStates.loading:
                          return LoadingShimmerStructure(
                            height: 45.responsiveHeightRatio,
                            width: 210.responsiveWidth,
                          );
                        case RequestStates.loaded:
                          return  ToCartButton(childID: userData.userId,);
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ).paddingBody(),
        ),
      ),
    );
  }

}
