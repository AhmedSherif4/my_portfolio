import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_bloc.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_state.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_bloc.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_state.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../config/responsive/responsive_widget.dart';
import '../../../../../config/routes/route_manager.dart';
import '../../../../../config/storages/keys.dart';
import '../../../../../config/storages/secure_storage.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../core/shared_widget/dialogs/exit_dialog.dart';
import '../../../../intro/global/global_view_model/global_event.dart';
import '../../../child_subscriptions/presentation/subscriptions_systems_screen/view/data_to_go_random_exams.dart';
import '../../more_view_model/more_event.dart';
import '../../more_widgets/more_widgets.dart';
import '../../show_parent_child_other_side/presentation/views/show_child_parent_other_side_screen.dart';
import '../more_widgets/header_for_more.dart';

class ChildMoreScreen extends StatefulWidget {
  const ChildMoreScreen({super.key});
  @override
  State<ChildMoreScreen> createState() => _ChildMoreScreenState();
}

class _ChildMoreScreenState extends State<ChildMoreScreen> {
  bool confirmLogout = false;
  WidgetBuilder builder = buildProgressIndicator;

  final InAppReview _inAppReview = InAppReview.instance;
  Availability availability = Availability.loading;

  @override
  void initState() {
    super.initState();
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();
        setState(() {
          availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (_) {
        setState(() => availability = Availability.unavailable);
      }
    });
  }

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: AppKeys.appStoreIdKey,
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MoreBloc, MoreState>(
          listenWhen: (p, c) => p != c,
          listener: (context, state) {
            switch (state.logoutState) {
              case RequestStates.loading:
                showLoadingDialog(context);
              case RequestStates.loaded:
                Navigator.pop(context);
                if (context.read<GlobalBloc>().isLogoutButton) {
                  showSnackBar(
                    description: AppStrings.logoutSuccessfully,
                    state: ToastStates.congrats,
                    context: context,
                  );
                } else {
                  showSnackBar(
                      description: AppStrings.deleteAccountSuccessfully,
                      state: ToastStates.congrats,
                      context: context);
                }

                RouteManager.rPushNamedAndRemoveUntil(
                  context: context,
                  rName: AppRoutesNames.rWelcome,
                );
              default:
            }

            switch (state.formattedAppState) {
              case FormattedAppState.loading:
                showLoadingDialog(context);
              case FormattedAppState.loaded:
                Navigator.pop(context);
                  getIt<BaseAppSecurityData>().saveToken(token: context.read<MoreBloc>().token);
                  getIt<UserLocalDataSource>().saveUserData(userModel: context.read<MoreBloc>().userData);
                showSnackBar(
                    description: "تمت تهيئة البيانات بنجاح",
                    state: ToastStates.congrats,
                    context: context);
                RouteManager.rPushNamedAndRemoveUntil(
                  context: context,
                  rName: AppRoutesNames.rHomeLayoutView,
                  arguments: getIt<UserLocalDataSource>().getUserData(),
                );
                // String token = getIt<BaseAppSecurityData>().getToken()!;
                // var userData = getIt<UserLocalDataSource>().getUserData()!;
                // context.read<GlobalBloc>().refreshToken = true;
                // context.read<MoreBloc>().add(ReOpenBoxesEvent());
                // Future.delayed(const Duration(seconds: 3), () {
                //   getIt<BaseAppSecurityData>().saveToken(token: token);
                //   getIt<UserLocalDataSource>()
                //       .saveUserData(userModel: userData)
                //       .then((value) => RouteManager.rPushNamedAndRemoveUntil(
                //             context: context,
                //             rName: AppRoutesNames.rHomeLayoutView,
                //             arguments: userData,
                //           ));
                // });
              case FormattedAppState.error:
                Navigator.pop(context);
                showSnackBar(
                    description: "حدث خطأ ما",
                    state: ToastStates.congrats,
                    context: context);
                RouteManager.rPushNamedAndRemoveUntil(
                  context: context,
                  rName: AppRoutesNames.rWelcome,
                );
              default:
            }
          },
        ),
        BlocListener<GlobalBloc, GlobalState>(
          listener: (context, state) {
            if (context.read<GlobalBloc>().goToWelcome &&
                state.sendTimeState == SendTimeState.sendSuccessfully) {
              context.read<MoreBloc>().add(LogoutEvent());
            }
          },
        ),
      ],
      child: Column(
        children: [
          if (!AppReference.deviceIsTablet ||
              (AppReference.deviceIsTablet && AppReference.isPortrait(context)))
            const HeaderForMore(
              title: AppStrings.more,
              notFirst: false,
            ),
          if (AppReference.deviceIsTablet && !AppReference.isPortrait(context))
            SizedBox(
              height: AppReference.deviceIsTablet
                  ? AppReference.deviceWidth(context) *
                      0.04.responsiveHeightRatio
                  : AppReference.deviceHeight(context) *
                      0.08.responsiveHeightRatio,
              child: LayoutBuilder(builder: (context, constrains) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      AppImagesAssets.sLogoWithoutName,
                      width: constrains.maxWidth * 0.15,
                      height: constrains.maxHeight * 0.6,
                      fit: BoxFit.cover,
                    ),
                    (AppReference.deviceWidth(context) * 0.12).sizedBoxWidth,
                    Text(
                      AppStrings.more,
                      style: const AppTextStyle().w500.bodyLarge16.copyWith(
                            fontSize: AppFontSize.sp16.responsiveFontSize,
                          ),
                    ),
                  ],
                );
              }),
            ),
          const _Banner(),
            AppSize.s20.sizedBoxHeight,
          Expanded(
            child: SingleChildScrollView(
              child: ResponsiveWidgetForTablet(
                mobile: _MoreScreenPortraitView(
                  openStoreListing: _openStoreListing,
                  logoutMethod: _logoutMethod,
                ),
                tablet: OrientationItem(
                  portraitWidget: _MoreScreenPortraitView(
                    openStoreListing: _openStoreListing,
                    logoutMethod: _logoutMethod,
                  ),
                  landscapeWidget: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: AppReference.deviceWidth(context) * 0.45,
                        child: Column(
                          children: [
                            const _AccountDetailsListTile(),
                            if (AppReference.userIsChild() &&
                                !BlocProvider.of<GlobalBloc>(context)
                                    .state
                                    .appVersionModel
                                    .inReview2) ...[
                              const _MoreDivider(),
                              const _OtherStagesListTile(),
                            ],
                            const _MoreDivider(),
                            const _ReviewsListTile(),
                            if (AppReference.userIsChild()) ...[
                              const _MoreDivider(),
                              const _CouponsListTile()
                            ],
                            const _MoreDivider(),
                            _RatingAppListTile(onTap: _openStoreListing),
                            const _MoreDivider(),
                            const _ContactUsListTile(),
                            const _MoreDivider(),
                            const _CommonQuestionsListTile(),
                          ],
                        ),
                      ),
                      AppSize.s16.sizedBoxWidth,
                      SizedBox(
                        width: AppReference.deviceWidth(context) * 0.45,
                        child: Column(
                          children: [
                            const _SettingsListTile(),
                            if (AppReference.userIsChild() &&
                                !AppReference.userIsGuest() &&
                                !BlocProvider.of<GlobalBloc>(context)
                                    .state
                                    .appVersionModel
                                    .inReview2) ...[
                              const _MoreDivider(),
                              const _CartListTile(),
                            ],
                            const _MoreDivider(),
                            const _PrivacyListTile(),
                            const _MoreDivider(),
                            if (AppReference.userIsChild() &&
                                !AppReference.userIsGuest())
                              ListTileWidget(
                                  fromMore: true,
                                  title: AppStrings.watchAsParent,
                                  icon: AppImagesAssets.sAccount,
                                  onTap: () {
                                    showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return const ShowChildParentOtherSide();
                                        });
                                  }),
                            if (AppReference.userIsParent())
                              ListTileWidget(
                                  fromMore: true,
                                  title: AppStrings.watchAsChild,
                                  icon: AppImagesAssets.sAccount,
                                  onTap: () {
                                    showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return const ShowChildParentOtherSide();
                                        });
                                  }),
                            if (AppReference.userIsInstitution()) ...[
                              const _MoreDivider(),
                              ListTileWidget(
                                  fromMore: true,
                                  title: AppStrings.watchAsChild,
                                  icon: AppImagesAssets.sAccount,
                                  onTap: () {
                                    showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return const ShowChildParentOtherSide();
                                        });
                                  }),
                              const _MoreDivider(),
                              ListTileWidget(
                                  fromMore: true,
                                  title: AppStrings.watchAsParent,
                                  icon: AppImagesAssets.sAccount,
                                  onTap: () {
                                    showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return const ShowChildParentOtherSide();
                                        });
                                  })
                            ],
                            const _MoreDivider(),
                            const _ShareAppListTile(),
                            if (!AppReference.userIsGuest()) ...[
                              const _MoreDivider(),
                              const _FormatAppListTile(),
                            ],
                            const _MoreDivider(),
                            const _InviteFriendListTile(),
                            const _MoreDivider(),
                            if (AppReference.userIsGuest())
                              const _GuestRegistrationListTile(),
                            if (!AppReference.userIsGuest())
                              _LogoutListTile(onTap: _logoutMethod),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ).paddingBody(),
    );
  }

  void _logoutMethod() {
    if (!AppReference.userIsGuest()) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => ExitAndUpdateDialog(
            withImage: false,
            title: AppStrings.logoutTitle,
            message: AppStrings.wantToLogout,
            confirm: (value) {
              confirmLogout = value;
            }),
      ).then((value) {
        if (confirmLogout) {
          context.read<GlobalBloc>().isLogoutButton = true;
          if (AppReference.userIsChild()) {
            context.read<GlobalBloc>().add(const SendTimeInAppEvent());
            context.read<GlobalBloc>().goToWelcome = true;
          } else {
            context.read<MoreBloc>().add(LogoutEvent());
          }
        }
      });
    } else {
      AppReference.guestDialogMustLogin(context);
    }
  }

  static Widget buildProgressIndicator(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class _MoreScreenPortraitView extends StatelessWidget {
  final Function() openStoreListing;
  final Function() logoutMethod;
  const _MoreScreenPortraitView(
      {required this.openStoreListing, required this.logoutMethod});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _AccountDetailsListTile(),
        const _MoreDivider(),
        const _SettingsListTile(),
        const _MoreDivider(),
        const _ReviewsListTile(),
        if (AppReference.userIsChild()) ...[
          const _MoreDivider(),
          const _CouponsListTile(),
        ],
        const _MoreDivider(),
        _RatingAppListTile(
          onTap: () {
            openStoreListing();
          },
        ),
        const _MoreDivider(),
        if (AppReference.userIsChild() &&
            !AppReference.userIsGuest() &&
            !BlocProvider.of<GlobalBloc>(context)
                .state
                .appVersionModel
                .inReview2) ...[
          const _OtherStagesListTile(),
          const _MoreDivider(),
          const _CartListTile(),
          const _MoreDivider(),
        ],
        const _ContactUsListTile(),
        const _MoreDivider(),
        const _PrivacyListTile(),
        const _MoreDivider(),
        const _CommonQuestionsListTile(),
        if (!AppReference.userIsGuest()) ...[
          const _MoreDivider(),
          const _FormatAppListTile(),
        ],
        if (AppReference.userIsChild() && !AppReference.userIsGuest()) ...[
          const _MoreDivider(),
          const _showAsChildListTile(),
        ],
        if (AppReference.userIsParent()) ...[
          const _MoreDivider(),
          const _ShowAsParentListTile(),
        ],
        if (AppReference.userIsInstitution() || AppReference.userIsGuest()) ...[
          const _MoreDivider(),
          const _ShowAsParentListTile(),
          const _MoreDivider(),
          const _showAsChildListTile(),
        ],
        const _MoreDivider(),
        const _ShareAppListTile(),
        const _MoreDivider(),
        const _InviteFriendListTile(),
        const _MoreDivider(),
        if (AppReference.userIsGuest()) const _GuestRegistrationListTile(),
        if (!AppReference.userIsGuest())
          _LogoutListTile(onTap: () {
            logoutMethod();
          }),
      ],
    );
  }
}

