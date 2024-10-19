import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/cached_network_image.dart';
import 'package:my_portfolio/features/child_flow/questions/questions/presentation/questions_widgets/audio_widget/audio_widget.dart';
import 'package:my_portfolio/features/child_flow/questions/questions/presentation/questions_widgets/video_widget/video.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../config/storages/keys.dart';

showHintOfQuestionsDialog({
  required BuildContext context,
  required String? descriptionText,
  String? descriptionType,
  String? descriptionFile,
}) {
  showDialog(
    context: context,
    builder: (context) => HintOfQuestionsDialog(
      descriptionText: descriptionText,
      descriptionType: descriptionType,
      descriptionFile: descriptionFile,
    ),
  );
}

class HintOfQuestionsDialog extends StatelessWidget {
  final String? descriptionType;
  final String? descriptionFile;
  final String? descriptionText;

  const HintOfQuestionsDialog({
    super.key,
    this.descriptionText,
    this.descriptionType,
    this.descriptionFile,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape:  RoundedRectangleBorder(
        borderRadius:BorderRadius.all(Radius.circular(
            AppPadding.p20.responsiveSize),
    ),),
      content: Container(
        width: AppReference.deviceWidth(context) * 0.8,
        padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
        decoration: BoxDecoration(
          color: AppColors.primary2,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 3.responsiveSize,
          ),
          borderRadius:
              BorderRadius.all(Radius.circular(AppPadding.p20.responsiveSize)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: AppReference.deviceHeight(context) *
                    0.08.responsiveHeightRatio,
                child: Column(
                  children: [
                    Text(
                      AppStrings.hintOfQuestion,
                      style: const AppTextStyle().quranFont.bodyLarge16,
                    ),
                    Divider(
                      color: AppColors.primary2,
                      thickness: 5.responsiveSize,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ],
                ),
              ),
              if(descriptionText!=null)...[
                Text(
                  '$descriptionText',
                  style: const AppTextStyle().quranFont.bodyLarge16,
                  textAlign: TextAlign.justify,
                ),
                AppSize.s10.sizedBoxHeight,
              ],

              HintBuilderWithType(
                descriptionFile: descriptionFile,
                descriptionType: descriptionType,
              ),
              AppSize.s10.sizedBoxHeight,

              DefaultButtonWidget(
                label: "فهمت",
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonColor: AppColors.primaryColor2,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class HintBuilderWithType extends StatelessWidget {
  final String? descriptionFile;
  final String? descriptionType;

  const HintBuilderWithType(
      {super.key,
      required this.descriptionFile,
      required this.descriptionType});

  @override
  Widget build(BuildContext context) {
    if (descriptionFile == null ||
        descriptionFile!.isEmpty ||
        descriptionFile == '') {
      return const SizedBox.shrink();
    } else {
      return switch (descriptionType) {
        AppKeys.audioKey => SizedBox(
            height: 45.responsiveHeight,
            width: AppReference.deviceWidth(context) * 0.64,
            child: AudioPlayerWidget(
              source: '${EndPoints.baseUrl}${descriptionFile!}',
              isAnswerAudio: false,
            ),
          ),
        AppKeys.imageKey => BaseCachedNetworkImage(
            height: AppReference.deviceHeight(context) * 0.25.responsiveHeightRatio,
            width: AppReference.deviceWidth(context) * 0.64,
            imgUrl: '${EndPoints.baseUrl}${descriptionFile!}',
            fit: BoxFit.contain,
          ),
        AppKeys.videoKey => SizedBox(
          height: AppReference.deviceHeight(context) * 0.25.responsiveHeightRatio,
            width: AppReference.deviceWidth(context) * 0.64,
            child: VideoWidget(
              source:'${EndPoints.baseUrl}${descriptionFile!}',
              reachedTheEnd: () {},
              isAnswerVideo: true,
            ),
          ),
        _ => const SizedBox.shrink(),
      };
    }
  }
}


