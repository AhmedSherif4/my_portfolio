import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/features/home/components/lottie_widget.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'ahmedsherif4175@gmail.com',
                        );
                        await launchUrl(emailLaunchUri);
                      },
                      icon: GetInTouchLottieWidget(
                          lottieAssert: AppLottieAssets.sGmail),
                    ),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://www.facebook.com/profile.php?id=100039122532490');
                        await launchUrl(url);
                      },
                      icon: GetInTouchLottieWidget(
                          lottieAssert: AppLottieAssets.sFacebook),
                    ),
                    IconButton(
                      onPressed: () async {
                        final Uri url =
                            Uri.parse('https://github.com/AhmedSherif4');
                        await launchUrl(url);
                      },
                      icon: GetInTouchLottieWidget(
                          lottieAssert: AppLottieAssets.sGitHub),
                    ),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://www.linkedin.com/in/ahmed-sherif-5587b81b4/');
                        await launchUrl(url);
                      },
                      icon: GetInTouchLottieWidget(
                          lottieAssert: AppLottieAssets.sLinkedIn),
                    ),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://www.youtube.com/@ahmedsherif948');
                        await launchUrl(url);
                      },
                      icon: GetInTouchLottieWidget(
                          lottieAssert: AppLottieAssets.sYoutube),
                    ),
                  ],
                ),
                Text(
                  '© Ahmed Sherif 2024\n Powered By Flutter',
                  style: AppTextStyle().darkColor.labelLarge16w5.copyWith(
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
    ;
  }
}
