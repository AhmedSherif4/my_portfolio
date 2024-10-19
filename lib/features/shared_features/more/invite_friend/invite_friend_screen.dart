import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/text_form_field.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../config/resources/app_assets.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_constants.dart';
import '../../../../config/resources/app_strings.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../config/resources/app_values.dart';
import '../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../presentation/more_widgets/header_for_more.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({super.key});

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
   late TextEditingController _controller;
   @override
  void initState() {
_controller = TextEditingController();
_controller.text=getIt<UserLocalDataSource>().getUserData()!.username;
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [ const HeaderForMore(
            title: AppStrings.inviteFriend,
            haveIcon: false,
          ),
            AppSize.s30.sizedBoxHeight,
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width:  !AppReference.isPortrait(context)?AppReference.deviceWidth(context) * 0.4:AppReference.deviceWidth(context),
                  child: Column(
                    children: [
                      Container(
                        width:  !AppReference.isPortrait(context)?AppReference.deviceWidth(context) * 0.4:AppReference.deviceWidth(context),

                        padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p44.responsiveSize),
                        height: AppSize.s100.responsiveSize,
                        decoration: BoxDecoration(
                          gradient: AppGradientColors.pointsGradient,
                          borderRadius: BorderRadius.circular(
                              AppConstants.appBorderRadiusR20.responsiveSize),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "دعوة صديق",
                                    style: const AppTextStyle()
                                        .balooBhaijaan2
                                        .w800
                                        .white
                                        .bodyMedium14,
                                  ),
                                  Text(
                                    "قم بدعوة صديق وأحصل علي نقاط",
                                    style: const AppTextStyle()
                                        .balooBhaijaan2
                                        .w600
                                        .white
                                        .bodySmall12,
                                  )
                                ],
                              ),
                            ),
                            SvgPicture.asset(AppIconsAssets.skenz),
                          ],
                        ),
                      ),
                      AppSize.s50.sizedBoxHeight,
                      TextFormFieldWidget(controller: _controller,
                          keyboardType: TextInputType.name,
                          inputAction: TextInputAction.done,
                          isReadOnly: true,
                          onFieldSubmitted: (value) {
                          }),
                      AppSize.s30.sizedBoxHeight,
                      DefaultButtonWidget(label: "نسخ الكود", onPressed: () {
                        Clipboard.setData(ClipboardData(text: _controller.text));
                        showSnackBar(
                          description: "تم نسخ الكود",
                          state: ToastStates.congrats,
                          context: context,
                        );
                      }),
                      AppSize.s10.sizedBoxHeight,
                      DefaultButtonWidget(label: "ارسال", onPressed: () {
                        Share.share(getIt<UserLocalDataSource>().getUserData()!.username);
                      }),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ).paddingBody(),
      ),
    );
  }
}
