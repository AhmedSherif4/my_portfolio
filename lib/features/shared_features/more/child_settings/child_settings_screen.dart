import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_portfolio/config/notification/notification_setup.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_bloc.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_event.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_bloc.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../core/base_widgets/loading_widget.dart';
import '../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../core/shared_widget/dialogs/exit_dialog.dart';
import '../../../../core/shared_widget/dialogs/permissions_dialog.dart';
import '../more_view_model/more_event.dart';
import '../more_view_model/more_state.dart';
import '../more_widgets/more_widgets.dart';
import '../presentation/more_widgets/header_for_more.dart';

class ChildSettingsScreen extends StatefulWidget {
  const ChildSettingsScreen({super.key});

  @override
  State<ChildSettingsScreen> createState() => _ChildSettingsScreenState();
}

class _ChildSettingsScreenState extends State<ChildSettingsScreen> {
  bool confirmDeleteAccount = false;

  String? notificationStatus;

  @override
  void initState() {
    super.initState();
    _notiStatus();
  }

  void _notiStatus() async {
    await NotificationSetup.notiPermissionStatus()
        ? notificationStatus = 'on'
        : notificationStatus = 'off';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<MoreBloc, MoreState>(
  listener: (context, state) {
    switch(state.logoutState){
      case RequestStates.loading:
        showLoadingDialog(context);
      case RequestStates.loaded:
        Navigator.pop(context);
        showSnackBar(
            description: "لقد تم حذف الحساب بنجاح",
            state: ToastStates.congrats,
            context: context);
        RouteManager.rPushNamedAndRemoveUntil(context: context, rName: AppRoutesNames.rWelcome);
        case RequestStates.error:
        Navigator.pop(context);
        showSnackBar(
            description: "حدث خطاء غير معروف",
            state: ToastStates.warning,
            context: context);
        default:
    }
  },
  child: Column(
            children: [
              const HeaderForMore(title: AppStrings.settings),
              ResponsiveWidgetForTablet(
                mobile: _ChildSettingsScreenPortraitView(
                  notificationScreenOnTap: _notificationScreenOnTap,
                  deleteAccount: _deleteAccount,
                ),
                tablet: OrientationItem(
                  portraitWidget: _ChildSettingsScreenPortraitView(
                    notificationScreenOnTap: _notificationScreenOnTap,
                    deleteAccount: _deleteAccount,
                  ),
                  landscapeWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _BannerWidget(
                        heightRatio: 0.15,
                      ),
                      AppSize.s20.sizedBoxWidth,
                      SizedBox(
                        width: AppReference.deviceWidth(context) * 0.4,
                        child: Column(
                          children: [
                            if (AppReference.userIsChild()) ...[
                              const _ParentListTile(),
                              AppSize.s10.sizedBoxHeight,
                            ],
                            _NotificationListTile(
                                onTap: _notificationScreenOnTap),
                            if (!AppReference.userIsChild()) ...[
                              AppSize.s10.sizedBoxHeight,
                              const _NotificationSettingsListTile(),
                            ],
                            AppSize.s10.sizedBoxHeight,
                            DefaultButtonWithIcon(
                              title: AppStrings.deleteAccount,
                              svgIconPath: AppIconsAssets.sRemove,
                              backgroundColor:
                                  AppColors.failColor.withOpacity(.1),
                              textColor: AppColors.failColor,
                              isDeleteButton: true,
                              onTap: () {
                                _deleteAccount();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
),
        ),
      ).paddingBody(),
    );
  }

  void _deleteAccount() {
    if (AppReference.userIsGuest()) {
      AppReference.guestDialogMustLogin(context);
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => ExitAndUpdateDialog(
            message: AppStrings.wantToDeleteAccount,
            title: AppStrings.wantToDeleteAccountTitle,
            withImage: false,
            confirm: (value) {
              confirmDeleteAccount = value;
            }),
      ).then((value) {
        if (confirmDeleteAccount) {
          context.read<GlobalBloc>().isLogoutButton = false;
          if (AppReference.userIsChild()) {
            context.read<GlobalBloc>().add(const SendTimeInAppEvent());
            context.read<GlobalBloc>().goToWelcome = true;
          } else {
            context.read<MoreBloc>().add(LogoutEvent());
          }
        }
      });
    }
  }

  _notificationScreenOnTap() async {
    if (await NotificationSetup.notiPermissionStatus()) {
      _goToNotificationScreen();
    } else if (await NotificationSetup.notiPermission.isDenied) {
      if (mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: AppStrings.permissionMessage,
          buttonText1: AppStrings.alright,
          buttonOnPressed1: () async {
            await NotificationSetup.notiPermissionRequest();
            if (mounted) {
              Navigator.pop(context);
            }
            if (await NotificationSetup.notiPermission.isGranted) {
              if (context.mounted) {
                _goToNotificationScreen();
              }
            }
          },
          buttonText2: AppStrings.notNow,
          buttonOnPressed2: () => Navigator.pop(context),
        );
      }
    } else if (await NotificationSetup.notiPermission.isPermanentlyDenied) {
      if (mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: AppStrings.notificationPermissionMessage,
          buttonText1: AppStrings.alright,
          buttonOnPressed1: () async {
            if (await openAppSettings()) {
              await AppSettings.openAppSettings()
                  .then((value) => Navigator.pop(context));
            } else {
              if (mounted) {
                Navigator.pop(context);
                showSnackBar(
                  description: AppStrings.deviceNotSupported,
                  state: ToastStates.info,
                  context: context,
                );
              }
            }
          },
          buttonText2: AppStrings.notNow,
          buttonOnPressed2: () => Navigator.pop(context),
        );
      }
    }
  }

  _goToNotificationScreen() {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rNotificationScreen,
    );
  }
}

class _NotificationSettingsListTile extends StatelessWidget {
  const _NotificationSettingsListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.updateNotificationsTitle,
      icon: AppIconsAssets.sNotificationIccon,
      iconHeight: AppSize.s20,
      iconWidth: AppSize.s20,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rUpdateNotificationScreen,
          );
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _NotificationListTile extends StatelessWidget {
  final Function() onTap;
  const _NotificationListTile({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.notificationsTitle,
      icon: AppIconsAssets.sNotification,
      onTap: AppReference.userIsGuest()
          ? () {
              AppReference.guestDialogMustLogin(context);
            }
          : () {
              onTap();
            },
    );
  }
}

class _ParentListTile extends StatelessWidget {
  const _ParentListTile();

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      fromMore: true,
      title: AppStrings.parent,
      icon: AppIconsAssets.sHeart,
      onTap: () {
        if (!AppReference.userIsGuest()) {
          RouteManager.rPushNamed(
              context: context,
              rName: AppRoutesNames.rParentPreviewForChildScreen);
        } else {
          AppReference.guestDialogMustLogin(context);
        }
      },
    );
  }
}

