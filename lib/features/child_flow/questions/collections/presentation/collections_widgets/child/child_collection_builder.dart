import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/lock_widget.dart';
import 'package:my_portfolio/core/shared_widget/painters/collection_item_custom_paint.dart';
import 'package:my_portfolio/core/shared_widget/term_and_group_child_item.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/shared_functions/question_shared_funtion.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../../config/resources/app_constants.dart';
import '../../../../../../../config/routes/route_manager.dart';
import '../../../../../../../config/routes/routes_names.dart';
import '../../../../../../../core/enum/enum_generation.dart';
import '../../../../../../../core/shared_widget/loading_shimmer_list.dart';
import '../../../../shared/data/go_to_questions_data.dart';
import '../../../collections.dart';

class ChildCollectionBuilder extends StatelessWidget {
  final DataToGoQuestions data;

  const ChildCollectionBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsBloc, CollectionsState>(
      builder: (context, state) {
        switch (state.collectionsStates) {
          case RequestStates.loading:
            return const LoadingShimmerList();
          case RequestStates.loaded:
            if (state.collections.isEmpty) {
              return const EmptyListWidgets(message: AppStrings.noCollectionFound);
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => LockWidgets(
                  lockWidget: TermAndGroupForChildItem(
                    onTap: () {
                      if(!AppReference.userIsGuest()){
                      final addCollectionIdToData = data.copyWith(
                        collectionId: state.collections[index].id,
                        collectionEntity: state.collections[index],
                        itemIndex: index,
                      );
                      RouteManager.rPushNamedAndRemoveUntil(
                        context: context,
                        rName: AppRoutesNames.rQuestionsScreen,
                        arguments: addCollectionIdToData,
                      );}else{
                        AppReference.guestDialogMustLogin(context);
                      }
                    },
                    text: state.collections[index].name,
                    painter: GroupCustomPaint(),
                  ),
                  isLocked: QuestionSharedFunction.checkIsLock(
                    index: index,
                    userQuestionPoints: index == 0
                        ? state.collections[index].userPoints
                        : state.collections[index - 1].userPoints,
                    skipQuestionPoints: index == 0
                        ? state.collections[index].skipPoints
                        : state.collections[index - 1].skipPoints,
                  ),
                  textLock: AppStrings.skipPreviousCollection,
                ).animateRightLeft(duration: AppConstants.animationTime),
                separatorBuilder: (context, index) => 15.sizedBoxHeight,
                itemCount: state.collections.length,
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(
                errorMessage: state.collectionsErrorMessage);
          default:
            return const SizedBox();
        }
      },
    );

  }
}