class _showAsChildListTile extends StatelessWidget {
  const _showAsChildListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
        fromMore: true,
        title: AppStrings.watchAsParent,
        icon: AppImagesAssets.sTelescope,
        onTap: () {
          showDialog(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return const ShowChildParentOtherSide();
              });
        });
  }
}

class _ShowAsParentListTile extends StatelessWidget {
  const _ShowAsParentListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
        fromMore: true,
        title: AppStrings.watchAsChild,
        icon: AppImagesAssets.sTelescope,
        onTap: () {
          showDialog(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return const ShowChildParentOtherSide();
              });
        });
  }
}

class _LogoutListTile extends StatelessWidget {
  final Function() onTap;
  const _LogoutListTile({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      iconColor: AppColors.failColor,
      textColor: AppColors.failColor,
      fromMore: true,
      title: AppStrings.signOut,
      icon: AppIconsAssets.sLogoutArrow,
      buttonColor: AppColors.failColor.withOpacity(.2),
      onTap: () {
        onTap();
      },
    );
  }
}

class _GuestRegistrationListTile extends StatelessWidget {
  const _GuestRegistrationListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
        fromMore: true,
        title: AppStrings.guestRegistration,
        icon: AppIconsAssets.sHeart,
        onTap: () {
          RouteManager.rPushNamedAndRemoveUntil(
            context: context,
            rName: AppRoutesNames.rWelcome,
          );
        });
  }
}

