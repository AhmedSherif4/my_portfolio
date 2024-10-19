import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/presentation/view_model/packages_bloc.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/presentation/view_model/packages_event.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/presentation/view_model/packages_state.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/widgets/to_cart_button.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_widget/empty_list_widget.dart';
import '../../../../../core/shared_widget/error_widget.dart';
import '../../../../../core/shared_widget/loading_shimmer_list.dart';
import '../../data/subject_data.dart';
import '../../packages/domain/repository/packages_repository.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/subjects_subscription_and_packages_item.dart';
import '../view_model/subscriptions_and_packages_subjects_bloc.dart';
import '../view_model/subscriptions_and_packages_subjects_event.dart';
import '../view_model/subscriptions_and_packages_subjects_state.dart';

class SubjectsSubscriptionScreen extends StatelessWidget {

  final GoToSubjectData goToSubjectData;

  const SubjectsSubscriptionScreen({
    super.key, required this.goToSubjectData,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          getIt<SubscriptionsAndPackagesSubjectsBloc>()
            ..add(
              GetSubscriptionsAndPackagesSubjectsEvent(goToSubjectData.getSubjectsParameters),
            ),
        ),
        BlocProvider(
          create: (context) => getIt<PackagesBloc>(),
        ),
      ],
      child: BlocListener<PackagesBloc, PackagesState>(
        listener: (context, state) {
          switch (state.addSubjectToCartState) {
            case RequestStates.loading:
              showLoadingDialog(context);
              break;
            case RequestStates.loaded:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addSubjectToCartMessage,
                  state: ToastStates.congrats,
                  context: context);
              break;
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addSubjectToCartMessage,
                  state: ToastStates.error,
                  context: context);
              break;
            default:
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: ResponsiveWidgetForTablet(
              mobile: Column(
                children: [
                   AppBarSubscriptionsWidget(childID: goToSubjectData.userData!.userId,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              AppStrings.chooseSubjects,
                              style: const AppTextStyle().w500.titleSmall18,
                            ),
                          ),
                          10.sizedBoxHeight,
                          BlocBuilder<SubscriptionsAndPackagesSubjectsBloc,
                              SubscriptionsAndPackagesSubjectsState>(
                            builder: (context, state) {
                              switch (state.subjectsStates) {
                                case RequestStates.loading:
                                  return const LoadingShimmerList();
                                case RequestStates.error:
                                  return Center(
                                    child: CustomErrorWidget(
                                      errorMessage: state.subjectsErrorMessage,
                                    ),
                                  );
                                case RequestStates.loaded:
                                  if (state.subjects.isEmpty) {
                                    return const EmptyListWidgets(
                                        message: 'لا يوجد مواد الأن');
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.subjects.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return CustomSelectWidget(
                                          title: state.subjects[index].subjectName,
                                          price: state.subjects[index].price,
                                          onTap: () {
                                            AppAnalytics.logAddSubjectToCart(subjectName: state.subjects[index].subjectName,);
                                            context.read<PackagesBloc>().add(AddSubjectToCartEvent(AddItemToCartParameters(
                                              userID: goToSubjectData.userData!.userId,
                                              id: state.subjects[index].subjectId,
                                            ),));
                                          },
                                        );
                                      },
                                    );
                                  }
                                default:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.sizedBoxHeight,
                   ToCartButton(childID: goToSubjectData.userData!.userId),
                ],
              ),
              tablet: Column(
                children: [
                  AppBarSubscriptionsWidget(childID: goToSubjectData.userData!.userId,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: AppReference.deviceWidth(context)*.4,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                AppStrings.chooseSubjects,
                                style: const AppTextStyle().w500.titleSmall18,
                              ),
                            ),
                            10.sizedBoxHeight,
                            BlocBuilder<SubscriptionsAndPackagesSubjectsBloc,
                                SubscriptionsAndPackagesSubjectsState>(
                              builder: (context, state) {
                                switch (state.subjectsStates) {
                                  case RequestStates.loading:
                                    return const LoadingShimmerList();
                                  case RequestStates.error:
                                    return Center(
                                      child: CustomErrorWidget(
                                        errorMessage: state.subjectsErrorMessage,
                                      ),
                                    );
                                  case RequestStates.loaded:
                                    if (state.subjects.isEmpty) {
                                      return const EmptyListWidgets(
                                          message: 'لا يوجد مواد الأن');
                                    } else {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.subjects.length,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (_, index) {
                                          return CustomSelectWidget(
                                            title: state.subjects[index].subjectName,
                                            price: state.subjects[index].price,
                                            onTap: () {
                                              AppAnalytics.logAddSubjectToCart(subjectName: state.subjects[index].subjectName,);
                                              context.read<PackagesBloc>().add(AddSubjectToCartEvent(AddItemToCartParameters(
                                                userID: goToSubjectData.userData!.userId,
                                                id: state.subjects[index].subjectId,
                                              ),));
                                            },
                                          );
                                        },
                                      );
                                    }
                                  default:
                                    return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.sizedBoxHeight,
                  SizedBox(
                      width: AppReference.deviceIsTablet? AppReference.deviceWidth(context)*.4:AppReference.deviceWidth(context),
                      child: ToCartButton(childID: goToSubjectData.userData!.userId)),
                ],
              ),
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}
