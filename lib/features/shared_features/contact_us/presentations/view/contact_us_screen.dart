import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_text_style.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../auth/shared_screens/login/login.dart';
import '../../../more/presentation/more_widgets/header_for_more.dart';
import '../view_model/contact_us_bloc.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactUsBloc>()..add(GetContactUsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HeaderForMore(title: AppStrings.contactUs,)
                  .paddingBody(),
              AppSize.s30.sizedBoxHeight,
              const OrientationItem(
                portraitWidget:  _ContactUsPortraitView(),
                landscapeWidget: ResponsiveWidgetForTablet(
                  mobile:  _ContactUsMobileLandScapeView(),
                  tablet:  _ContactUsTabletLandScapeView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactUsMobileLandScapeView extends StatelessWidget {
  const _ContactUsMobileLandScapeView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            AppImagesAssets.sContactusLogo,
            fit: BoxFit.fill,
            width: AppReference.deviceWidth(context) * 0.3,
          ),
          SizedBox(
            width: AppReference.deviceWidth(context) * 0.6,
            child: BlocBuilder<ContactUsBloc, ContactUsState>(
              builder: (context, state) {
                switch (state.getContactUsStates) {
                  case RequestStates.loading:
                    return const LoadingShimmerList();
                  case RequestStates.loaded:
                    List<Map<String, dynamic>> data = [
                      {
                        'type': 'Email',
                        'typeUrl': state.getContactUsData!.email.isNotEmpty
                            ? state.getContactUsData!.email
                            : null,
                        'iconUrl': AppIconsAssets.sGmail,
                      },
                      {
                        'type': 'FaceBook',
                        'typeUrl':
                        state.getContactUsData!.facebook.isNotEmpty
                            ? state.getContactUsData!.facebook
                            : null,
                        'iconUrl': AppIconsAssets.sFacebookLogo,
                      },
                      {
                        'type': 'Whats App',
                        'typeUrl':
                        state.getContactUsData!.whatsapp.isNotEmpty
                            ? state.getContactUsData!.whatsapp
                            : null,
                        'iconUrl': AppIconsAssets.sWhatsapp,
                      },
                      {
                        'type': 'Instagram',
                        'typeUrl':
                        state.getContactUsData!.instagram!.isNotEmpty
                            ? state.getContactUsData!.instagram
                            : null,
                        'iconUrl': AppIconsAssets.sInstagram,
                      },
                      {
                        'type': 'Snapchat',
                        'typeUrl':
                        state.getContactUsData!.snapchat!.isNotEmpty
                            ? state.getContactUsData!.snapchat
                            : null,
                        'iconUrl': AppImagesAssets.sLogoWithoutName,
                      },
                      {
                        'type': 'Tiktok',
                        'typeUrl':
                        state.getContactUsData!.tiktok!.isNotEmpty
                            ? state.getContactUsData!.tiktok
                            : null,
                        'iconUrl': AppIconsAssets.sTiktok,
                      },
                      {
                        'type': 'Twitter',
                        'typeUrl':
                        state.getContactUsData!.twitter!.isNotEmpty
                            ? state.getContactUsData!.twitter
                            : null,
                        'iconUrl': AppIconsAssets.sThreads,
                      },
                      {
                        'type': 'Telegram',
                        'typeUrl':
                        state.getContactUsData!.telegram!.isNotEmpty
                            ? state.getContactUsData!.telegram
                            : null,
                        'iconUrl': AppIconsAssets.sTelegram,
                      },
                      {
                        'type': 'LinkedIn',
                        'typeUrl':
                        state.getContactUsData!.linkedIn!.isNotEmpty
                            ? state.getContactUsData!.linkedIn
                            : null,
                        'iconUrl': AppIconsAssets.sLinkedin,
                      },
                      {
                        'type': 'Pinterest',
                        'typeUrl':
                        state.getContactUsData!.pinterest!.isNotEmpty
                            ? state.getContactUsData!.pinterest
                            : null,
                        'iconUrl': AppImagesAssets.sLogoWithoutName,
                      },

                      {
                        'type': 'Threads',
                        'typeUrl':
                        state.getContactUsData!.threads!.isNotEmpty
                            ? state.getContactUsData!.threads
                            : null,
                        'iconUrl': AppIconsAssets.sThreads,
                      },

                      {
                        'type': 'Youtube',
                        'typeUrl':
                        state.getContactUsData!.youtube!.isNotEmpty
                            ? state.getContactUsData!.youtube
                            : null,
                        'iconUrl': AppIconsAssets.sYoutube,
                      },
                    ];
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        if (data[index]['typeUrl'] != null) {
                          return ContactUsLoginItem(
                            type: data[index]['type'],
                            url: data[index]['typeUrl'],
                            svgImagePath: data[index]['iconUrl'],
                          ).paddingBody(bottom: 0,top: 0);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (context, index) {
                        if (data[index]['typeUrl'] != null) {
                          return 20.sizedBoxHeight;

                        }else{
                          return const SizedBox.shrink();
                        }
                      },
                      itemCount: data.length,
                      shrinkWrap: true,
                    );
                  case RequestStates.error:
                    return CustomErrorWidget(
                        errorMessage: state.getContactUsMessage);

                  default:
                    return const SizedBox();
                }
              },
            ),
          )


        ],
      ),
    );
  }
}