class _InviteFriendListTile extends StatelessWidget {
  const _InviteFriendListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.inviteFriend,
      icon: AppIconsAssets.sInviteFriend,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rInviteFriendScreen,
          );
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _ShareAppListTile extends StatelessWidget {
  const _ShareAppListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.shareApp,
      icon: AppIconsAssets.sShare,
      onTap: () {
        Share.share(
            'Android \n https://play.google.com/store/apps/details?id=com.edu_tasses.my_portfolio&pli=1 \n\n\n Ios \n https://apps.apple.com/ca/app/taseese-%D8%AA%D8%A3%D8%B3%D9%8A%D8%B3/id6477544252');
      },
    );
  }
}

class _FormatAppListTile extends StatelessWidget {
  const _FormatAppListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
        fromMore: true,
        title: AppStrings.formatApp,
        icon: AppImagesAssets.sLoop,
        onTap: () async {
          context.read<MoreBloc>().add(FormatAppEvent());

          // String token = getIt<BaseAppSecurityData>().getToken()!;
          // var userData = getIt<UserLocalDataSource>().getUserData()!;
          // context.read<GlobalBloc>().refreshToken = true;
          // context.read<MoreBloc>().add(ReOpenBoxesEvent());
          // Future.delayed(const Duration(seconds: 3),
          //         () {
          //   getIt<BaseAppSecurityData>().saveToken(token: token);
          //   getIt<UserLocalDataSource>()
          //       .saveUserData(userModel: userData)
          //       .then((value) => RouteManager.rPushNamedAndRemoveUntil(
          //             context: context,
          //             rName: AppRoutesNames.rHomeLayoutView,
          //             arguments: userData,
          //           ));
          // });
        });
  }
}

