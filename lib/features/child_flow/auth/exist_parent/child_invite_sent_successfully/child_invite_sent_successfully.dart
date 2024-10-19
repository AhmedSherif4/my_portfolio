import 'package:flutter/material.dart';
import 'package:my_portfolio/features/auth/shared_screens/base%20screens/base_invetion_successfully_person.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../config/resources/app_assets.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_text_style.dart';

class ChildInviteSentSuccessfully extends StatelessWidget {
  const ChildInviteSentSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSendInvetionSuccessfully(
      isParentPath: false,
      title: AppStrings.sentMessageForTheParent,
      image: AppIconsAssets.sSendParentSuccess,
      imageWidth: AppReference.deviceWidth(context) * 0.8,
      imageHeight: AppReference.deviceIsTablet?AppReference.deviceHeight(context) * 0.45:AppReference.deviceHeight(context) * 0.35,
      description: [

        TextSpan(

          text: AppStrings.theParentWillBeAddedAutomaticallyAfterAccept,
          style: AppReference.deviceIsTablet?const AppTextStyle().w600.s14.bodyLarge16: AppReference.themeData.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
