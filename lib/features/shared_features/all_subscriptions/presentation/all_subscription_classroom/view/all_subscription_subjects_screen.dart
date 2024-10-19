import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view/wisget/all_subscription_header.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_constants.dart';
import '../../../../../../config/resources/app_text_style.dart';
import '../../../../../../config/resources/app_values.dart';
import '../../../../../../config/responsive/responsive.dart';
import '../../../../subjects_shared_features/subjects_shared_features.dart';

class AllSubscriptionSubjectScreen extends StatelessWidget {
  final ParameterGoToQuestions subscriptionIds;

  const AllSubscriptionSubjectScreen(
      {super.key, required this.subscriptionIds});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<SharedSubjectsBloc>()
         ..add(GetSharedSubjectsEvent(
             parameter: subscriptionIds)),
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            const AllSubscriptionHeader(
                title: 'تفاصيل الاشتراك', body: 'المواد المشترك فيها'),
            50.sizedBoxHeight,
            Expanded(
                child: BlocBuilder<SharedSubjectsBloc,
                  SharedSubjectsState>(
                builder: (context, state) {
                  switch (state.getSubjectsState) {
                    case RequestStates.loading:
                      return LoadingShimmerList(
                        height: 120.responsiveHeight,
                      );
                    case RequestStates.loaded:
                      return AppReference.deviceIsTablet&&!AppReference.isPortrait(context) ?
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                          childAspectRatio: 12/2,
                        ),
                        itemBuilder: (context, index) =>
                            AllSubscriptionSubjectItem(
                                subjectName: state.subjects[index].subjectName),
                        itemCount: state.subjects.length,
                      )
                      :ListView.separated(
                        itemBuilder: (context, index) =>
                            AllSubscriptionSubjectItem(
                                subjectName: state.subjects[index].subjectName),
                        separatorBuilder: (context, index) => 20.sizedBoxHeight,
                        itemCount: state.subjects.length,
                      );
                    case RequestStates.error:
                      return CustomErrorWidget(
                          errorMessage: state.getSubjectsStateMessage);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ).paddingBody(),
            ),
          ],
        )),
      ),
    );
  }
}

class AllSubscriptionSubjectItem extends StatelessWidget {
  final String subjectName;

  const AllSubscriptionSubjectItem({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s10.responsiveSize,
        vertical: AppSize.s6.responsiveSize,
      ),
      decoration: BoxDecoration(
        color:  AppColors.textColor6 ,
        borderRadius: BorderRadius.circular(
          AppConstants.appBorderRadiusR20.responsiveSize,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: ResponsiveManager.calculateRadius(20, 10),
            backgroundColor: AppColors.secondaryColor2,
            child: Icon(
              Icons.check,
              color: AppColors.white,
              size: 15.responsiveSize,
            ),
          ),
          10.sizedBoxWidth,
          Text(
            subjectName,
            style: AppTextStyle.bodyMedium14,
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,size: AppSize.s12.responsiveSize,)
        ],
      ),
    );
  }
}
