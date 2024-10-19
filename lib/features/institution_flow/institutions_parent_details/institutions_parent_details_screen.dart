import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/features/parent_flow/home/presentation/home_view_model/parent_home_bloc.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../config/resources/app_values.dart';
import '../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../core/shared_widget/add_parent_or_child_button.dart';
import '../../../core/shared_widget/child_widget_for_parent_and_institution.dart';
import '../institution_shared_widget/institution_header.dart';

class InstitutionParentDetailsScreen extends StatelessWidget {
  final UserEntity userData;

  const InstitutionParentDetailsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ParentHomeBloc>()
        ..add(GetAllChildForParentEvent(parentId: userData.userId)),
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ParentHomeBloc>().add(GetAllChildForParentEvent(parentId: userData.userId));

                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InstitutionAndParentHeader(
                        title: getIt<UserLocalDataSource>().getUserData()!.name,
                      ).paddingBody(),
                      AppSize.s20.sizedBoxHeight,
                      ResponsiveWidgetForTablet(
                        mobile: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: AppReference.deviceHeight(context) *
                                  0.1.responsiveHeightRatio,
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.responsiveHeight,
                                  horizontal: 10.responsiveWidth),
                              child: LayoutBuilder(builder: (context, constrains) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: constrains.maxWidth * 0.18,
                                      child: ClipOval(
                                        child: NullableNetworkImage(
                                          imagePath: userData.imgPath,
                                          notHaveImage: userData.imgPath!.isEmpty,
                                          width: double.infinity,
                                          height: constrains.maxHeight * 0.9,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    AppSize.s20.sizedBoxWidth,
                                    SizedBox(
                                      width: constrains.maxWidth * 0.6,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userData.name,
                                            style: AppTextStyle.bodyLarge16.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            userData.phone??"",
                                            style: AppTextStyle.bodyMedium14.copyWith(
                                                color: AppColors.textColor3,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.sizedBoxHeight,
                                  ],
                                );
                              }),
                            ),
                            30.sizedBoxHeight,
                            AddParentOrChildButton(
                              onTap: () {
                                RouteManager.rPushNamed(
                                  context: context,
                                  rName: AppRoutesNames.rInstitutionAddChildScreen,
                                  arguments: userData.userId,
                                );
                              },
                              alignmentDirectional: AlignmentDirectional.centerEnd,
                              buttonLabel: AppStrings.addStudents,
                              backgroundColor: AppColors.white,
                              svgPath: AppIconsAssets.sChild,
                            ).paddingBody(bottom: 0),
                            Align(
                              alignment: AlignmentDirectional.centerStart
                              ,
                              child: Text(
                                AppStrings.myStudents,
                                style: const AppTextStyle().w700.bodyLarge16,
                              ).paddingBody(bottom: 0),

                            ),
                            10.sizedBoxHeight,
                            const AllChildBuilder(
                            ).paddingBody(),
                          ],
                        ),
                        tablet: OrientationItem(
                          portraitWidget:  Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: AppReference.deviceHeight(context) *
                                    0.1.responsiveHeightRatio,
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.responsiveHeight,
                                    horizontal: 10.responsiveWidth),
                                child: LayoutBuilder(builder: (context, constrains) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: constrains.maxWidth * 0.18,
                                        child: ClipOval(
                                          child: NullableNetworkImage(
                                            imagePath: userData.imgPath,
                                            notHaveImage: userData.imgPath!.isEmpty,
                                            width: double.infinity,
                                            height: constrains.maxHeight * 0.9,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      AppSize.s20.sizedBoxWidth,
                                      SizedBox(
                                        width: constrains.maxWidth * 0.6,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userData.name,
                                              style: AppTextStyle.bodyLarge16.copyWith(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              userData.phone??"",
                                              style: AppTextStyle.bodyMedium14.copyWith(
                                                  color: AppColors.textColor3,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppSize.s10.sizedBoxHeight,
                                    ],
                                  );
                                }),
                              ),
                              AppSize.s30.sizedBoxHeight,
                              AddParentOrChildButton(
                                onTap: () {
                                  RouteManager.rPushNamed(
                                    context: context,
                                    rName: AppRoutesNames.rInstitutionAddChildScreen,
                                    arguments: userData.userId,
                                  );
                                },
                                alignmentDirectional: AlignmentDirectional.centerEnd,
                                buttonLabel: AppStrings.addStudents,
                                backgroundColor: AppColors.white,
                                svgPath: AppIconsAssets.sChild,
                              ).paddingBody(bottom: 0),
                              Align(
                                alignment: AlignmentDirectional.centerStart
                                ,
                                child: Text(
                                  AppStrings.myStudents,
                                  style: const AppTextStyle().w700.bodyLarge16,
                                ).paddingBody(bottom: 0),

                              ),
                              10.sizedBoxHeight,
                              const AllChildBuilder(
                              ).paddingBody(),
                            ],
                          ),
                          landscapeWidget:  Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: AppReference.deviceWidth(context) *.5,
                                    height: AppReference.deviceHeight(context) *
                                        0.08.responsiveHeightRatio,
                                    color: Colors.transparent,
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p5.responsiveHeight,
                                        horizontal: AppPadding.p10.responsiveWidth),
                                    child: LayoutBuilder(builder: (context, constrains) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: constrains.maxWidth * 0.18,
                                            child: ClipOval(
                                              child: NullableNetworkImage(
                                                imagePath: userData.imgPath,
                                                notHaveImage: userData.imgPath!.isEmpty,
                                                width: double.infinity,
                                                height: constrains.maxHeight * 0.9,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          AppSize.s20.sizedBoxWidth,
                                          SizedBox(
                                            width: constrains.maxWidth * 0.6,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userData.name,
                                                  style: AppTextStyle.bodyLarge16.copyWith(
                                                      color: AppColors.black,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                Text(
                                                  userData.phone??"",
                                                  style: AppTextStyle.bodyMedium14.copyWith(
                                                      color: AppColors.textColor3,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AppSize.s10.sizedBoxHeight,
                                        ],
                                      );
                                    }),
                                  ),
                                  AddParentOrChildButton(
                                    onTap: () {
                                      RouteManager.rPushNamed(
                                        context: context,
                                        rName: AppRoutesNames.rInstitutionAddChildScreen,
                                        arguments: userData.userId,
                                      );
                                    },
                                    alignmentDirectional: AlignmentDirectional.centerEnd,
                                    buttonLabel: AppStrings.addStudents,
                                    backgroundColor: AppColors.white,
                                    svgPath: AppIconsAssets.sChild,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart
                                ,
                                child: Text(
                                  AppStrings.myStudents,
                                  style: const AppTextStyle().w700.bodyLarge16,
                                ),

                              ),
                              10.sizedBoxHeight,
                              const AllChildBuilder(),
                            ],
                          ).paddingBody(),
                        ),
                      )

                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
