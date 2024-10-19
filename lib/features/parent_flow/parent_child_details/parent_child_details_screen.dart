import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../config/resources/app_assets.dart';
import '../../../config/resources/app_colors.dart';
import '../../../config/resources/app_text_style.dart';
import '../../../config/routes/route_manager.dart';
import '../../../config/routes/routes_names.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../core/shared_widget/nullable_network_image.dart';
import '../../child_flow/exams/exams/data_to_go_exams.dart';
import '../../institution_flow/institution_shared_widget/institution_header.dart';
import '../../intro/global/global_view_model/global_bloc.dart';
import '../../shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view/data_to_go_random_exams.dart';
import '../../shared_features/more/more_widgets/more_widgets.dart';
import '../../shared_features/subjects_shared_features/subjects_shared_features.dart';
import '../../shared_features/un_link/un_link.dart';

class ParentChildDetailsScreen extends StatelessWidget {
  final UserEntity childData;

  const ParentChildDetailsScreen({super.key, required this.childData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UnLinkBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: ResponsiveWidgetForTablet(
            mobile: Column(
              children: [
                const InstitutionAndParentHeader(
                  title: AppStrings.myChilds,
                ),
                20.sizedBoxHeight,
                SizedBox(
                  height: AppReference.deviceHeight(context) *
                      0.11.responsiveHeightRatio,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.zero,
                          alignment: AlignmentDirectional.center,
                          height: AppReference.deviceHeight(context) *
                              0.12.responsiveHeightRatio,
                          width: AppReference.deviceWidth(context) * 0.25,
                          decoration: ShapeDecoration(
                            color: AppColors.white,
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 0.50.responsiveSize,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          child: NullableNetworkImage(
                            imagePath: childData.imgPath ?? '',
                            notHaveImage: childData.imgPath == null ||
                                childData.imgPath!.isEmpty,
                            height: 50.responsiveSize,
                            width: 50.responsiveSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      20.sizedBoxWidth,
                      Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                childData.name,
                                style: AppTextStyle.bodyLarge16
                                    .copyWith(fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                childData.classroomName ?? '',
                                style: AppTextStyle.bodyMedium14,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                15.sizedBoxHeight,
                const Divider(
                  height: 5,
                  color: AppColors.textColor6,
                ).paddingBody(),
                20.sizedBoxHeight,
                DefaultButtonWithIcon(
                  title: 'أداء الطالب وبياناته',
                  backgroundColor: AppColors.primaryColor,
                  svgIconPath: AppImagesAssets.sRobot,
                  onTap: () {
                    RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                      arguments:DataToGoRandomExams(
                          isRandomExam: false,
                          user: childData,
                          isPrimary: AppReference.childIsPrimary())
                      ,
                    );
                  },
                ),
                DefaultButtonWithIcon(
                  title: 'عرض كل الاشتراكات',
                  backgroundColor: AppColors.primaryColor,
                  svgIconPath: AppImagesAssets.sStages,
                  onTap: () {
                    RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rAllSubscriptionClassroomScreen,
                      arguments: childData,
                    );
                  },
                ),
                if (AppReference.userIsParent())
                  DefaultButtonWithIcon(
                    title: 'إضافة اشتراك',
                    backgroundColor: AppColors.primaryColor,
                    svgIconPath: AppImagesAssets.sSubjectSubscriptionImage,
                    onTap: BlocProvider.of<GlobalBloc>(context)
                                .state
                                .appVersionModel
                                .inReview2 ==
                            true
                        ? () {
                            RouteManager.rPushNamed(
                                context: context,
                                rName: AppRoutesNames.rSubFLow);
                          }
                        : () {
                            RouteManager.rPushNamed(
                              context: context,
                              rName: AppRoutesNames.rNewSubscriptionsScreen,
                              arguments: childData,
                            );
                          },
                  ),
                if (AppReference.userIsParent() &&
                    !BlocProvider.of<GlobalBloc>(context)
                        .state
                        .appVersionModel
                        .inReview2)
                  DefaultButtonWithIcon(
                    title: 'الاختبارات المحاكية لنافس',
                    backgroundColor: AppColors.primaryColor,
                    svgIconPath: AppImagesAssets.sVector,
                    onTap: () {
                      RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rNafeesPlanScreen,
                        arguments: childData.userId,
                      );
                    },
                  ),
                if (AppReference.userIsParent() &&
                    !BlocProvider.of<GlobalBloc>(context)
                        .state
                        .appVersionModel
                        .inReview2)
                  DefaultButtonWithIcon(
                    title: 'الاختبارات المحاكية للقدرات',
                    backgroundColor: AppColors.primaryColor,
                    svgIconPath: AppImagesAssets.sVector,
                    onTap: () {
                      RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rSimulatedExamsScreen,
                        arguments: childData.userId,
                      );
                    },
                  ),
                if (AppReference.userIsParent() &&
                    !BlocProvider.of<GlobalBloc>(context)
                        .state
                        .appVersionModel
                        .inReview2)
                  BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                    builder: (context, state) {
                      return DefaultButtonWithIcon(
                        title: 'اختبارات ذاتية',
                        backgroundColor: AppColors.primaryColor,
                        svgIconPath: AppImagesAssets.sVector,
                        onTap: () {
                          RouteManager.rPushNamed(
                            context: context,
                            rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                            arguments:DataToGoRandomExams(
                                isRandomExam: true,
                                dataToGoExams: DataToGoExams(
                                  isPrimary: AppReference.childIsPrimary(),
                                  subjects: state.subjects,
                                  user: childData,
                                  isParent: true
                                ),
                                user: childData,
                                isPrimary: AppReference.childIsPrimary())
                            ,
                          );
                        },
                      );
                    },
                  ),
                if (AppReference.userIsParent())
                  UnLinkButton(
                      userId: childData.userId,
                      message: 'هل انت متاكد من الغاء الارتباط بالطفل؟'),
              ],
            ),
            tablet: OrientationItem(
              landscapeWidget: Column(
                children: [
                  const InstitutionAndParentHeader(
                    title: AppStrings.myChilds,
                  ),
                  20.sizedBoxHeight,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppReference.deviceHeight(context) *
                              0.06.responsiveHeightRatio,
                          width: AppReference.deviceWidth(context) * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                alignment: AlignmentDirectional.center,
                                height: AppReference.deviceHeight(context) *
                                    0.07.responsiveHeightRatio,
                                width: AppReference.deviceWidth(context) * 0.07,
                                decoration: ShapeDecoration(
                                  color: AppColors.white,
                                  shape: OvalBorder(
                                    side: BorderSide(
                                      width: 0.50.responsiveSize,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                child: NullableNetworkImage(
                                  imagePath: childData.imgPath ?? '',
                                  notHaveImage: childData.imgPath == null ||
                                      childData.imgPath!.isEmpty,
                                  height: 40.responsiveSize,
                                  width: 40.responsiveSize,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              20.sizedBoxWidth,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    childData.name,
                                    style: AppTextStyle.bodyLarge16
                                        .copyWith(fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    childData.classroomName ?? '',
                                    style: AppTextStyle.bodyMedium14,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: AppReference.deviceWidth(context) * 0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                20.sizedBoxHeight,
                                DefaultButtonWithIcon(
                                  title: 'أداء الطالب وبياناته',
                                  backgroundColor: AppColors.primaryColor,
                                  svgIconPath: AppImagesAssets.sRobot,
                                  onTap: () {
                                    RouteManager.rPushNamed(
                                      context: context,
                                      rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                                      arguments:DataToGoRandomExams(
                                          isRandomExam: false,
                                          user: childData,
                                          isPrimary: AppReference.childIsPrimary())
                                    );
                                  },
                                ),
                                DefaultButtonWithIcon(
                                  title: 'عرض كل الاشتراكات',
                                  backgroundColor: AppColors.primaryColor,
                                  svgIconPath: AppImagesAssets.sStages,
                                  onTap: () {
                                    RouteManager.rPushNamed(
                                      context: context,
                                      rName: AppRoutesNames
                                          .rAllSubscriptionClassroomScreen,
                                      arguments: childData,
                                    );
                                  },
                                ),
                                if (AppReference.userIsParent())
                                  DefaultButtonWithIcon(
                                    title: 'إضافة اشتراك',
                                    backgroundColor: AppColors.primaryColor,
                                    svgIconPath: AppImagesAssets.sSubjectSubscriptionImage,
                                    onTap: BlocProvider.of<GlobalBloc>(context)
                                        .state
                                        .appVersionModel
                                        .inReview2 ==
                                        true
                                        ? () {
                                      RouteManager.rPushNamed(
                                          context: context,
                                          rName: AppRoutesNames.rSubFLow);
                                    }
                                        : () {
                                      RouteManager.rPushNamed(
                                        context: context,
                                        rName: AppRoutesNames.rNewSubscriptionsScreen,
                                        arguments: childData,
                                      );
                                    },
                                  ),
                                if (AppReference.userIsParent() &&
                                    !BlocProvider.of<GlobalBloc>(context)
                                        .state
                                        .appVersionModel
                                        .inReview2)
                                  DefaultButtonWithIcon(
                                    title: 'الاختبارات المحاكية لنافس',
                                    backgroundColor: AppColors.primaryColor,
                                    svgIconPath: AppImagesAssets.sVector,
                                    onTap: () {
                                      RouteManager.rPushNamed(
                                        context: context,
                                        rName: AppRoutesNames.rNafeesPlanScreen,
                                        arguments: childData.userId,
                                      );
                                    },
                                  ),
                                if (AppReference.userIsParent() &&
                                    !BlocProvider.of<GlobalBloc>(context)
                                        .state
                                        .appVersionModel
                                        .inReview2)
                                  DefaultButtonWithIcon(
                                    title: 'الاختبارات المحاكية للقدرات',
                                    backgroundColor: AppColors.primaryColor,
                                    svgIconPath: AppImagesAssets.sVector,
                                    onTap: () {
                                      RouteManager.rPushNamed(
                                        context: context,
                                        rName: AppRoutesNames.rSimulatedExamsScreen,
                                        arguments: childData.userId,
                                      );
                                    },
                                  ),
                                // if (AppReference.userIsParent() &&
                                //     !BlocProvider.of<GlobalBloc>(context)
                                //         .state
                                //         .appVersionModel
                                //         .inReview2)
                                //   DefaultButtonWithIcon(
                                //     title: 'اختبارات نافس',
                                //     backgroundColor: AppColors.primaryColor,
                                //     svgIconPath: AppImagesAssets.sVector,
                                //     onTap: () {
                                //       RouteManager.rPushNamed(
                                //         context: context,
                                //         rName: AppRoutesNames.rNafeesPlanScreen,
                                //         arguments: childData.userId,
                                //       );
                                //     },
                                //   ),
                                if (AppReference.userIsParent() &&
                                    !BlocProvider.of<GlobalBloc>(context)
                                        .state
                                        .appVersionModel
                                        .inReview2)
                                  BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                                    builder: (context, state) {
                                      return DefaultButtonWithIcon(
                                        title: 'اختبارات ذاتية',
                                        backgroundColor: AppColors.primaryColor,
                                        svgIconPath: AppImagesAssets.sVector,
                                        onTap: () {
                                          RouteManager.rPushNamed(
                                            context: context,
                                            rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                                            arguments:DataToGoRandomExams(
                                                isRandomExam: true,
                                                dataToGoExams: DataToGoExams(
                                                  isPrimary: AppReference.childIsPrimary(),
                                                  subjects: state.subjects,
                                                  user: childData,
                                                  isParent: true
                                                ),
                                                user: childData,
                                                isPrimary: AppReference.childIsPrimary())
                                            ,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                if (AppReference.userIsParent())
                                  UnLinkButton(
                                      userId: childData.userId,
                                      message:
                                      'هل انت متاكد من الغاء الارتباط بالطفل؟'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // 15.sizedBoxHeight,
                  // const Divider(
                  //   height: 5,
                  //   color: AppColors.textColor6,
                  // ).paddingBody(),
                ],
              ),
              portraitWidget: Column(
                children: [
                  const InstitutionAndParentHeader(
                    title: AppStrings.myChilds,
                  ),
                  20.sizedBoxHeight,
                  SizedBox(
                    height: AppReference.deviceHeight(context) *
                        0.11.responsiveHeightRatio,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.zero,
                            alignment: AlignmentDirectional.center,
                            height: AppReference.deviceHeight(context) *
                                0.12.responsiveHeightRatio,
                            width: AppReference.deviceWidth(context) * 0.25,
                            decoration: ShapeDecoration(
                              color: AppColors.white,
                              shape: OvalBorder(
                                side: BorderSide(
                                  width: 0.50.responsiveSize,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            child: NullableNetworkImage(
                              imagePath: childData.imgPath ?? '',
                              notHaveImage: childData.imgPath == null ||
                                  childData.imgPath!.isEmpty,
                              height: 50.responsiveSize,
                              width: 50.responsiveSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        20.sizedBoxWidth,
                        Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  childData.name,
                                  style: AppTextStyle.bodyLarge16
                                      .copyWith(fontWeight: FontWeight.w700),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  childData.classroomName ?? '',
                                  style: AppTextStyle.bodyMedium14,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  15.sizedBoxHeight,
                  const Divider(
                    height: 5,
                    color: AppColors.textColor6,
                  ).paddingBody(),
                  20.sizedBoxHeight,
                  DefaultButtonWithIcon(
                    title: 'أداء الطالب وبياناته',
                    backgroundColor: AppColors.primaryColor,
                    svgIconPath: AppImagesAssets.sRobot,
                    onTap: () {
                      RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                        arguments: DataToGoRandomExams(
                            isRandomExam: false,
                            user: childData,
                            isPrimary: AppReference.childIsPrimary())
                      );
                    },
                  ),
                  DefaultButtonWithIcon(
                    title: 'عرض كل الاشتراكات',
                    backgroundColor: AppColors.primaryColor,
                    svgIconPath: AppImagesAssets.sStages,
                    onTap: () {
                      RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rAllSubscriptionClassroomScreen,
                        arguments: childData,
                      );
                    },
                  ),
                  if (AppReference.userIsParent())
                    DefaultButtonWithIcon(
                      title: 'إضافة اشتراك',
                      backgroundColor: AppColors.primaryColor,
                      svgIconPath: AppImagesAssets.sSubjectSubscriptionImage,
                      onTap: BlocProvider.of<GlobalBloc>(context)
                          .state
                          .appVersionModel
                          .inReview2 ==
                          true
                          ? () {
                        RouteManager.rPushNamed(
                            context: context,
                            rName: AppRoutesNames.rSubFLow);
                      }
                          : () {
                        RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rNewSubscriptionsScreen,
                          arguments: childData,
                        );
                      },
                    ),
                  if (AppReference.userIsParent() &&
                      !BlocProvider.of<GlobalBloc>(context)
                          .state
                          .appVersionModel
                          .inReview2)
                    DefaultButtonWithIcon(
                      title: 'الاختبارات المحاكية لنافس',
                      backgroundColor: AppColors.primaryColor,
                      svgIconPath: AppImagesAssets.sVector,
                      onTap: () {
                        RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rNafeesPlanScreen,
                          arguments: childData.userId,
                        );
                      },
                    ),
                  if (AppReference.userIsParent() &&
                      !BlocProvider.of<GlobalBloc>(context)
                          .state
                          .appVersionModel
                          .inReview2)
                    DefaultButtonWithIcon(
                      title: 'الاختبارات المحاكية للقدرات',
                      backgroundColor: AppColors.primaryColor,
                      svgIconPath: AppImagesAssets.sVector,
                      onTap: () {
                        RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rSimulatedExamsScreen,
                          arguments: childData.userId,
                        );
                      },
                    ),
                  // if (AppReference.userIsParent() &&
                  //     !BlocProvider.of<GlobalBloc>(context)
                  //         .state
                  //         .appVersionModel
                  //         .inReview2)
                  //   DefaultButtonWithIcon(
                  //     title: 'اختبارات نافس',
                  //     backgroundColor: AppColors.primaryColor,
                  //     svgIconPath: AppImagesAssets.sVector,
                  //     onTap: () {
                  //       RouteManager.rPushNamed(
                  //         context: context,
                  //         rName: AppRoutesNames.rNafeesPlanScreen,
                  //         arguments: childData.userId,
                  //       );
                  //     },
                  //   ),
                  if (AppReference.userIsParent() &&
                      !BlocProvider.of<GlobalBloc>(context)
                          .state
                          .appVersionModel
                          .inReview2)
                    BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
                      builder: (context, state) {
                        return DefaultButtonWithIcon(
                          title: 'اختبارات ذاتية',
                          backgroundColor: AppColors.primaryColor,
                          svgIconPath: AppImagesAssets.sVector,
                          onTap: () {
                            RouteManager.rPushNamed(
                              context: context,
                              rName: AppRoutesNames.rSubscriptionsSystemsScreen,
                              arguments:DataToGoRandomExams(
                                  isRandomExam: true,
                                  dataToGoExams: DataToGoExams(
                                    isPrimary: AppReference.childIsPrimary(),
                                    subjects: state.subjects,
                                    user: childData,
                                  ),
                                  user: childData,
                                  isPrimary: AppReference.childIsPrimary()),
                            );
                          },
                        );
                      },
                    ),
                  if (AppReference.userIsParent())
                    UnLinkButton(
                        userId: childData.userId,
                        message: 'هل انت متاكد من الغاء الارتباط بالطفل؟'),
                ],
              ),
            ),
          ),
        ).paddingBody(),
      ),
    );
  }
}
