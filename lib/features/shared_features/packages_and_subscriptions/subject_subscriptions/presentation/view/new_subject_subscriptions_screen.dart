import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_state.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../../../../core/services/services_locator.dart';
import '../../../../../../../../core/shared_widget/button_widget.dart';
import '../../../../../../config/resources/app_assets.dart';
import '../../../../../../config/resources/app_colors.dart';
import '../../../../../../config/resources/app_constants.dart';
import '../../../../../../config/routes/routes_names.dart';
import '../../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../shared_features/subscriptions_and_packages/widgets/header_widget.dart';
import '../../../domain/entity/subject_subscriptions_entity.dart';
import '../../../presentation/view_model/packages_and_subscriptions_bloc.dart';
import '../../../presentation/view_model/packages_and_subscriptions_event.dart';

class TermSubscriptionsScreen extends StatelessWidget {
  final SubjectSubscriptionsInputs data;
  const TermSubscriptionsScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBarSubscriptionsWidget(
              title: AppStrings.subscriptions,
              isNotHomeSub: true,
              childID: getIt<UserLocalDataSource>().getUserData()!.userId,
            ),
            AppSize.s30.sizedBoxHeight,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocConsumer<PackagesAndSubscriptionsBloc,
                            PackagesAndSubscriptionsState>(
                        listener: (context, state) {

                          switch(state.addAllSubjects){
                            case SelectAllState.startSelectAll:
                              showLoadingDialog(context);
                              case SelectAllState.endSelectAll:
                                Navigator.pop(context);
                                if (state.subjectSubscriptions.optionalSubject.isNotEmpty) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) =>
                                          AddOptionalSubjectDialouge(
                                            termId: state.subjectSubscriptions.optionalSubject.last.termID,
                                            data: state.subjectSubscriptions.optionalSubject,
                                            childId: data.childId ??
                                                getIt<UserLocalDataSource>()
                                                    .getUserData()!
                                                    .userId,
                                          ));
                                }
                            default:
                          }


                      switch (state.addSubjectToCartState) {
                        case RequestStates.loading:
                          showLoadingDialog(context);
                          break;
                        case RequestStates.error:
                          Navigator.pop(context);
                          showSnackBar(
                            description: state.addSubjectToCartMessage,
                            state: ToastStates.error,
                            context: context,
                          );
                          break;
                        case RequestStates.loaded:
                          Navigator.pop(context);
                          showSnackBar(
                            description: state.addSubjectToCartMessage,
                            state: ToastStates.congrats,
                            context: context,
                          );
                          if (state.subjectSubscriptions.optionalSubject.isNotEmpty) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    AddOptionalSubjectDialouge(
                                      termId: state.currentTermId,
                                      data: state
                                          .subjectSubscriptions.optionalSubject,
                                      childId: data.childId ??
                                          getIt<UserLocalDataSource>()
                                              .getUserData()!
                                              .userId,
                                    ));
                          }
                          break;
                        default:
                      }

                      switch (state.deleteSubjectFromCartState) {
                        case RequestStates.loading:
                          showLoadingDialog(context);
                          break;
                        case RequestStates.error:
                          Navigator.pop(context);
                          showSnackBar(
                            description: state.deleteSubjectFromCartMessage,
                            state: ToastStates.error,
                            context: context,
                          );
                          break;
                        case RequestStates.loaded:
                          Navigator.pop(context);
                          showSnackBar(
                            description: state.deleteSubjectFromCartMessage,
                            state: ToastStates.congrats,
                            context: context,
                          );
                          break;
                        default:
                      }
                    }, builder: (context, state) {



                      switch (state.subjectSubscriptionsState) {
                        case RequestStates.loading:
                          return LoadingShimmerList(
                            height: 50.responsiveHeight,
                            count: 3,
                          );
                        case RequestStates.error:
                          return CustomErrorWidget(
                            errorMessage:
                                state.subjectSubscriptionsEventMessage,
                          );
                        case RequestStates.loaded:
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.subjectSubscriptions.terms.length,
                              itemBuilder: (context, index) {
                                return state.subjectSubscriptions.terms.isEmpty
                                    ? const EmptyListWidgets(
                                        message: "لا توجد بيانات")
                                    : Center(
                                        child: Container(
                                          width: (AppReference.deviceIsTablet &&
                                                  !AppReference.isPortrait(
                                                      context))
                                              ? AppReference.deviceWidth(
                                                      context) *
                                                  0.6
                                              : AppReference.deviceWidth(
                                                  context),
                                          padding: EdgeInsets.only(
                                            left:
                                                AppPadding.p10.responsiveWidth,
                                            right:
                                                AppPadding.p10.responsiveWidth,
                                            bottom:
                                                AppPadding.p10.responsiveHeight,
                                          ),
                                          margin: EdgeInsets.only(
                                            bottom:
                                                AppPadding.p20.responsiveHeight,
                                          ),
                                          decoration: const BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    AppConstants
                                                        .appBorderRadiusR20),
                                                topRight: Radius.circular(
                                                    AppConstants
                                                        .appBorderRadiusR20),
                                              )),
                                          child: ExpansionTile(
                                            childrenPadding: EdgeInsets.zero,
                                            collapsedShape:
                                                const ContinuousRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  AppConstants
                                                      .appBorderRadiusR20),
                                              topRight: Radius.circular(
                                                  AppConstants
                                                      .appBorderRadiusR20),
                                            )),
                                            shape:
                                                const ContinuousRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  AppConstants
                                                      .appBorderRadiusR20),
                                              topRight: Radius.circular(
                                                  AppConstants
                                                      .appBorderRadiusR20),
                                            )),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  state.subjectSubscriptions
                                                      .terms[index].name,
                                                  style: const AppTextStyle()
                                                      .balooBhaijaan2
                                                      .w500
                                                      .black
                                                      .bodyLarge16,
                                                ),
                                              ],
                                            ),
                                            children: <Widget>[
                                              Divider(
                                                color: AppColors.white,
                                                height:
                                                    AppSize.s4.responsiveSize,
                                                thickness:
                                                    AppSize.s4.responsiveSize,
                                              ),
                                              if (state
                                                  .subjectSubscriptions
                                                  .terms[index]
                                                  .subjects
                                                  .isEmpty)
                                                const EmptyListWidgets(
                                                    message:
                                                        "لا يوجد مواد لهذا الفصل"),
                                              if (state
                                                  .subjectSubscriptions
                                                  .terms[index]
                                                  .subjects
                                                  .isNotEmpty) ...[
                                                ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return Divider(
                                                      color: AppColors.white,
                                                      height: AppSize
                                                          .s8.responsiveSize,
                                                      thickness: AppSize
                                                          .s8.responsiveSize,
                                                    );
                                                  },
                                                  itemBuilder:
                                                      (context, subjectsIndex) {
                                                    return CustomInkWell(
                                                      onTap: () {
                                                        if (!AppReference.userIsGuest()) {
                                                          if (!state
                                                              .subjectSubscriptions
                                                              .terms[index]
                                                              .subjects[
                                                          subjectsIndex]
                                                              .isSubscribed) {
                                                            if (state
                                                                .subjectSubscriptions
                                                                .terms[index]
                                                                .subjects[
                                                            subjectsIndex]
                                                                .cart) {
                                                              context.read<PackagesAndSubscriptionsBloc>().add(DeleteSubjectFromCartEvent(
                                                                  addAndDeleteSubjectInputs: AddAndDeleteSubjectInputs(
                                                                      subjectId: state
                                                                          .subjectSubscriptions
                                                                          .terms[
                                                                      index]
                                                                          .subjects[
                                                                      subjectsIndex]
                                                                          .subjectID,
                                                                      pathId: state
                                                                          .subjectSubscriptions
                                                                          .terms[
                                                                      index]
                                                                          .subjects[
                                                                      subjectsIndex]
                                                                          .pathID,
                                                                      childId: data
                                                                          .childId)));
                                                            } else {
                                                              context.read<PackagesAndSubscriptionsBloc>().add(AddSubjectToCartEvent(
                                                                  addAndDeleteSubjectInputs: AddAndDeleteSubjectInputs(
                                                                      subjectId: state
                                                                          .subjectSubscriptions
                                                                          .terms[
                                                                      index]
                                                                          .subjects[
                                                                      subjectsIndex]
                                                                          .subjectID,
                                                                      pathId: state
                                                                          .subjectSubscriptions
                                                                          .terms[
                                                                      index]
                                                                          .subjects[
                                                                      subjectsIndex]
                                                                          .pathID,
                                                                      childId: data
                                                                          .childId,
                                                                      termId: state
                                                                          .subjectSubscriptions
                                                                          .terms[
                                                                      index]
                                                                          .subjects[
                                                                      subjectsIndex]
                                                                          .termID)));
                                                            }
                                                          }
                                                        } else {
                                                          AppReference.guestDialogMustLogin(context);
                                                        }

                                                      },
                                                      child: LayoutBuilder(
                                                          builder: (context,
                                                              constrains) {
                                                        return Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: AppPadding
                                                                  .p18
                                                                  .responsiveSize,
                                                              vertical: AppPadding
                                                                  .p12
                                                                  .responsiveSize),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: state
                                                                          .subjectSubscriptions
                                                                          .terms[
                                                                              index]
                                                                          .subjects[
                                                                              subjectsIndex]
                                                                          .isFree
                                                                      ? AppColors
                                                                          .successColor
                                                                          .withOpacity(
                                                                              .1)
                                                                      : state
                                                                              .subjectSubscriptions
                                                                              .terms[
                                                                                  index]
                                                                              .subjects[
                                                                                  subjectsIndex]
                                                                              .isSubscribed
                                                                          ? AppColors.secondaryColor.withOpacity(
                                                                              .1)
                                                                          : AppColors
                                                                              .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          AppConstants
                                                                              .appBorderRadiusR20)),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: constrains
                                                                        .maxWidth *
                                                                    0.8,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      child:
                                                                          Text(
                                                                        state
                                                                            .subjectSubscriptions
                                                                            .terms[index]
                                                                            .subjects[subjectsIndex]
                                                                            .subjectName,
                                                                        style: const AppTextStyle()
                                                                            .balooBhaijaan2
                                                                            .w500
                                                                            .black
                                                                            .bodyMedium14,
                                                                      ),
                                                                    ),
                                                                    AppSize.s6
                                                                        .sizedBoxHeight,
                                                                    SizedBox(
                                                                      width: constrains
                                                                              .maxWidth *
                                                                          0.6,
                                                                      child: state
                                                                              .subjectSubscriptions
                                                                              .terms[index]
                                                                              .subjects[subjectsIndex]
                                                                              .isSubscribed
                                                                          ? Row(
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  AppIconsAssets.sDiplomaCertificate,
                                                                                  colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
                                                                                ),
                                                                                AppSize.s4.sizedBoxWidth,
                                                                                Text(
                                                                                  'تم الشراء مسبقا',
                                                                                  style: const AppTextStyle().balooBhaijaan2.w800.bodySmall12.copyWith(color: AppColors.secondaryColor),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : state.subjectSubscriptions.terms[index].subjects[subjectsIndex].isFree
                                                                              ? Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(AppIconsAssets.sFireworks),
                                                                                    AppSize.s6.sizedBoxWidth,
                                                                                    Text(
                                                                                      'هدية',
                                                                                      style: const AppTextStyle().balooBhaijaan2.w800.bodySmall12.copyWith(color: AppColors.successColor),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Row(
                                                                                  children: [
                                                                                    if (state.subjectSubscriptions.terms[index].subjects[subjectsIndex].subjectOldPrice != 0) ...[
                                                                                      BasePriceSaleItem(
                                                                                        title: 'قبل',
                                                                                        price: state.subjectSubscriptions.terms[index].subjects[subjectsIndex].subjectOldPrice.toString(),
                                                                                      ),
                                                                                      AppSize.s20.sizedBoxWidth,
                                                                                      BasePriceSaleItem(
                                                                                        isAfter: true,
                                                                                        title: 'بعد',
                                                                                        price: state.subjectSubscriptions.terms[index].subjects[subjectsIndex].subjectPrice.toString(),
                                                                                      ),
                                                                                    ],
                                                                                    if (state.subjectSubscriptions.terms[index].subjects[subjectsIndex].subjectOldPrice == 0) ...[
                                                                                      Text(
                                                                                        '${state.subjectSubscriptions.terms[index].subjects[subjectsIndex].subjectPrice.toString()} ريال',
                                                                                        style: const AppTextStyle().balooBhaijaan2.w600.black.bodyMedium14.copyWith(
                                                                                              decorationColor: AppColors.secondaryColor4,
                                                                                              decorationStyle: TextDecorationStyle.solid,
                                                                                              color: AppColors.secondaryColor4,
                                                                                              fontSize: AppSize.s14.responsiveSize,
                                                                                            ),
                                                                                      ),
                                                                                    ]
                                                                                  ],
                                                                                ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: constrains
                                                                        .maxWidth *
                                                                    0.08,
                                                                child: state
                                                                        .subjectSubscriptions
                                                                        .terms[
                                                                            index]
                                                                        .subjects[
                                                                            subjectsIndex]
                                                                        .isSubscribed
                                                                    ? const SizedBox
                                                                        .shrink()
                                                                    : state
                                                                            .subjectSubscriptions
                                                                            .terms[
                                                                                index]
                                                                            .subjects[
                                                                                subjectsIndex]
                                                                            .isFree
                                                                        ? const SizedBox
                                                                            .shrink()
                                                                        : CircleAvatar(
                                                                            radius:
                                                                                AppSize.s10.responsiveSize,
                                                                            backgroundColor:
                                                                                AppColors.black,
                                                                            child: CircleAvatar(
                                                                                radius: state.subjectSubscriptions.terms[index].subjects[subjectsIndex].cart ? AppSize.s10.responsiveSize : AppSize.s8.responsiveSize,
                                                                                backgroundColor: state.subjectSubscriptions.terms[index].subjects[subjectsIndex].cart ? AppColors.successColor : AppColors.white,
                                                                                child: const FittedBox(
                                                                                  fit: BoxFit.scaleDown,
                                                                                  child: Icon(
                                                                                    Icons.check,
                                                                                    color: AppColors.white,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                  itemCount: state
                                                      .subjectSubscriptions
                                                      .terms[index]
                                                      .subjects
                                                      .length,
                                                ),
                                                AppSize.s10.sizedBoxHeight,
                                                if (AppReference.deviceIsTablet)
                                                  CustomInkWell(
                                                    onTap: () {
                                                      if (!AppReference.userIsGuest()) {
                                                        context.read<PackagesAndSubscriptionsBloc>().add(AddAdllSubjectsEvent(termIndex: index, childId: data.childId ?? 0));
                                                      } else {
                                                        AppReference.guestDialogMustLogin(context);
                                                      }
                                                    },
                                                    child: Flash(
                                                      infinite: true,
                                                      duration: const Duration(seconds: 4),
                                                      curve: Curves.easeIn,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: AppPadding
                                                                .p2.responsiveSize,
                                                            vertical: AppPadding
                                                                .p6.responsiveSize),
                                                        decoration: BoxDecoration(
                                                            color: AppColors.primaryColor2,
                                                            borderRadius: BorderRadius
                                                                .circular(AppConstants
                                                                    .appBorderRadiusR20),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .primaryColor2)),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                                                AppIconsAssets
                                                                    .sBulb),
                                                            AppSize
                                                                .s6.sizedBoxWidth,
                                                            Expanded(
                                                              child: Text(
                                                                  state
                                                                      .subjectSubscriptions
                                                                      .terms[index]
                                                                      .message,
                                                                  style: const AppTextStyle()
                                                                      .balooBhaijaan2
                                                                      .w500
                                                                      .bodySmall12
                                                                      .copyWith(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontSize:
                                                                            AppSize
                                                                                .s10
                                                                                .responsiveSize,
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (!AppReference
                                                    .deviceIsTablet)
                                                  CustomInkWell(
                                                    onTap: () {
                                                      if (!AppReference.userIsGuest()) {
                                                        context.read<PackagesAndSubscriptionsBloc>().add(AddAdllSubjectsEvent(termIndex: index, childId: data.childId ?? 0));
                                                      } else {
                                                        AppReference.guestDialogMustLogin(context);
                                                      }                                                    },
                                                    child: Flash(
                                                      infinite: true,
                                                       duration: const Duration(seconds: 4),
                                                        curve: Curves.easeIn,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: AppPadding
                                                                .p18.responsiveSize,
                                                            vertical: AppPadding
                                                                .p6.responsiveSize),
                                                        decoration: BoxDecoration(
                                                            color: AppColors.primaryColor2,
                                                            borderRadius: BorderRadius
                                                                .circular(AppConstants
                                                                    .appBorderRadiusR20),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .primaryColor2)),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                                                AppIconsAssets
                                                                    .sBulb),
                                                            AppSize
                                                                .s10.sizedBoxWidth,
                                                            Expanded(
                                                              child: Text(
                                                                  state
                                                                      .subjectSubscriptions
                                                                      .terms[index]
                                                                      .message,
                                                                  style: const AppTextStyle()
                                                                      .balooBhaijaan2
                                                                      .w500
                                                                      .bodySmall12
                                                                      .copyWith(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontSize:
                                                                            AppSize
                                                                                .s10
                                                                                .responsiveSize,
                                                                      )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      );
                              });
                        default:
                          return const SizedBox.shrink();
                      }
                    })
                  ],
                ),
              ),
            ),
            AppSize.s10.sizedBoxHeight,
            SizedBox(
                width: AppReference.deviceIsTablet
                    ? AppReference.deviceWidth(context) * 0.4
                    : AppReference.deviceWidth(context),
                child: DefaultButtonWidget(
                  label: "إلى السلة",
                  onPressed: () {
                    if (!AppReference.userIsGuest()) {
                      RouteManager.rPushNamed(
                          context: context,
                          arguments: data.childId ??
                              getIt<UserLocalDataSource>().getUserData()!.userId,
                          rName: AppRoutesNames.rCartScreen);
                    } else {
                      AppReference.guestDialogMustLogin(context);
                    }
                  },
                )),
          ],
        ).paddingBody(),
      ),
    );
  }
}

