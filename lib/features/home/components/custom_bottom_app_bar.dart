import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/app_constants.dart';
import '../../../config/resources/app_text_style.dart';
import '../../../my_app/app_reference.dart';
import 'custom_painter_widgets.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, AppReference.deviceHeight(context) * 0.3),
      painter: TopInwardCurvePainter(),
      child: Container(
        margin: const EdgeInsets.all(AppConstants.appPaddingR20),
        width: double.infinity,
        height: AppReference.deviceHeight(context) * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _IconButtonWidget(
                      uri: 'ahmedsherif4175@gmail.com',
                      image: AppIconsAssets.pGmail,
                    ),
                    _IconButtonWidget(
                      uri:
                          'https://www.facebook.com/profile.php?id=100039122532490',
                      image: AppIconsAssets.pFacebook,
                    ),
                    _IconButtonWidget(
                      uri: 'https://github.com/AhmedSherif4',
                      image: AppIconsAssets.pGithub,
                    ),
                    _IconButtonWidget(
                      uri:
                          'https://www.linkedin.com/in/ahmed-sherif-5587b81b4/',
                      image: AppIconsAssets.pLinkedIn,
                    ),
                    _IconButtonWidget(
                      uri: 'https://www.youtube.com/@ahmedsherif948',
                      image: AppIconsAssets.pYoutube,
                    ),
                  ],
                ),
                Text(
                  '© Ahmed Sherif 2024\n Powered By Flutter',
                  style: const AppTextStyle().darkColor.labelLarge16w5.copyWith(
                        fontSize: 10,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButtonWidget extends StatelessWidget {
  final String uri;
  final String image;

  const _IconButtonWidget({required this.uri, required this.image});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final Uri url = (uri.contains('gmail'))
              ? Uri(
                  scheme: 'mailto',
                  path: uri,
                )
              : Uri.parse(uri);

          await launchUrl(url);
        },
        icon: Image.asset(
          image,
          height: AppReference.deviceHeight(context) * 0.05,
        ) /* GetInTouchLottieWidget(
                          lottieAssert: AppLottieAssets.sYoutube),
                    */
        );
  }
}