class _ChildSettingsScreenPortraitView extends StatelessWidget {
  final Function() notificationScreenOnTap;
  final Function() deleteAccount;
  const _ChildSettingsScreenPortraitView({
    required this.notificationScreenOnTap,
    required this.deleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _BannerWidget(
          heightRatio: 0.1,
        ),
        if (AppReference.userIsChild()) const _ParentListTile(),
        _NotificationListTile(onTap: () {
          notificationScreenOnTap();
        }),
        if (!AppReference.userIsChild()) const _NotificationSettingsListTile(),
        AppSize.s10.sizedBoxHeight,
        DefaultButtonWithIcon(
          title: AppStrings.deleteAccount,
          svgIconPath: AppIconsAssets.sRemove,
          backgroundColor: AppColors.failColor.withOpacity(.1),
          textColor: AppColors.failColor,
          isDeleteButton: true,
          onTap: () {
            deleteAccount();
          },
        ),
      ],
    );
  }
}

class _BannerWidget extends StatelessWidget {
  final double heightRatio;
  const _BannerWidget({
    required this.heightRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsetsDirectional.all(AppPadding.p20.responsiveSize),
        child: SvgPicture.asset(
          AppImagesAssets.sSettings,
          height: AppReference.deviceHeight(context) *
              heightRatio.responsiveHeightRatio,
        ),
      ),
    );
  }
}
