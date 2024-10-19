import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_widget/button_widget.dart';
import '../../../../../core/shared_widget/default_drop_down_button.dart';
import '../../../../../core/shared_widget/text_with_underline.dart';
import '../../../../../my_app/app_reference.dart';
import '../../../child_subscriptions/domain/entity/child_subscriptions_studying_entity.dart';
import '../domain/repository/repository.dart';
import '../optional_subject_bloc/optional_subject_bloc_bloc.dart';
import '../optional_subject_bloc/optional_subject_bloc_event.dart';
import '../optional_subject_bloc/optional_subject_bloc_state.dart';

void showChoosingOptionalSubjectsDialog({
  List<ChildSubscriptionsStudyingEntity>? allPaths,
  required List<ChildSubscriptionsStudyingEntity> allTerms,
  required List<ChildSubscriptionsStudyingEntity> allSubjects,
  required BuildContext context,
  required int childId,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AddOptionalSubjectDialog(
      allTerms: allTerms,
      allSubjects: allSubjects,
      allPaths: allPaths,
      childId: childId,
    ),
  );
}

class AddOptionalSubjectDialog extends StatelessWidget {
  final List<ChildSubscriptionsStudyingEntity>? allPaths;
  final List<ChildSubscriptionsStudyingEntity> allTerms;
  final List<ChildSubscriptionsStudyingEntity> allSubjects;
  final int childId;
  const AddOptionalSubjectDialog({
    super.key,
    required this.allTerms,
    required this.allSubjects,
    this.allPaths,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: BlocProvider(
          create: (_) => getIt<OptionalSubjectBlocBloc>(),
          child: Builder(builder: (providerContext) {
            ChildSubscriptionsStudyingEntity item = allSubjects.first;
            Map<int, int> select = {};
            for (var element in allTerms) {
              select.addAll({element.id: allSubjects.first.id});
            }
            return BlocListener<OptionalSubjectBlocBloc,
                OptionalSubjectBlocState>(
              listener: (context, state) {
                switch (state.addOptinalSubjectsForClassroomState) {
                  case RequestStates.loading:
                    showLoadingDialog(context);
                    break;
                  case RequestStates.loaded:
                    Navigator.pop(context);
                    showSnackBar(
                        description:
                            state.addOptinalSubjectsForClassroomMessage,
                        state: ToastStates.congrats,
                        context: context);
                    Navigator.pop(context);
                    break;
                  case RequestStates.error:
                    Navigator.pop(context);
                    showSnackBar(
                        description:
                            state.addOptinalSubjectsForClassroomMessage,
                        state: ToastStates.error,
                        context: context);
                    break;
                  default:
                }
              },
              child: AlertDialog(
                backgroundColor: AppColors.white,
                content: SizedBox(
                  width: AppReference.deviceWidth(context) * 0.9,
                  height: AppReference.deviceHeight(context) * 0.6,
                  child: Column(
                    children: [
                      const UnderLinedText(
                          text: 'برجاء اختيار ماده اختياريه في كل فصل'),
                      AppSize.s30.sizedBoxHeight,
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => Column(
                            children: [
                              Text(
                                allTerms[index].name,
                                style: AppTextStyle.titleMedium20,
                              ),
                              AppSize.s10.sizedBoxHeight,
                              StatefulBuilder(builder: (context, setState) {
                                return DefaultDropDownButton<
                                    ChildSubscriptionsStudyingEntity>(
                                  studyingData: allSubjects,
                                  selectedItem: item,
                                  displayText: (subject) => subject.name,
                                  onChange: (selectedValue) {
                                    setState(() {
                                      item = selectedValue!;
                                      select.update(allTerms[index].id,
                                          (value) => selectedValue.id);
                                    });
                        
                                    //   ;
                                  },
                                );
                              }),
                            ],
                          ),
                          separatorBuilder: (context, index) => Column(
                            children: [
                              const Divider(),
                              AppSize.s20.sizedBoxHeight,
                            ],
                          ),
                          itemCount: allTerms.length,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  DefaultButtonWidget(
                    label: 'تم',
                    onPressed: () {
                      BlocProvider.of<OptionalSubjectBlocBloc>(
                              providerContext)
                          .add(
                        AddOptionalSubjectEvent(
                          addOptionalSubjectParameters:
                              AddOptionalSubjectParameters(
                            termIds: select.keys.toList(),
                            subjectsIds: select.values.toList(),
                            addTo: OptionalSubjectType.toClassroom,
                            childId: childId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

void showChoosingOptionalSubjectsDialogForTerm({
  required int termId,
  required List<ChildSubscriptionsStudyingEntity> allSubjects,
  required BuildContext context,
  required int childId,

}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AddOptionalSubjectDialogForTerm(
      termId: termId,
      allSubjects: allSubjects,
      childId: childId,
    ),
  );
}

class AddOptionalSubjectDialogForTerm extends StatelessWidget {
  final int termId;
  final List<ChildSubscriptionsStudyingEntity> allSubjects;
  final int childId;

  const AddOptionalSubjectDialogForTerm({
    super.key,
    required this.termId,
    required this.allSubjects,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: BlocProvider(
          create: (_) => getIt<OptionalSubjectBlocBloc>(),
          child: Builder(builder: (providerContext) {
            ChildSubscriptionsStudyingEntity item = allSubjects.first;

            return BlocListener<OptionalSubjectBlocBloc,
                OptionalSubjectBlocState>(
              listener: (context, state) {
                switch (state.addOptinalSubjectsForClassroomState) {
                  case RequestStates.loading:
                    showLoadingDialog(context);
                    break;
                  case RequestStates.loaded:
                    Navigator.pop(context);
                    showSnackBar(
                        description:
                            state.addOptinalSubjectsForClassroomMessage,
                        state: ToastStates.congrats,
                        context: context);
                    Navigator.pop(context);
                    break;
                  case RequestStates.error:
                    Navigator.pop(context);
                    showSnackBar(
                        description:
                            state.addOptinalSubjectsForClassroomMessage,
                        state: ToastStates.error,
                        context: context);
                    break;
                  default:
                }
              },
              child: SingleChildScrollView(
                child: AlertDialog(
                  backgroundColor: AppColors.white,
                  content: SizedBox(
                    width: AppReference.deviceWidth(context) * 0.9,
                    height: AppReference.deviceHeight(context) * 0.2,
                    child: Column(
                      children: [
                        const UnderLinedText(
                            text: 'برجاء اختيار ماده اختياريه'),
                        AppSize.s30.sizedBoxHeight,
                        StatefulBuilder(builder: (context, setState) {
                          return DefaultDropDownButton<
                              ChildSubscriptionsStudyingEntity>(
                            studyingData: allSubjects,
                            selectedItem: item,
                            displayText: (subject) => subject.name,
                            onChange: (selectedValue) {
                              setState(() {
                                item = selectedValue!;
                              });

                              //   ;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  actions: [
                    DefaultButtonWidget(
                      label: 'تم',
                      onPressed: () {
                        BlocProvider.of<OptionalSubjectBlocBloc>(
                                providerContext)
                            .add(
                          AddOptionalSubjectEvent(
                            addOptionalSubjectParameters:
                                AddOptionalSubjectParameters(
                              termIds: [termId],
                              subjectsIds: [item.id],
                              addTo: OptionalSubjectType.toTerm,
                              childId: childId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