class _ContactUsTabletLandScapeView extends StatelessWidget {
  const _ContactUsTabletLandScapeView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppImagesAssets.sContactusLogo,
            fit: BoxFit.fill,
            width: AppReference.deviceWidth(context) * 0.3,
          ).paddingBody(),
          AppSize.s30.sizedBoxHeight,
          Expanded(
            child:BlocBuilder<ContactUsBloc, ContactUsState>(
              builder: (context, state) {
                switch (state.getContactUsStates) {
                  case RequestStates.loading:
                    return const LoadingShimmerList();
                  case RequestStates.loaded:
                    List<Map<String, dynamic>> data = [
                      {
                        'type': 'Email',
                        'typeUrl': state.getContactUsData!.email.isNotEmpty
                            ? state.getContactUsData!.email
                            : null,
                        'iconUrl': AppIconsAssets.sGmail,
                      },
                      {
                        'type': 'FaceBook',
                        'typeUrl':
                        state.getContactUsData!.facebook.isNotEmpty
                            ? state.getContactUsData!.facebook
                            : null,
                        'iconUrl': AppIconsAssets.sFacebookLogo,
                      },
                      {
                        'type': 'Whats App',
                        'typeUrl':
                        state.getContactUsData!.whatsapp.isNotEmpty
                            ? state.getContactUsData!.whatsapp
                            : null,
                        'iconUrl': AppIconsAssets.sWhatsapp,
                      },
                      {
                        'type': 'Instagram',
                        'typeUrl':
                        state.getContactUsData!.instagram!.isNotEmpty
                            ? state.getContactUsData!.instagram
                            : null,
                        'iconUrl': AppIconsAssets.sInstagram,
                      },
                      {
                        'type': 'Snapchat',
                        'typeUrl':
                        state.getContactUsData!.snapchat!.isNotEmpty
                            ? state.getContactUsData!.snapchat
                            : null,
                        'iconUrl': AppImagesAssets.sLogoWithoutName,
                      },
                      {
                        'type': 'Tiktok',
                        'typeUrl':
                        state.getContactUsData!.tiktok!.isNotEmpty
                            ? state.getContactUsData!.tiktok
                            : null,
                        'iconUrl': AppIconsAssets.sTiktok,
                      },
                      {
                        'type': 'Twitter',
                        'typeUrl':
                        state.getContactUsData!.twitter!.isNotEmpty
                            ? state.getContactUsData!.twitter
                            : null,
                        'iconUrl': AppIconsAssets.sThreads,
                      },
                      {
                        'type': 'Telegram',
                        'typeUrl':
                        state.getContactUsData!.telegram!.isNotEmpty
                            ? state.getContactUsData!.telegram
                            : null,
                        'iconUrl': AppIconsAssets.sTelegram,
                      },
                      {
                        'type': 'LinkedIn',
                        'typeUrl':
                        state.getContactUsData!.linkedIn!.isNotEmpty
                            ? state.getContactUsData!.linkedIn
                            : null,
                        'iconUrl': AppIconsAssets.sLinkedin,
                      },
                      {
                        'type': 'Pinterest',
                        'typeUrl':
                        state.getContactUsData!.pinterest!.isNotEmpty
                            ? state.getContactUsData!.pinterest
                            : null,
                        'iconUrl': AppImagesAssets.sLogoWithoutName,
                      },

                      {
                        'type': 'Threads',
                        'typeUrl':
                        state.getContactUsData!.threads!.isNotEmpty
                            ? state.getContactUsData!.threads
                            : null,
                        'iconUrl': AppIconsAssets.sThreads,
                      },

                      {
                        'type': 'Youtube',
                        'typeUrl':
                        state.getContactUsData!.youtube!.isNotEmpty
                            ? state.getContactUsData!.youtube
                            : null,
                        'iconUrl': AppIconsAssets.sYoutube,
                      },
                    ];
                    return
                    GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 8/.8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 30,),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (data[index]['typeUrl'] != null) {
                          return ContactUsLoginItem(
                            type: data[index]['type'],
                            url: data[index]['typeUrl'],
                            svgImagePath: data[index]['iconUrl'],
                          ).paddingBody(bottom: 0,top: 0);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  case RequestStates.error:
                    return CustomErrorWidget(
                        errorMessage: state.getContactUsMessage);

                  default:
                    return const SizedBox();
                }
              },
            )
            ,
          )
        ],
      ),
    );
  }
}

