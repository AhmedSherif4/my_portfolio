import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/features/auth/shared_screens/base%20screens/base_invetion_successfully_person.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../config/resources/app_text_style.dart';
import '../../../../core/services/services_locator.dart';
import '../../../shared_features/contact_us/presentations/view_model/contact_us_bloc.dart';

class ParentInviteSentSuccessfully extends StatefulWidget {
  final String discountMessage;

  const ParentInviteSentSuccessfully({
    super.key,
    required this.discountMessage,
  });

  @override
  State<ParentInviteSentSuccessfully> createState() =>
      _ParentInviteSentSuccessfullyState();
}

class _ParentInviteSentSuccessfullyState
    extends State<ParentInviteSentSuccessfully> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactUsBloc>()..add(GetContactUsEvent()),
      child: BlocListener<ContactUsBloc, ContactUsState>(
        listener: (context, state) {
          if (state.getContactUsStates == RequestStates.loaded) {
            if (state.getContactUsData?.messageForParentAfterAddFirstChild !=
                null) {
              showDialog(
                context: context,
                builder: (context) {
                  return widget.discountMessage.isEmpty
                      ? ParentDiscountAfterAddChild(
                          messageForParentAfterAddFirstChild: state
                              .getContactUsData!
                              .messageForParentAfterAddFirstChild,
                          messageForParentAfterAddSecondChild: state
                              .getContactUsData!
                              .messageForParentAfterAddSecondChild)
                      : ParentDiscountAfterAddChild(
                          messageForParentAfterAddFirstChild:
                              widget.discountMessage.toString(),
                        );
                },
              );
            }
          }
        },
        child: BaseSendInvetionSuccessfully(
          isParentPath: true,
          title: AppStrings.sentMessageForTheChild,
          image: AppImagesAssets.sEmail,
          imageWidth: AppReference.deviceWidth(context) * 0.7,
          imageHeight:AppReference.deviceHeight(context) * 0.35.responsiveHeightRatio,
          description: [
            TextSpan(
              text: AppStrings.theChildWillBeAddedAutomaticallyAfterAccept,
              style: AppReference.deviceIsTablet?const AppTextStyle().s14.bodyLarge16:AppReference.themeData.textTheme.bodyLarge,

            ),
          ],
        ),
      ),
    );
  }
}

class ParentDiscountAfterAddChild extends StatelessWidget {
  final String messageForParentAfterAddFirstChild;
  final String? messageForParentAfterAddSecondChild;

  const ParentDiscountAfterAddChild(
      {super.key,
      required this.messageForParentAfterAddFirstChild,
      this.messageForParentAfterAddSecondChild});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppReference.deviceWidth(context) * 0.8,
      height: messageForParentAfterAddSecondChild != null
          ? AppReference.deviceHeight(context) * 0.6.responsiveHeightRatio
          : AppReference.deviceHeight(context) * 0.3.responsiveHeightRatio,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 5,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        content: Container(
          padding: EdgeInsets.all(20.responsiveSize),
          width: AppReference.deviceWidth(context) * 0.8,
          height:
              AppReference.deviceHeight(context) * 0.5.responsiveHeightRatio,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.responsiveSize),
            color: Colors.white,
          ),
          child: LayoutBuilder(builder: (context, constrains) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  AppImagesAssets.sDiscount,
                  height: constrains.maxHeight * 0.34,
                ),
                (constrains.maxHeight * 0.03).sizedBoxHeight,
                SizedBox(
                  height: messageForParentAfterAddSecondChild != null  ? constrains.maxHeight * 0.2 : constrains.maxHeight * 0.4,
                  child: Text(
                    messageForParentAfterAddFirstChild,
                    maxLines: messageForParentAfterAddSecondChild != null ? 3 : null,
                    overflow: messageForParentAfterAddSecondChild != null ? TextOverflow.ellipsis : null ,
                    style: const AppTextStyle().w500.titleSmall18,
                  ),
                ),
                (constrains.maxHeight * 0.03).sizedBoxHeight,
                if (messageForParentAfterAddSecondChild != null)
                  SizedBox(
                    height: constrains.maxHeight * 0.2,
                    child: Text(
                      messageForParentAfterAddSecondChild!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const AppTextStyle().w500.titleSmall18,
                    ),
                  ),
                (constrains.maxHeight * 0.03).sizedBoxHeight,
                DefaultButtonWidget(
                    label:AppStrings.ok,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            );
          }),
        ),
      ),
    );
  }
}
