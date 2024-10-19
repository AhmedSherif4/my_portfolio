part of 'video.dart';

class _LoadingVideoWidget extends StatelessWidget {
  const _LoadingVideoWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppReference.deviceWidth(context),
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.responsiveWidth,
            height: 10.responsiveHeightRatio,
            child: const CircularProgressIndicator(color: AppColors.secondaryColor),
          ),
          10.sizedBoxHeight,
          const Text('Loading'),
        ],
      ),
    );
  }
}
