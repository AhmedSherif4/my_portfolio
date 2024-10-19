part of '../../questions.dart';

class AnswerItemWidget extends StatelessWidget {
  final int selectedIndex;
  final Map<String, dynamic> answer;
  final void Function()? onTap;
  final bool isAdult;
  final Color? correctAnswerColorWithShowHint;

  const AnswerItemWidget({
    super.key,
    required this.selectedIndex,
    required this.answer,
    required this.onTap,
    this.isAdult = false,
    this.correctAnswerColorWithShowHint,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap!,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p4.responsiveHeight),
        child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (context, constrains) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: constrains.maxWidth * 0.88,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p14.responsiveSize,
                    vertical: (answer['file'] == null ||
                            answer['file']!.isEmpty ||
                            answer['file'] == '' ||
                            answer['type'] is! String?)
                        ? AppPadding.p6.responsiveHeight
                        : AppPadding.p14.responsiveHeight,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.appBorderRadiusR30),
                    color: correctAnswerColorWithShowHint ??
                        ((selectedIndex == answer['number'] && isAdult)
                            ? AppColors.primaryColor
                            : selectedIndex == answer['number']
                                ? AppColors.primaryColor
                                : AppColors.textColor6),
                  ),
                  child: Row(
                    children: [
                      AppSize.s6.sizedBoxWidth,
                      CircleAvatar(
                        backgroundColor: selectedIndex == answer['number']
                            ? AppColors.white
                            : AppColors.primaryColor,
                        radius: 14.responsiveSize,
                        child: Text(
                          answer['number'].toString(),
                          style:
                              const AppTextStyle().w700.bodyMedium14.copyWith(
                                    color: selectedIndex == answer['number']
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                        ),
                      ),
                      AppSize.s10.sizedBoxWidth,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              answer['text'] ?? '',
                              textAlign: TextAlign.justify,
                              textDirection: AppConstants.arabicDirection(
                                  answer['text'] ?? ""),
                              style: const AppTextStyle()
                                  .w700
                                  .bodyMedium14
                                  .copyWith(
                                    fontFamily: 'NewFont',
                                    color: selectedIndex == answer['number']
                                        ? AppColors.white
                                        : AppColors.textColor,
                                  ),
                            ),
                            AnswerItemBuilderWithType(
                              answer: answer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: constrains.maxWidth * 0.09,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                    child: CircleAvatar(
                      backgroundColor:
                          (selectedIndex == answer['number'] && isAdult)
                              ? AppColors.primaryColor
                              : selectedIndex == answer['number']
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class AnswerItemBuilderWithType extends StatelessWidget {
  final Map<String, dynamic> answer;

  const AnswerItemBuilderWithType({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    if (answer['file'] == null ||
        answer['file']!.isEmpty ||
        answer['file'] == '' ||
        answer['type'] is! String?) {
      return const SizedBox.shrink();
    } else {
      return switch (answer['type'] as String?) {
        AppKeys.audioKey => SizedBox(
            height:
                AppReference.deviceHeight(context) * .2.responsiveHeightRatio,
            width: double.infinity,
            child: AudioPlayerWidget(
              source: EndPoints.imagePath(answer['file']!),
              isAnswerAudio: true,
            ),
          ),
        AppKeys.imageKey => Stack(
            children: [
              BaseCachedNetworkImage(
                height: AppReference.deviceHeight(context) *
                    .2.responsiveHeightRatio,
                width: double.infinity,
                imgUrl: EndPoints.imagePath(answer['file']!),
                fit: BoxFit.contain,
              ),
              PositionedDirectional(
                start: 18.responsiveSize,
                top: 2.responsiveSize,
                child: MyPopImage(
                    image: answer['file']!,
                    tappedWidget: Container(
                      padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                            AppConstants.appBorderRadiusR10),
                      ),
                      child: Icon(
                        Icons.zoom_out_map_outlined,
                        color: AppColors.primaryColor,
                        size: AppSize.s20.responsiveSize,
                      ),
                    ),
                    imageWidget: BaseCachedNetworkImage(
                      height: AppReference.deviceHeight(context) *
                          .2.responsiveHeightRatio,
                      width: double.infinity,
                      imgUrl: EndPoints.imagePath(answer['file']!),
                      fit: BoxFit.contain,
                    )),
              )
            ],
          ),
        AppKeys.videoKey => SizedBox(
            height:
                AppReference.deviceHeight(context) * .2.responsiveHeightRatio,
            width: double.infinity,
            child: VideoWidget(
              source: EndPoints.imagePath(answer['file']!),
              reachedTheEnd: () {},
              isAnswerVideo: true,
            ),
          ),
        _ => const SizedBox.shrink(),
        // null => const SizedBox.shrink(),
        // String() => const SizedBox.shrink(),
      };
    }
  }
}

class AnswerItemBuilderWithTypeForNafees extends StatelessWidget {
  final NafeesQuestionAnswersEntity answer;

  const AnswerItemBuilderWithTypeForNafees({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    if (answer.img == null ||
        answer.img!.isEmpty ||
        answer.img == '' ) {
      return const SizedBox.shrink();
    } else {
      return Stack(
        children: [
          BaseCachedNetworkImage(
            height: AppReference.deviceHeight(context) *
                .2.responsiveHeightRatio,
            width: double.infinity,
            imgUrl: EndPoints.imagePath(answer.img!),
            fit: BoxFit.contain,
          ),
          PositionedDirectional(
            start: 18.responsiveSize,
            top: 2.responsiveSize,
            child: MyPopImage(
                image: answer.img!,
                tappedWidget: Container(
                  padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR10),
                  ),
                  child: Icon(
                    Icons.zoom_out_map_outlined,
                    color: AppColors.primaryColor,
                    size: AppSize.s20.responsiveSize,
                  ),
                ),
                imageWidget: BaseCachedNetworkImage(
                  height: AppReference.deviceHeight(context) *
                      .2.responsiveHeightRatio,
                  width: double.infinity,
                  imgUrl: EndPoints.imagePath(answer.img!),
                  fit: BoxFit.contain,
                )),
          )
        ],
      );
    }
  }
}

class AnswerItemBuilderWithTypeForSimulated extends StatelessWidget {
  final SimulatedQuestionAnswersEntity answer;

  const AnswerItemBuilderWithTypeForSimulated({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    if (answer.img == null ||
        answer.img!.isEmpty ||
        answer.img == '' ) {
      return const SizedBox.shrink();
    } else {
      return Stack(
        children: [
          BaseCachedNetworkImage(
            height: AppReference.deviceHeight(context) *
                .2.responsiveHeightRatio,
            width: double.infinity,
            imgUrl: EndPoints.imagePath(answer.img!),
            fit: BoxFit.contain,
          ),
          PositionedDirectional(
            start: 18.responsiveSize,
            top: 2.responsiveSize,
            child: MyPopImage(
                image: answer.img!,
                tappedWidget: Container(
                  padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR10),
                  ),
                  child: Icon(
                    Icons.zoom_out_map_outlined,
                    color: AppColors.primaryColor,
                    size: AppSize.s20.responsiveSize,
                  ),
                ),
                imageWidget: BaseCachedNetworkImage(
                  height: AppReference.deviceHeight(context) *
                      .2.responsiveHeightRatio,
                  width: double.infinity,
                  imgUrl: EndPoints.imagePath(answer.img!),
                  fit: BoxFit.contain,
                )),
          )
        ],
      );
    }
  }
}


class AnswerItemWidget2 extends StatelessWidget {
  final bool selectedIndex;
  final Map<String, dynamic> answer;
  final void Function()? onTap;
  final bool isAdult;
  final Color? correctAnswerColorWithShowHint;

  const AnswerItemWidget2({
    super.key,
    required this.selectedIndex,
    required this.answer,
    required this.onTap,
    this.isAdult = false,
    this.correctAnswerColorWithShowHint,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap!,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p4.responsiveHeight),
        child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (context, constrains) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: constrains.maxWidth * 0.88,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p4.responsiveSize,
                    vertical: (answer['file'] == null ||
                            answer['file']!.isEmpty ||
                            answer['file'] == '' ||
                            answer['type'] is! String?)
                        ? AppPadding.p6.responsiveHeight
                        : AppPadding.p14.responsiveHeight,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.appBorderRadiusR30),
                    color: correctAnswerColorWithShowHint ??
                        ((selectedIndex && isAdult)
                            ? AppColors.primaryColor
                            : selectedIndex
                                ? AppColors.primaryColor
                                : AppColors.textColor6),
                  ),
                  child: Row(
                    children: [
                      AppSize.s6.sizedBoxWidth,
                      CircleAvatar(
                        backgroundColor: selectedIndex
                            ? AppColors.white
                            : AppColors.primaryColor,
                        radius: 14.responsiveSize,
                        child: Text(
                          answer['number'].toString(),
                          style:
                              const AppTextStyle().w700.bodyMedium14.copyWith(
                                    color: selectedIndex
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                        ),
                      ),
                      AppSize.s10.sizedBoxWidth,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              answer['text'] ?? '',
                              textAlign: TextAlign.justify,
                              textDirection: AppConstants.arabicDirection(
                                  answer['text'] ?? ""),
                              style: const AppTextStyle()
                                  .w700
                                  .bodyMedium14
                                  .copyWith(
                                    fontFamily: 'NewFont',
                                    color: selectedIndex == true
                                        ? AppColors.white
                                        : AppColors.textColor,
                                  ),
                            ),
                            AnswerItemBuilderWithType(
                              answer: answer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: constrains.maxWidth * 0.09,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                    child: CircleAvatar(
                      backgroundColor: (selectedIndex && isAdult)
                          ? AppColors.primaryColor
                          : selectedIndex == true
                              ? AppColors.primaryColor
                              : Colors.transparent,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}


class AnswerItemForNafeesWidget extends StatelessWidget {
  final bool selectedIndex;
  final NafeesQuestionAnswersEntity answer;
  final void Function()? onTap;
  final bool isAdult;
  final Color? correctAnswerColorWithShowHint;

  const AnswerItemForNafeesWidget({
    super.key,
    required this.selectedIndex,
    required this.answer,
    required this.onTap,
    this.isAdult = false,
    this.correctAnswerColorWithShowHint,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap!,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p4.responsiveHeight),
        child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (context, constrains) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: constrains.maxWidth * 0.88,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p4.responsiveSize,
                    vertical: (answer.img == null ||
                        answer.img!.isEmpty ||
                        answer.img == '' )
                        ? AppPadding.p6.responsiveHeight
                        : AppPadding.p14.responsiveHeight,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(AppConstants.appBorderRadiusR30),
                    color: correctAnswerColorWithShowHint ??
                        ((selectedIndex && isAdult)
                            ? AppColors.primaryColor
                            : selectedIndex
                            ? AppColors.primaryColor
                            : AppColors.textColor6),
                  ),
                  child: Row(
                    children: [
                      AppSize.s6.sizedBoxWidth,
                      CircleAvatar(
                        backgroundColor: selectedIndex
                            ? AppColors.white
                            : AppColors.primaryColor,
                        radius: 14.responsiveSize,
                        child: Text(
                          answer.id.toString(),
                          style:
                          const AppTextStyle().w700.bodyMedium14.copyWith(
                            color: selectedIndex
                                ? AppColors.black
                                : AppColors.white,
                          ),
                        ),
                      ),
                      AppSize.s10.sizedBoxWidth,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              answer.option ?? '',
                              textAlign: TextAlign.justify,
                              textDirection: AppConstants.arabicDirection(
                                  answer.option ?? ""),
                              style: const AppTextStyle()
                                  .w700
                                  .bodyMedium14
                                  .copyWith(
                                fontFamily: 'NewFont',
                                color: selectedIndex == true
                                    ? AppColors.white
                                    : AppColors.textColor,
                              ),
                            ),
                            AnswerItemBuilderWithTypeForNafees(
                              answer: answer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: constrains.maxWidth * 0.09,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                    child: CircleAvatar(
                      backgroundColor: (selectedIndex && isAdult)
                          ? AppColors.primaryColor
                          : selectedIndex == true
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class AnswerItemForSimulatedWidget extends StatelessWidget {
  final bool selectedIndex;
  final SimulatedQuestionAnswersEntity answer;
  final void Function()? onTap;
  final bool isAdult;
  final Color? correctAnswerColorWithShowHint;

  const AnswerItemForSimulatedWidget({
    super.key,
    required this.selectedIndex,
    required this.answer,
    required this.onTap,
    this.isAdult = false,
    this.correctAnswerColorWithShowHint,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap!,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p4.responsiveHeight),
        child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (context, constrains) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: constrains.maxWidth * 0.88,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p4.responsiveSize,
                    vertical: (answer.img == null ||
                        answer.img!.isEmpty ||
                        answer.img == '' )
                        ? AppPadding.p6.responsiveHeight
                        : AppPadding.p14.responsiveHeight,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(AppConstants.appBorderRadiusR30),
                    color: correctAnswerColorWithShowHint ??
                        ((selectedIndex && isAdult)
                            ? AppColors.primaryColor
                            : selectedIndex
                            ? AppColors.primaryColor
                            : AppColors.textColor6),
                  ),
                  child: Row(
                    children: [
                      AppSize.s6.sizedBoxWidth,
                      CircleAvatar(
                        backgroundColor: selectedIndex
                            ? AppColors.white
                            : AppColors.primaryColor,
                        radius: 14.responsiveSize,
                        child: Text(
                          answer.id.toString(),
                          style:
                          const AppTextStyle().w700.bodyMedium14.copyWith(
                            color: selectedIndex
                                ? AppColors.black
                                : AppColors.white,
                          ),
                        ),
                      ),
                      AppSize.s10.sizedBoxWidth,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              answer.option ?? '',
                              textAlign: TextAlign.justify,
                              textDirection: AppConstants.arabicDirection(
                                  answer.option ?? ""),
                              style: const AppTextStyle()
                                  .w700
                                  .bodyMedium14
                                  .copyWith(
                                fontFamily: 'NewFont',
                                color: selectedIndex == true
                                    ? AppColors.white
                                    : AppColors.textColor,
                              ),
                            ),
                            AnswerItemBuilderWithTypeForSimulated(
                              answer: answer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: constrains.maxWidth * 0.09,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
                    child: CircleAvatar(
                      backgroundColor: (selectedIndex && isAdult)
                          ? AppColors.primaryColor
                          : selectedIndex == true
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
