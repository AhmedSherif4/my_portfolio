import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view/wisget/term_item_for_all_subscription.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../../config/resources/app_colors.dart';
import '../../../../../../../config/resources/app_text_style.dart';
import '../../../../domain/entity/all_subscription_entity.dart';
import '../../view_model/all_subscription_bloc.dart';

class AllSubscriptionBuilder extends StatelessWidget {
  final int childId;

  const AllSubscriptionBuilder({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.responsiveSize),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.responsiveSize),
      ),
      child: BlocBuilder<AllSubscriptionBloc, AllSubscriptionState>(
        builder: (context, state) {
          switch (state.getAllSubscriptionState) {
            case RequestStates.loading:
              return const LoadingShimmerList();
            case RequestStates.loaded:
              if (state.allSubscription.isEmpty) {
                return const EmptyListWidgets(
                    message: AppStrings.notSubscription);
              } else {
                return AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?
                GridView.builder(gridDelegate: const
                SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 4/2.3,
                    crossAxisCount: 2),
                  itemBuilder: (context, classroomIndex) => AllSubscriptionItem(
                    classroomName:
                    state.allSubscription[classroomIndex].classroomName,
                    classroomAllTerm:
                    state.allSubscription[classroomIndex].allTerms,
                    childId: childId,
                  ),
                  itemCount: state.allSubscription.length,
                ):
                ListView.separated(
                  itemBuilder: (context, classroomIndex) => AllSubscriptionItem(
                    classroomName:
                        state.allSubscription[classroomIndex].classroomName,
                    classroomAllTerm:
                        state.allSubscription[classroomIndex].allTerms,
                    childId: childId,
                  ),
                  separatorBuilder: (context, index) => 15.sizedBoxHeight,
                  itemCount: state.allSubscription.length,
                );
              }
            case RequestStates.error:
              return CustomErrorWidget(
                  errorMessage: state.getAllSubscriptionErrorMessage);
            default:
              return const SizedBox.shrink();
          }
        },
      ).paddingBody(),
    );
  }
}

class AllSubscriptionItem extends StatelessWidget {
  final String classroomName;
  final List<Term> classroomAllTerm;
  final int childId;

  const AllSubscriptionItem({
    super.key,
    required this.classroomName,
    required this.classroomAllTerm,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.responsiveSize),
      decoration:
          AppConstants.containerDecoration(backgroundColor: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            classroomName,
            style: AppTextStyle.bodyLarge16,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          5.sizedBoxHeight,
          const Divider(
            height: 5,
            color: AppColors.textColor4,
          ).paddingBody(top: 10, bottom: 10),
          Text(
            'الفصول المتاحة',
            textAlign: TextAlign.start,
            style: AppTextStyle.bodyLarge16,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          10.sizedBoxHeight,
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, termIndex) => TermItemForAllSubscription(
              isSubscriptionTerm: classroomAllTerm[termIndex].isSubscribe,
              termName: classroomAllTerm[termIndex].name,
              termOnTap: () {
                RouteManager.rPushNamed(
                    context: context,
                    rName: AppRoutesNames.rAllSubscriptionSubjectScreen,
                    arguments: ParameterGoToQuestions(
                      stageId: classroomAllTerm[termIndex].stageId,
                      classRoomId: classroomAllTerm[termIndex].classroomId,
                      termId: classroomAllTerm[termIndex].termId,
                      systemId: 1,
                      pathId: classroomAllTerm[termIndex].pathId,
                      userId: childId,
                      subjectType: SubjectType.subscriptions,
                    ));
              },
            ),
              separatorBuilder: (context, termIndex) => 5.sizedBoxHeight,
            itemCount: classroomAllTerm.length,
          ),
        ],
      ),
    );
  }
}
