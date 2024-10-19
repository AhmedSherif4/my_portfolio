import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/institution_flow/home/presentation/view_model/institution_home_bloc.dart';

import '../../../../../../my_app/app_reference.dart';
import '../../../../config/extensions/color_extension.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../core/shared_widget/add_parent_or_child_button.dart';
import '../../../../core/shared_widget/text_form_field.dart';
import '../../../shared_features/notification/presentation/view_model/notification_bloc.dart';
import '../../institution_shared_widget/institution_header.dart';

class InstitutionHomeScreen extends StatefulWidget {
  const InstitutionHomeScreen({super.key});

  @override
  State<InstitutionHomeScreen> createState() => _InstitutionHomeScreenState();
}
List<UserEntity> filteredItems = [];
late TextEditingController searchController;

class _InstitutionHomeScreenState extends State<InstitutionHomeScreen> {

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<InstitutionHomeBloc>().add(
              GetAllParentsForInstitutionEvent(),
            );

        context
            .read<NotificationBloc>()
            .add(const GetAllNotificationEvent(pageNumber: 1));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            InstitutionAndParentHeader(
              title: getIt<UserLocalDataSource>().getUserData()!.name,
              withBackButton: false,
            ),
            20.sizedBoxHeight,
            ResponsiveWidgetForTablet(
              mobile: Column(
                children: [
                  SizedBox(
                    height: AppReference.deviceHeight(context) *
                        0.12.responsiveHeightRatio,
                    child: AddParentOrChildButton(
                      onTap: () {
                        RouteManager.rPushNamed(
                            context: context,
                            rName: AppRoutesNames.rInstitutionAddParentScreen);
                      },
                      buttonLabel: AppStrings.addYourParents,
                      backgroundColor: HexColor.fromHex('#eaf1fa'),
                      svgPath: AppImagesAssets.sAddUser,
                    ),
                  ),
                  30.sizedBoxHeight,
                  TextFormFieldWidget(
                      controller: searchController,
                      keyboardType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      hintText: "أبحث عن ولي أمر",
                      suffixIcon: Icons.search,
                      suffixIconOnPress: () {
                        setState(() {
                          filteredItems = context.read<InstitutionHomeBloc>().allParents
                              .where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                        });
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          filteredItems = context.read<InstitutionHomeBloc>().allParents
                              .where((element) => element.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                              .toList();
                        });
                      }),
                  10.sizedBoxHeight,

                  const TableHeader(
                    fText: AppStrings.name,
                    sText: AppStrings.numberOfStudents,
                  ),
                  10.sizedBoxHeight,

                  BlocBuilder<InstitutionHomeBloc, InstitutionHomeState>(
                    builder: (context, state) {
                      switch (state.allParentsState) {
                        case RequestStates.loading:
                          return LoadingShimmerList(height: 100.responsiveHeight);
                        case RequestStates.loaded:
                          if (state.allParents.isEmpty) {
                            return SizedBox(
                              height: AppReference.deviceHeight(context) * .5,
                              child: const Center(
                                child: EmptyListWidgets(
                                    message: AppStrings.noParentsNowAdded),
                              ),
                            );
                          } else {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>filteredItems.isEmpty?
                              ParentsItemForInstitution(
                                onTap: () {
                                  RouteManager.rPushNamed(
                                      context: context,
                                      rName:
                                      AppRoutesNames.rInstitutionsParentDetails,
                                      arguments: state.allParents[index]);
                                },
                                name: state.allParents[index].name,
                                gender: state.allParents[index].gender,
                                phone: state.allParents[index].email == null
                                    ? state.allParents[index].phone ?? ''
                                    : state.allParents[index].email ?? '',
                                childCount: state.allParents[index].childrenCount,
                                color: AppColors.white,
                              ):
                              ParentsItemForInstitution(
                                onTap: () {
                                  RouteManager.rPushNamed(
                                      context: context,
                                      rName:
                                      AppRoutesNames.rInstitutionsParentDetails,
                                      arguments: filteredItems[index]);
                                },
                                name: filteredItems[index].name,
                                gender: filteredItems[index].gender,
                                phone: filteredItems[index].email == null
                                    ? filteredItems[index].phone ?? ''
                                    : filteredItems[index].email ?? '',
                                childCount: filteredItems[index].childrenCount,
                              ),
                              separatorBuilder: (context, index) => 10.sizedBoxHeight,
                              itemCount:filteredItems.isEmpty? state.allParents.length:filteredItems.length,
                            );
                          }
                        case RequestStates.error:
                          return CustomErrorWidget(
                              errorMessage: state.allParentsErrorMessage);
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
              tablet: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppReference.deviceHeight(context) *
                        0.12.responsiveHeightRatio,
                    child: AddParentOrChildButton(
                      onTap: () {
                        RouteManager.rPushNamed(
                            context: context,
                            rName: AppRoutesNames.rInstitutionAddParentScreen);
                      },
                      buttonLabel: AppStrings.addYourParents,
                      backgroundColor: HexColor.fromHex('#eaf1fa'),
                      svgPath: AppImagesAssets.sAddUser,
                    ),
                  ),
                  30.sizedBoxWidth,
                  SizedBox(
                    width: AppReference.deviceWidth(context) * 0.6,
                    child: Column(
                      children: [
                        10.sizedBoxHeight,
                        const TableHeader(
                          fText: AppStrings.name,
                          sText: AppStrings.numberOfStudents,
                        ),
                        10.sizedBoxHeight,

                        BlocBuilder<InstitutionHomeBloc, InstitutionHomeState>(
                          builder: (context, state) {
                            switch (state.allParentsState) {
                              case RequestStates.loading:
                                return LoadingShimmerList(height: 100.responsiveHeight);
                              case RequestStates.loaded:
                                if (state.allParents.isEmpty) {
                                  return SizedBox(
                                    height: AppReference.deviceHeight(context) * .5,
                                    child: const Center(
                                      child: EmptyListWidgets(
                                          message: AppStrings.noParentsNowAdded),
                                    ),
                                  );
                                } else {
                                  return ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>filteredItems.isEmpty?
                                    ParentsItemForInstitution(
                                      onTap: () {
                                        RouteManager.rPushNamed(
                                            context: context,
                                            rName:
                                            AppRoutesNames.rInstitutionsParentDetails,
                                            arguments: state.allParents[index]);
                                      },
                                      name: state.allParents[index].name,
                                      gender: state.allParents[index].gender,
                                      phone: state.allParents[index].email == null
                                          ? state.allParents[index].phone ?? ''
                                          : state.allParents[index].email ?? '',
                                      childCount: state.allParents[index].childrenCount,
                                      color: AppColors.white,
                                    ):
                                    ParentsItemForInstitution(
                                      onTap: () {
                                        RouteManager.rPushNamed(
                                            context: context,
                                            rName:
                                            AppRoutesNames.rInstitutionsParentDetails,
                                            arguments: filteredItems[index]);
                                      },
                                      name: filteredItems[index].name,
                                      gender: filteredItems[index].gender,
                                      phone: filteredItems[index].email == null
                                          ? filteredItems[index].phone ?? ''
                                          : filteredItems[index].email ?? '',
                                      childCount: filteredItems[index].childrenCount,
                                    ),
                                    separatorBuilder: (context, index) => 10.sizedBoxHeight,
                                    itemCount:filteredItems.isEmpty? state.allParents.length:filteredItems.length,
                                  );
                                }
                              case RequestStates.error:
                                return CustomErrorWidget(
                                    errorMessage: state.allParentsErrorMessage);
                              default:
                                return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),




          ],
        ).paddingBody(),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key, required this.fText, required this.sText,this.color=AppColors.warningColor,this.textColor=AppColors.white});
  final String fText;
  final String sText;
  final Color color ;
  final Color textColor ;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.05.responsiveHeightRatio,
      padding: EdgeInsets.symmetric(
          vertical: 5.responsiveHeight, horizontal: 10.responsiveWidth),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.responsiveSize),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
             fText,
              style: const AppTextStyle().balooBhaijaan2.white.w700.bodyMedium14.copyWith(
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              sText,
              style: const AppTextStyle().balooBhaijaan2.white.w700.bodyMedium14.copyWith(
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ParentsItemForInstitution extends StatelessWidget {
  final String name;
  final String gender;
  final String phone;
  final Color color;
  final String? label;
  final String? icon;
  final bool isFree;
  final int? childCount;
  final Function() onTap;

  const ParentsItemForInstitution(
      {super.key,
      required this.name,
      required this.gender,
      required this.phone,
       this.icon,
       this.label,
       this.color=AppColors.white,
       this.isFree=false,
      required this.childCount,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppReference.deviceHeight(context) * 0.04.responsiveHeightRatio,
        padding: EdgeInsets.symmetric(
          vertical: 5.responsiveHeight,
          horizontal: 10.responsiveWidth,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.responsiveSize),
          color:isFree?AppColors.successColor.withOpacity(.1): color,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                name,
                style: const AppTextStyle().balooBhaijaan2.black.w600.bodyMedium14
                    .copyWith(fontSize: AppReference.deviceIsTablet ? 16 : AppFontSize.sp12.responsiveFontSize),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  if(isFree)...[
                    SvgPicture.asset(AppIconsAssets.sFireworks),
                    AppSize.s6.sizedBoxWidth,
                  ],
                  Text(
                    isFree ? AppStrings.gift :
                    label ?? childCount.toString(),
                    style: const AppTextStyle().balooBhaijaan2.black.w600.bodySmall12
                        .copyWith(fontSize: AppReference.deviceIsTablet ? 16 : AppFontSize.sp12.responsiveFontSize),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  if(icon!=null&&!isFree)...[
                  AppSize.s6.sizedBoxWidth,
                  SvgPicture.asset(icon!)
                  ]
                ],
              ),
            ),
            icon!=null?const SizedBox.shrink():
            Icon(Icons.arrow_forward_ios_rounded, size: 12.responsiveSize),
          ],
        ),
      ),
    );
  }
}