class _CommonQuestionsListTile extends StatelessWidget {
  const _CommonQuestionsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.commonQuestions,
      icon: AppIconsAssets.sQuestions,
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rChildCommonQuestionsScreen,
        );
      },
    );
  }
}

class _PrivacyListTile extends StatelessWidget {
  const _PrivacyListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.privacy,
      icon: AppIconsAssets.sTerms,
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rTermsAndConditionsScreen,
        );
      },
    );
  }
}

class _ContactUsListTile extends StatelessWidget {
  const _ContactUsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.contactUs,
      icon: AppIconsAssets.sConnection,
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rContactUsScreen,
        );
      },
    );
  }
}

class _CartListTile extends StatelessWidget {
  const _CartListTile();

  @override
  Widget build(BuildContext context) {
    return !BlocProvider.of<GlobalBloc>(context).state.appVersionModel.isReview
        ? ListTileWidget(
            fromMore: true,
            title: AppStrings.toCart,
            icon: AppIconsAssets.sPaymentCart,
            onTap: () {
              RouteManager.rPushNamed(
                context: context,
                rName: AppRoutesNames.rCartScreen,
                arguments: getIt<UserLocalDataSource>().getUserData()!.userId,
              );
            },
          )
        : const SizedBox();
  }
}

class _OtherStagesListTile extends StatelessWidget {
  const _OtherStagesListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.otherStages,
      icon: AppImagesAssets.sStages,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamedAndRemoveUntil(
              context: context,
              rName: AppRoutesNames.rSubscriptionsSystemsScreen,
              arguments: DataToGoRandomExams(
                  isRandomExam: false,
                  user: getIt<UserLocalDataSource>().getUserData()!,
                  isPrimary: AppReference.childIsPrimary())
              );
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _RatingAppListTile extends StatelessWidget {
  final Function() onTap;
  const _RatingAppListTile({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.ratingApp,
      icon: AppImagesAssets.sStar,
      onTap: () {
        onTap();
      },
    );
  }
}

class _CouponsListTile extends StatelessWidget {
  const _CouponsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.coupons,
      icon: AppIconsAssets.sCouponDiscountMore,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rCouponsScreen,
          );
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _ReviewsListTile extends StatelessWidget {
  const _ReviewsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.reviews,
      icon: AppIconsAssets.sReviewMore,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rReviewScreen,
          );
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  const _SettingsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.settings,
      icon: AppImagesAssets.sSettings,
      onTap: () {
        RouteManager.rPushNamed(
          context: context,
          rName: AppRoutesNames.rChildSettingsScreen,
        );
      },
    );
  }
}

class _AccountDetailsListTile extends StatelessWidget {
  const _AccountDetailsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.accountDetails,
      icon: AppImagesAssets.sAccount,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rChildAccountDetailsScreen,
          );
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.responsiveWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SvgPicture.asset(
                AppImagesAssets.sPlantForMore,
                height: AppReference.deviceHeight(context) * 0.2,
              ),
            ),
            const Spacer(),
            //  const Expanded(child: ImageAccountMoreWidget()),
          ],
        ),
      ),
    );
  }
}

class _MoreDivider extends StatelessWidget {
  const _MoreDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.textColor6,
      endIndent: 50.responsiveWidth,
      indent: 50.responsiveWidth,
      height: 30.responsiveHeight,
    );
  }
}
