import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../config/resources/app_strings.dart';
import '../../../../../../config/resources/app_values.dart';
import '../../../../../../config/routes/route_manager.dart';
import '../../../../../../config/routes/routes_names.dart';
import '../../../../../../core/shared_widget/text_button_widget.dart';
import '../../sign_up.dart';

class TermsAndConditionView extends StatefulWidget {
  final Function(bool) isAgree;

  const TermsAndConditionView({super.key, required this.isAgree});

  @override
  State<TermsAndConditionView> createState() => _TermsAndConditionViewState();
}

class _TermsAndConditionViewState extends State<TermsAndConditionView> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StatefulBuilder(builder: (context, builderSetState) {
              return CircleCheckBoxWidget(
                isSelected: isAgree,
                onChange: (bool? value) {
                  builderSetState(() {
                    widget.isAgree(value!);
                    isAgree = value;
                  });
                },
              );
            }),
            AppSize.s6.sizedBoxHeight,
            Expanded(
              child: Text(
                AppStrings.agree,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: AppTextStyle.bodySmall12,
              ),
            ),
          ],
        ),
        AppSize.s6.sizedBoxHeight,
        Center(
          child: TextButtonWidget(
            withDecoration: true,
            text: AppStrings.showTerms,
            weight: AppFontWeight.boldW700,
            fontSize: AppReference.deviceIsTablet ? AppFontSize.sp8.responsiveFontSize:AppFontSize.sp12.responsiveFontSize,
            onPressed: () {
              RouteManager.rPushNamed(
                  context: context,
                  rName: AppRoutesNames.rTermsAndConditionsScreen);
            },
          ),
        ),
      ],
    );
  }
}
