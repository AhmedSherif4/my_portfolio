import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../../../../../../../config/routes/route_manager.dart';
import '../../../../../../../config/routes/routes_names.dart';
import '../../../../../../../core/enum/enum_generation.dart';
import '../../../../../../../core/services/services_locator.dart';
import '../../../../../../../core/shared_widget/empty_list_widget.dart';
import '../../../../../../../core/shared_widget/error_widget.dart';
import '../../../../../../../core/shared_widget/loading_shimmer_list.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../../core/shared_widget/rank_button.dart';
import '../../../../../../my_app/app_reference.dart';
import '../../../../../child_flow/questions/shared/data/go_to_questions_data.dart';
import '../../../../more/more_widgets/more_widgets.dart';
import '../../../../more/presentation/more_widgets/header_for_more.dart';
import '../../../../rank/presentation/rank_screen/rank_data.dart';
import '../../../../statics/statics.dart';
import '../../../../subjects_shared_features/subjects_shared_features.dart';
import '../../../data/models/data_go_to_subscriptions_ques.dart';
import '../../subscriptions_systems_screen/view/data_to_go_random_exams.dart';

class SubscriptionsSubjectsScreen extends StatelessWidget {
  final DataGoToSubscriptionsQuestions data;

  const SubscriptionsSubjectsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SharedSubjectsBloc>()
        ..add(GetSharedSubjectsEvent(
            parameter: ParameterGoToQuestions(
                systemId: data.systemId,
                pathId: data.pathId,
                stageId: data.stageId,
                classRoomId: data.classRoomId,
                termId: data.termId,
                subjectType: SubjectType.subscriptions))),
      child: Scaffold(
        body: PopScope(
          canPop: false,
          onPopInvoked: (value) {
            RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rSubscriptionsSystemsScreen,
              arguments:DataToGoRandomExams(
                  isRandomExam: false,
                  user:  getIt<UserLocalDataSource>().getUserData()!,
                  isPrimary: AppReference.childIsPrimary())

            );
          },
          child: SafeArea(
            child: Column(
              children: [
                HeaderForMore(
                    title: AppStrings.subjects20,
                    onBack: () {
                      RouteManager.rPushNamedAndRemoveUntil(
                        context: context,
                        rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                        arguments:DataToGoRandomExams(
                            isRandomExam: false,
                            user: getIt<UserLocalDataSource>().getUserData()!,
                            isPrimary: AppReference.childIsPrimary()),
                      );
                    }),
                BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                  builder: (context, state) {
                    switch (state.getSubjectsState) {
                      case RequestStates.loading:
                        return const LoadingShimmerList();
                      case RequestStates.loaded:
                        if (state.subjects.isEmpty) {
                          return const EmptyListWidgets(
                              message: AppStrings.notSubscription);
                        } else {
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) =>
                                        ListTileWidget(
                                      title: state.subjects[index].subjectName,
                                      onTap: () {
                                        RouteManager.rPushNamedAndRemoveUntil(
                                          context: context,
                                          rName: AppRoutesNames
                                              .rLessonOrLevelScreen,
                                          arguments: DataToGoQuestions(
                                            systemId: data.systemId,
                                            subjectId:
                                                state.subjects[index].subjectId,
                                            notHaveImage: state.subjects[index]
                                                .subjectImg.isEmpty,
                                            isGeneralQuestions: false,
                                            imgUrl: state
                                                .subjects[index].subjectImg,
                                            subjectName: state
                                                .subjects[index].subjectName,
                                            isPrimary: data.stageId == 1 || data.stageId == 4,
                                            subjectsHaveUnits: state
                                                .subjects[index].isHaveUnit,
                                            stageId: data.stageId,
                                            classRoomId: data.classRoomId,
                                            termId: data.termId,
                                            subjects: state.subjects,
                                            pathId: data.pathId,
                                          ),
                                        );
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        15.sizedBoxHeight,
                                    itemCount: state.subjects.length,
                                  ),
                                ),
                                20.sizedBoxHeight,
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: DefaultButtonWidget(
                                        label: AppStrings.staticsTitle,
                                        width: double.infinity,
                                        onPressed: () {
                                          RouteManager.rPushNamed(
                                            context: context,
                                            rName:
                                                AppRoutesNames.rStaticsScreen,
                                            arguments: GetStaticsParam(
                                              stageId: data.stageId,
                                              termId: data.termId,
                                              classRoomId: data.classRoomId,
                                              allSubjects: state.subjects,
                                              subjectId: state
                                                  .subjects.first.subjectId,
                                              systemId: data.systemId,
                                              pathId: data.pathId,
                                              userData:
                                                  getIt<UserLocalDataSource>()
                                                      .getUserData(),
                                              classRoomName: data.classRoomName,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RankButton(
                                        rankData: RankData(
                                          systemId: data.systemId,
                                          stageId: data.stageId,
                                          termId: data.termId,
                                          classroomId: data.classRoomId,
                                          pathId: data.pathId,
                                          childId: getIt<UserLocalDataSource>()
                                              .getUserData()!
                                              .userId,
                                          className: data.classRoomName,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      case RequestStates.error:
                        return CustomErrorWidget(
                            errorMessage: state.getSubjectsStateMessage);
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }
}