class AddOptionalSubjectDialouge extends StatefulWidget {
  const AddOptionalSubjectDialouge(
      {super.key,
      required this.data,
      required this.childId,
      required this.termId});

  final List<SubjectForSubjectSubscriptionsEntity> data;
  final int childId;
  final int termId;

  @override
  State<AddOptionalSubjectDialouge> createState() =>
      _AddOptionalSubjectDialougeState();
}

class _AddOptionalSubjectDialougeState
    extends State<AddOptionalSubjectDialouge> {
  int _selectedValue = -1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: BlocProvider(
        create: (context) => getIt<PackagesAndSubscriptionsBloc>(),
        child: Builder(builder: (context) {
          return BlocListener<PackagesAndSubscriptionsBloc,
                  PackagesAndSubscriptionsState>(
              listener: (context, state) {
                switch (state.addOptionalSubjectToCartState) {
                  case RequestStates.loading:
                    showLoadingDialog(context);
                    break;
                  case RequestStates.error:
                    Navigator.pop(context);
                    showSnackBar(
                      description: state.addOptionalSubjectToCartMessage,
                      state: ToastStates.error,
                      context: context,
                    );
                    break;
                  case RequestStates.loaded:
                    Navigator.pop(context);
                    showSnackBar(
                      description: state.addOptionalSubjectToCartMessage,
                      state: ToastStates.congrats,
                      context: context,
                    );
                    Navigator.pop(context);
                    break;
                  default:
                }
              },
              child: Container(
                  width: !AppReference.deviceIsTablet ||
                          !AppReference.isPortrait(context)
                      ? AppReference.deviceWidth(context) * 0.4
                      : AppReference.deviceWidth(context) * 0.8,
                  padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR20.responsiveHeight)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("المواد الاختيارية",
                            style: const AppTextStyle()
                                .balooBhaijaan2
                                .w500
                                .black
                                .bodyLarge16),
                        AppSize.s20.sizedBoxHeight,
                        ListView.separated(
                          separatorBuilder: (context, index) =>
                              AppSize.s20.sizedBoxHeight,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, subjectsIndex) {
                            return LayoutBuilder(
                                builder: (context, constrains) {
                              return CustomInkWell(
                                onTap: () {
                                  setState(() {
                                    if (!widget
                                        .data[subjectsIndex].isSubscribed) {
                                      if (!widget.data[subjectsIndex].cart) {
                                        _selectedValue = subjectsIndex;
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p10.responsiveSize,
                                      vertical: AppPadding.p10.responsiveSize),
                                  decoration: BoxDecoration(
                                      color: widget.data[subjectsIndex].isFree
                                          ? AppColors.successColor
                                              .withOpacity(.1)
                                          : widget.data[subjectsIndex]
                                                  .isSubscribed
                                              ? AppColors.secondaryColor
                                                  .withOpacity(.1)
                                              : AppColors.white,
                                      borderRadius: BorderRadius.circular(
                                          AppConstants.appBorderRadiusR20)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: constrains.maxWidth * 0.8,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            widget.data[subjectsIndex]
                                                .subjectName,
                                            style: const AppTextStyle()
                                                .balooBhaijaan2
                                                .w500
                                                .black
                                                .bodyMedium14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: constrains.maxWidth * 0.08,
                                        child: widget.data[subjectsIndex]
                                                .isSubscribed
                                            ? const SizedBox.shrink()
                                            : widget.data[subjectsIndex].isFree
                                                ? const SizedBox.shrink()
                                                : CircleAvatar(
                                                    radius: AppSize
                                                        .s10.responsiveSize,
                                                    backgroundColor:
                                                        AppColors.black,
                                                    child: CircleAvatar(
                                                        radius: _selectedValue ==
                                                                subjectsIndex
                                                            ? AppSize.s10
                                                                .responsiveSize
                                                            : AppSize.s8
                                                                .responsiveSize,
                                                        backgroundColor:
                                                            _selectedValue ==
                                                                    subjectsIndex
                                                                ? AppColors
                                                                    .successColor
                                                                : AppColors
                                                                    .white,
                                                        child: const FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Icon(
                                                            Icons.check,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        )),
                                                  ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          itemCount: widget.data.length,
                        ),
                        AppSize.s20.sizedBoxHeight,
                        DefaultButtonWidget(
                            label: "تأكيد",
                            onPressed: () {
                              if (_selectedValue == -1) {
                                showSnackBar(
                                  description: "يجب تحديد المادة",
                                  state: ToastStates.error,
                                  context: context,
                                );
                                return;
                              } else {
                                context
                                    .read<PackagesAndSubscriptionsBloc>()
                                    .add(AddOptionalSubjectToCartEvent(
                                        addAndDeleteSubjectInputs:
                                            AddAndDeleteSubjectInputs(
                                                subjectId: widget
                                                    .data[_selectedValue]
                                                    .subjectID,
                                                pathId: widget
                                                    .data[_selectedValue]
                                                    .pathID,
                                                termId: widget.termId,
                                                childId: widget.childId)));
                              }
                            })
                      ])));
        }),
      ),
    );
  }
}

class BasePriceSaleItem extends StatelessWidget {
  const BasePriceSaleItem({
    super.key,
    required this.title,
    required this.price,
    this.isAfter = false,
  });
  final String title;
  final String price;
  final bool isAfter;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const AppTextStyle()
              .balooBhaijaan2
              .w400
              .black
              .bodySmall12
              .copyWith(
                fontSize: AppSize.s10.responsiveSize,
              ),
        ),
        AppSize.s8.sizedBoxWidth,
        Text(
          '$price ريال',
          style: const AppTextStyle()
              .balooBhaijaan2
              .w600
              .black
              .bodyMedium14
              .copyWith(
                decoration:
                    isAfter ? TextDecoration.none : TextDecoration.lineThrough,
                decorationThickness: 2,
                decorationColor: AppColors.secondaryColor4,
                decorationStyle: TextDecorationStyle.solid,
                color: AppColors.secondaryColor4,
                fontSize: isAfter
                    ? AppSize.s12.responsiveSize
                    : AppSize.s14.responsiveSize,
              ),
        ),
      ],
    );
  }
}
