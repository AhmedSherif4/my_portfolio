part of '../../login.dart';

class ImageWidget extends StatelessWidget {
  final double height;

  const ImageWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AppImagesAssets.sLoginImage,
        width: AppReference.deviceWidth(context) * 0.95,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

class LoginTextSignIn extends StatelessWidget {
  const LoginTextSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.signIn,
      style: const AppTextStyle().balooBhaijaan2.w600.titleLarge22.copyWith(
        fontSize: AppReference.deviceIsTablet?AppFontSize.sp14.responsiveFontSize
            :AppFontSize.sp22.responsiveFontSize,
      ),
    );
  }
}

class ContactUsWidgetInLoginScreen extends StatelessWidget {
  const ContactUsWidgetInLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsBloc, ContactUsState>(
        builder: (context, state) {
      switch (state.getContactUsStates) {
        case RequestStates.loading:
          return LoadingShimmerStructure(
            width: double.infinity,
            height: AppSize.s30.responsiveHeight,
          );
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
              'typeUrl': state.getContactUsData!.facebook.isNotEmpty
                  ? state.getContactUsData!.facebook
                  : null,
              'iconUrl': AppIconsAssets.sFacebookLogo,
            },
            {
              'type': 'Whats App',
              'typeUrl': state.getContactUsData!.whatsapp.isNotEmpty
                  ? state.getContactUsData!.whatsapp
                  : null,
              'iconUrl': AppIconsAssets.sWhatsapp,
            },
            {
              'type': 'Telegram',
              'typeUrl': state.getContactUsData!.telegram!.isNotEmpty
                  ? state.getContactUsData!.telegram
                  : null,
              'iconUrl': AppIconsAssets.sTelegram,
            },
            {
              'type': 'Instagram',
              'typeUrl': state.getContactUsData!.instagram!.isNotEmpty
                  ? state.getContactUsData!.instagram
                  : null,
              'iconUrl': AppIconsAssets.sInstagram,
            },
            {
              'type': 'LinkedIn',
              'typeUrl': state.getContactUsData!.linkedIn!.isNotEmpty
                  ? state.getContactUsData!.linkedIn
                  : null,
              'iconUrl': AppIconsAssets.sLinkedin,
            },
            {
              'type': 'Pinterest',
              'typeUrl': state.getContactUsData!.pinterest!.isNotEmpty
                  ? state.getContactUsData!.pinterest
                  : null,
              'iconUrl': AppImagesAssets.sLogoWithoutName,
            },
            {
              'type': 'Snapchat',
              'typeUrl': state.getContactUsData!.snapchat!.isNotEmpty
                  ? state.getContactUsData!.snapchat
                  : null,
              'iconUrl': AppImagesAssets.sLogoWithoutName,
            },
            {
              'type': 'Threads',
              'typeUrl': state.getContactUsData!.threads!.isNotEmpty
                  ? state.getContactUsData!.threads
                  : null,
              'iconUrl': AppIconsAssets.sThreads,
            },
            {
              'type': 'Tiktok',
              'typeUrl': state.getContactUsData!.tiktok!.isNotEmpty
                  ? state.getContactUsData!.tiktok
                  : null,
              'iconUrl': AppIconsAssets.sTiktok,
            },
            {
              'type': 'Twitter',
              'typeUrl': state.getContactUsData!.twitter!.isNotEmpty
                  ? state.getContactUsData!.twitter
                  : null,
              'iconUrl': AppIconsAssets.sThreads,
            },
            {
              'type': 'Youtube',
              'typeUrl': state.getContactUsData!.youtube!.isNotEmpty
                  ? state.getContactUsData!.youtube
                  : null,
              'iconUrl': AppIconsAssets.sYoutube,
            },
          ];

          return TextButtonWidget(
              text: AppStrings.ifHaveProblemContactWithOwner,
              textColor: AppColors.textColor2,
              weight: AppFontWeight.regular2W500,
              fontSize:  AppFontSize.sp11,
              onPressed: () async {
                showModalBottomSheet(
                    backgroundColor: AppColors.backgroundColor,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => SizedBox(
                        height: AppReference.deviceHeight(context) / 2,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppIconsAssets.sMessages,
                                        height: AppSize.s90.responsiveHeight,
                                        width: AppSize.s90.responsiveWidth,
                                      ),
                                      Text("تواصل معنا",
                                          style: const AppTextStyle()
                                              .w400
                                              .titleLarge22),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: AppSize.s20.responsiveWidth),
                              sliver: SliverList.separated(
                                itemBuilder: (context, index) {
                                  if (data[index]['typeUrl'] != null) {
                                    return ContactUsLoginItem(
                                      type: data[index]['type'],
                                      url: data[index]['typeUrl'],
                                      svgImagePath: data[index]['iconUrl'],
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  if (data[index]['typeUrl'] != null) {
                                    return AppSize.s20.sizedBoxHeight;
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                                itemCount: data.length,
                              ),
                            ),
                          ],
                        )
                        // SingleChildScrollView(
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //         SvgPicture.asset(AppIconsAssets.sMessages,
                        //           height: AppSize.s90.responsiveHeight,
                        //           width: AppSize.s90.responsiveWidth,
                        //         ),
                        //         Text("تواصل معنا",style: const AppTextStyle().w400.titleLarge22),
                        //         ],
                        //       ),
                        //       ListView.separated(
                        //         shrinkWrap: true,
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         padding: EdgeInsets.all(AppSize.s20.responsiveSize),
                        //                         itemBuilder: (context, index) {
                        //       if (data[index]['typeUrl'] != null) {
                        //         return ContactUsLoginItem(
                        //           type: data[index]['type'],
                        //           url: data[index]['typeUrl'],
                        //           svgImagePath: data[index]['iconUrl'],
                        //         );
                        //       } else {
                        //         return 0.sizedBoxHeight;
                        //       }},
                        //         separatorBuilder: (context, index) {
                        //              if (data[index]['typeUrl'] != null){
                        //                return  AppSize.s20.sizedBoxHeight;
                        //
                        //           }else{
                        //                return 0.sizedBoxHeight;
                        //              }
                        //         },
                        //
                        //         itemCount: data.length,),
                        //     ],
                        //   ),
                        // ),
                        ));
                // launchUrl(
                //   Uri.parse(
                //     state.getContactUsData?.whatsapp ?? '',
                //   ),
                // );
              });
        case RequestStates.error:
          return CustomErrorWidget(
            errorMessage: state.getContactUsMessage,
          );
        default:
          return const SizedBox.shrink();
      }
    });
  }
}