class _ContactUsPortraitView extends StatelessWidget {
  const _ContactUsPortraitView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppImagesAssets.sContactusLogo,
            fit: BoxFit.fill,
            width: AppReference.deviceWidth(context) * 0.3,
          ).paddingBody(),
          AppSize.s30.sizedBoxHeight,
          Expanded(
            child: BlocBuilder<ContactUsBloc, ContactUsState>(
              builder: (context, state) {
                switch (state.getContactUsStates) {
                  case RequestStates.loading:
                    return const LoadingShimmerList();
                  case RequestStates.loaded:
                    List<Map<String, dynamic>> data = [
                      {
                        'type': 'Email',
                        'typeUrl': state.getContactUsData!.email.isNotEmpty
                            ? state.getContactUsData!.email
                            : null,
                        'iconUrl': AppIconsAssets.sGmail,
                      },
                      {
                        'type': 'FaceBook',
                        'typeUrl':
                            state.getContactUsData!.facebook.isNotEmpty
                                ? state.getContactUsData!.facebook
                                : null,
                        'iconUrl': AppIconsAssets.sFacebookLogo,
                      },
                      {
                        'type': 'Whats App',
                        'typeUrl':
                            state.getContactUsData!.whatsapp.isNotEmpty
                                ? state.getContactUsData!.whatsapp
                                : null,
                        'iconUrl': AppIconsAssets.sWhatsapp,
                      },
                      {
                        'type': 'Instagram',
                        'typeUrl':
                        state.getContactUsData!.instagram!.isNotEmpty
                            ? state.getContactUsData!.instagram
                            : null,
                        'iconUrl': AppIconsAssets.sInstagram,
                      },
                      {
                        'type': 'Snapchat',
                        'typeUrl':
                        state.getContactUsData!.snapchat!.isNotEmpty
                            ? state.getContactUsData!.snapchat
                            : null,
                        'iconUrl': AppImagesAssets.sLogoWithoutName,
                      },
                      {
                        'type': 'Tiktok',
                        'typeUrl':
                        state.getContactUsData!.tiktok!.isNotEmpty
                            ? state.getContactUsData!.tiktok
                            : null,
                        'iconUrl': AppIconsAssets.sTiktok,
                      },
                      {
                        'type': 'Twitter',
                        'typeUrl':
                        state.getContactUsData!.twitter!.isNotEmpty
                            ? state.getContactUsData!.twitter
                            : null,
                        'iconUrl': AppIconsAssets.sThreads,
                      },
                      {
                        'type': 'Telegram',
                        'typeUrl':
                            state.getContactUsData!.telegram!.isNotEmpty
                                ? state.getContactUsData!.telegram
                                : null,
                        'iconUrl': AppIconsAssets.sTelegram,
                      },
                      {
                        'type': 'LinkedIn',
                        'typeUrl':
                            state.getContactUsData!.linkedIn!.isNotEmpty
                                ? state.getContactUsData!.linkedIn
                                : null,
                        'iconUrl': AppIconsAssets.sLinkedin,
                      },
                      {
                        'type': 'Pinterest',
                        'typeUrl':
                            state.getContactUsData!.pinterest!.isNotEmpty
                                ? state.getContactUsData!.pinterest
                                : null,
                        'iconUrl': AppImagesAssets.sLogoWithoutName,
                      },

                      {
                        'type': 'Threads',
                        'typeUrl':
                            state.getContactUsData!.threads!.isNotEmpty
                                ? state.getContactUsData!.threads
                                : null,
                        'iconUrl': AppIconsAssets.sThreads,
                      },

                      {
                        'type': 'Youtube',
                        'typeUrl':
                            state.getContactUsData!.youtube!.isNotEmpty
                                ? state.getContactUsData!.youtube
                                : null,
                        'iconUrl': AppIconsAssets.sYoutube,
                      },
                    ];
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        if (data[index]['typeUrl'] != null) {
                          return ContactUsLoginItem(
                            type: data[index]['type'],
                            url: data[index]['typeUrl'],
                            svgImagePath: data[index]['iconUrl'],
                          ).paddingBody(bottom: 0,top: 0);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (context, index) {
                        if (data[index]['typeUrl'] != null) {
                      return 20.sizedBoxHeight;

                      }else{
                         return const SizedBox.shrink();
                      }
                      },
                      itemCount: data.length,
                    );
                  case RequestStates.error:
                    return CustomErrorWidget(
                        errorMessage: state.getContactUsMessage);

                  default:
                    return const SizedBox();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.3.responsiveHeightRatio,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(25.responsiveSize),
          bottomEnd: Radius.circular(25.responsiveSize),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderForMore(title: AppStrings.contactUs, textColor: AppColors.white)
              .paddingBody(),
          const Spacer(),
          Expanded(
            flex: 6,
            child: Center(
              child: SvgPicture.asset(
                AppImagesAssets.sContactusLogo,
                fit: BoxFit.fill,
                width: AppReference.deviceWidth(context) * 0.4,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class ContactUsItem extends StatelessWidget {
  final String type;
  final String url;
  final String svgImagePath;

  const ContactUsItem({
    super.key,
    required this.type,
    required this.url,
    required this.svgImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10.responsiveSize),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.responsiveSize),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      svgImagePath,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      type,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const AppTextStyle()
                          .w500
                          .black
                          .bodySmall12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.sizedBoxWidth,
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () {
                  _lanchUrl(
                    url: url,
                    type: type,
                  );
                },
                child: Text(
                  url,
                  style: const AppTextStyle().balooBhaijaan2.w500.blue.bodySmall12,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _lanchUrl({required url, String? type}) async {
    if (type == 'Email') {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: url,
      );
      await launchUrl(emailLaunchUri);
    } else {
      final lanUrl = Uri.parse(url);
      await launchUrl(lanUrl);
    }
  }
}
