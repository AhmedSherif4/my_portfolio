import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/features/shared_features/notification/presentation/view_model/notification_bloc.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../config/resources/app_colors.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../more/presentation/more_widgets/header_for_more.dart';
import '../../domain/repository/notification_repository.dart';

class NotificationManagerScreen extends StatefulWidget {
  const NotificationManagerScreen({super.key});

  @override
  State<NotificationManagerScreen> createState() =>
      _NotificationManagerScreenState();
}

class _NotificationManagerScreenState extends State<NotificationManagerScreen> {
  late String notificationMarkExam;
  late String notificationReUploadExam;
  late String notificationLessonFinish;
  late String notificationLogin;
  late String notificationSessionTime;

  @override
  void initState() {
    super.initState();
    notificationMarkExam =
        getIt<UserLocalDataSource>().getUserData()!.notificationMarkExam!;
    notificationReUploadExam =
        getIt<UserLocalDataSource>().getUserData()!.notificationReUploadExam!;
    notificationLessonFinish =
        getIt<UserLocalDataSource>().getUserData()!.notificationLessonFinish!;
    notificationLogin =
        getIt<UserLocalDataSource>().getUserData()!.notificationLogin!;
    notificationSessionTime =
        getIt<UserLocalDataSource>().getUserData()!.notificationSessionTime!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        switch (state.updateNotificationState) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.pop(context);
            showSnackBar(
                description: state.updateNotificationMessage,
                state: ToastStates.congrats,
                context: context);
            final user = getIt<UserLocalDataSource>().getUserData()!;
            final temp = user.copyWith(
                notificationMarkExam: notificationMarkExam,
                notificationReUploadExam: notificationReUploadExam,
                notificationLessonFinish: notificationLessonFinish,
                notificationLogin: notificationLogin,
                notificationSessionTime: notificationSessionTime);

            getIt<UserLocalDataSource>().saveUserData(userModel: temp);

          case RequestStates.error:
            Navigator.pop(context);
            showSnackBar(
                description: state.updateNotificationMessage,
                state: ToastStates.error,
                context: context);
          default:
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const HeaderForMore(title: AppStrings.notificationsTitle),
              AppSize.s50.sizedBoxHeight,
              SizedBox(
                width: (AppReference.deviceIsTablet && !AppReference.isPortrait(context))?AppReference.deviceWidth(context)*.6:AppReference.deviceWidth(context),
                child: Column(
                  children: [
                    NotificationManageItem(
                      title: AppStrings.whenExamCorrect,
                      value: (String value) {
                        notificationMarkExam = value;
                        context.read<NotificationBloc>().add(
                              UpdateNotificationEvent(
                                notificationManagerParameters:
                                    NotificationManagerParameters(
                                  markExam: notificationMarkExam,
                                  reUploadExam: notificationReUploadExam,
                                  lessonFinish: notificationLessonFinish,
                                  login: notificationLogin,
                                  sessionTime: notificationSessionTime,
                                ),
                              ),
                            );
                      },
                      isOn: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .notificationMarkExam!,
                    ),
                    AppSize.s20.sizedBoxHeight,
                    NotificationManageItem(
                      title: AppStrings.whenExamReUpload,
                      value: (String value) {
                        notificationReUploadExam = value;
                        context.read<NotificationBloc>().add(
                          UpdateNotificationEvent(
                            notificationManagerParameters:
                            NotificationManagerParameters(
                              markExam: notificationMarkExam,
                              reUploadExam: notificationReUploadExam,
                              lessonFinish: notificationLessonFinish,
                              login: notificationLogin,
                              sessionTime: notificationSessionTime,
                            ),
                          ),
                        );
                      },
                      isOn: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .notificationReUploadExam!,
                    ),
                    AppSize.s20.sizedBoxHeight,
                    NotificationManageItem(
                      title: AppStrings.whenFinishLesson,
                      value: (String value) {
                        notificationLessonFinish = value;
                        context.read<NotificationBloc>().add(
                          UpdateNotificationEvent(
                            notificationManagerParameters:
                            NotificationManagerParameters(
                              markExam: notificationMarkExam,
                              reUploadExam: notificationReUploadExam,
                              lessonFinish: notificationLessonFinish,
                              login: notificationLogin,
                              sessionTime: notificationSessionTime,
                            ),
                          ),
                        );
                      },
                      isOn: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .notificationLessonFinish!,
                    ),
                    AppSize.s20.sizedBoxHeight,
                    NotificationManageItem(
                      title: AppStrings.whenLogin,
                      value: (String value) {
                        notificationLogin = value;
                        context.read<NotificationBloc>().add(
                          UpdateNotificationEvent(
                            notificationManagerParameters:
                            NotificationManagerParameters(
                              markExam: notificationMarkExam,
                              reUploadExam: notificationReUploadExam,
                              lessonFinish: notificationLessonFinish,
                              login: notificationLogin,
                              sessionTime: notificationSessionTime,
                            ),
                          ),
                        );
                      },
                      isOn: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .notificationLogin!,
                    ),
                    AppSize.s20.sizedBoxHeight,
                    NotificationManageItem(
                      title: AppStrings.timeInAppNoti,
                      value: (String value) {
                        notificationSessionTime = value;
                        context.read<NotificationBloc>().add(
                          UpdateNotificationEvent(
                            notificationManagerParameters:
                            NotificationManagerParameters(
                              markExam: notificationMarkExam,
                              reUploadExam: notificationReUploadExam,
                              lessonFinish: notificationLessonFinish,
                              login: notificationLogin,
                              sessionTime: notificationSessionTime,
                            ),
                          ),
                        );
                      },
                      isOn: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .notificationSessionTime!,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ).paddingBody(),
    ));
  }
}

class NotificationManageItem extends StatefulWidget {
  final String title;
  final Function(String value) value;
  final String isOn;

  const NotificationManageItem({
    super.key,
    required this.title,
    required this.value,
    required this.isOn,
  });

  @override
  State<NotificationManageItem> createState() => _NotificationManageItemState();
}

class _NotificationManageItemState extends State<NotificationManageItem> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.isOn == 'on' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(AppIconsAssets.sNotificationIccon),
      title: Text(
        widget.title,
        style: const AppTextStyle().w500.bodyMedium14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize),
      ),
      tileColor: AppColors.white,
      trailing: Switch(
        activeColor: AppColors.white,
        inactiveThumbColor: AppColors.black,
        activeTrackColor: AppColors.primaryColor,
        inactiveTrackColor: AppColors.primaryColor2,
        value: isOn,
        onChanged: (bool value) {
          setState(() {
            isOn = value;
            if (value) {
              widget.value('on');
            } else {
              widget.value('off');
            }
          });
        },
      ),
    );
  }
}
