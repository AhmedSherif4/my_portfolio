import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';

import '../../config/resources/app_colors.dart';
import '../../config/resources/app_text_style.dart';
import '../../config/routes/route_manager.dart';
import '../../config/routes/routes_names.dart';
import '../../features/parent_flow/home/presentation/home_view_model/parent_home_bloc.dart';
import '../../my_app/app_reference.dart';
import '../enum/enum_generation.dart';
import 'button_widget.dart';
import 'empty_list_widget.dart';
import 'error_widget.dart';
import 'loading_shimmer_list.dart';
import 'nullable_network_image.dart';

class ChildIListTileItemForInstitutionAndParent extends StatelessWidget {
  final String imagePath;
  final String name;
  final String classRoom;
  final Function() detailsButtonOnTap;

  const ChildIListTileItemForInstitutionAndParent(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.classRoom,
      required this.detailsButtonOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppReference.deviceHeight(context) * 0.086.responsiveHeightRatio,
      padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR15.responsiveSize)),
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: constrains.maxWidth * 0.2,
              child: NullableNetworkImage(
                imagePath: imagePath,
                notHaveImage: imagePath.isEmpty,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
                width: constrains.maxWidth * 0.45,
                child: LayoutBuilder(builder: (context, consCol) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: consCol.maxHeight * 0.5,
                        child: Text(
                          name,
                          style: AppTextStyle.bodyMedium14
                              .copyWith(fontWeight: AppFontWeight.boldW700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: consCol.maxHeight * 0.45,
                        child: Text(
                          classRoom,
                          style: const AppTextStyle().s12.bodyMedium14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                })),
            SizedBox(
              width: constrains.maxWidth * 0.3,
              child: DefaultButtonWidget(
                textVerticalPadding: 5,
                textStyle: AppTextStyle.bodyMedium14.copyWith(
                    color: AppColors.white,
                    fontWeight: AppFontWeight.semiBoldW600),
                height: 0,
                label: AppStrings.details,
                onPressed: detailsButtonOnTap,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class AllChildBuilder extends StatelessWidget {
  const AllChildBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentHomeBloc, ParentHomeState>(
      builder: (context, state) {
        switch (state.allChildState) {
          case RequestStates.loading:
            return const LoadingShimmerList(
              height: 50,
            );
          case RequestStates.loaded:
            if (state.allChild.isEmpty) {
              return Column(
                children: [
                  AppSize.s70.sizedBoxHeight,
                  const EmptyListWidgets(
                      message: AppStrings.noAccountNow),
                ],
              );
            } else {
              return AppReference.deviceIsTablet && (!AppReference.isPortrait(context))?
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      childAspectRatio: 8/1.5
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        CustomInkWell(
                          onTap: () {
                            RouteManager.rPushNamed(
                              context: context,
                              rName: AppRoutesNames.rParentChildDetails,
                              arguments: state.allChild[index],
                            );
                          },
                          child: ChildIListTileItemForInstitutionAndParent(
                              imagePath: state.allChild[index].imgPath ?? '',
                              name: state.allChild[index].name,
                              classRoom: state.allChild[index].classroomName ?? '',
                              detailsButtonOnTap: () {
                                RouteManager.rPushNamed(
                                  context: context,
                                  rName: AppRoutesNames.rParentChildDetails,
                                  arguments: state.allChild[index],
                                );
                              }),
                        ),
                    itemCount: state.allChild.length,
                  )
                  :ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    CustomInkWell(
                      onTap: () {
                        RouteManager.rPushNamed(
                          context: context,
                          rName: AppRoutesNames.rParentChildDetails,
                          arguments: state.allChild[index],
                        );
                      },
                      child: ChildIListTileItemForInstitutionAndParent(
                          imagePath: state.allChild[index].imgPath ?? '',
                          name: state.allChild[index].name,
                          classRoom: state.allChild[index].classroomName ?? '',
                          detailsButtonOnTap: () {
                            RouteManager.rPushNamed(
                              context: context,
                              rName: AppRoutesNames.rParentChildDetails,
                              arguments: state.allChild[index],
                            );
                          }),
                    ),
                separatorBuilder: (context, index) => AppSize.s10.sizedBoxHeight,
                itemCount: state.allChild.length,
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.allChildErrorMessage);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