class DonNtHaveAccount extends StatelessWidget {
  const DonNtHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        AppStrings.donotYouHaveAccount,

        style: const AppTextStyle().balooBhaijaan2.w500.bodySmall12.copyWith(
          fontSize: AppFontSize.sp12.responsiveFontSize,
        ),
      ),
      TextButtonWidget(
        text: AppStrings.registerNow2,
        weight: AppFontWeight.regular2W500,
        fontSize:AppReference.deviceIsTablet ? AppFontSize.sp10.responsiveFontSize : AppFontSize.sp12.responsiveFontSize,
        withDecoration: true,
        onPressed: () {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rSignUpScreen,
          );
        },
      )
    ]);
  }
}

class ContactUsLoginItem extends StatelessWidget {
  final String type;
  final String url;
  final String svgImagePath;

  const ContactUsLoginItem({
    super.key,
    required this.type,
    required this.url,
    required this.svgImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
      child: CustomInkWell(
        onTap: () {
          _lanchUrl(
            url: url,
            type: type,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(AppSize.s10.responsiveSize),
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
                        style: const AppTextStyle().w500.black.bodySmall12,
                      ),
                    ),
                    AppSize.s10.sizedBoxWidth,
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black,
                      size: AppSize.s20.responsiveSize,
                    ),
                    AppSize.s10.sizedBoxWidth,
                  ],
                ),
              ),
            ),
          ],
        ),
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
