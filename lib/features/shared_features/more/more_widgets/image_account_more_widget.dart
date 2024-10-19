part of 'more_widgets.dart';


class ImageAccountMoreWidget extends StatelessWidget {
  final bool withCamera;
  final File? imageFile;

  const ImageAccountMoreWidget({
    super.key,
    this.withCamera = false, this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocalEmpty =
        getIt<UserLocalDataSource>().getUserData()!.imgPath == null ||
            getIt<UserLocalDataSource>().getUserData()!.imgPath!.isEmpty;
        final bool isPickedEmpty = imageFile!.path == "";

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Container(
          padding: EdgeInsets.zero,
          alignment: AlignmentDirectional.center,
          height: AppReference.deviceIsTablet ? AppReference.deviceHeight(context) *
              0.1.responsiveHeightRatio:AppReference.deviceHeight(context) *
              0.12.responsiveHeightRatio,
          width: AppReference.deviceIsTablet?AppReference.deviceWidth(context) * 0.15:AppReference.deviceWidth(context) * 0.25,
          decoration: ShapeDecoration(
            color: AppColors.white,
            shape: OvalBorder(
              side: BorderSide(
                width: 0.50.responsiveSize,
                color: AppColors.primaryColor,
              ),
            ),
            image: !isPickedEmpty
                ? DecorationImage(
              image: FileImage(imageFile!),
            )
                : null,
          ),
          child: !isPickedEmpty
              ? null
              :ClipOval(
            child: NullableNetworkImage(
              imagePath:
              getIt<UserLocalDataSource>().getUserData()!.imgPath,
              notHaveImage: isLocalEmpty,
              height: AppReference.deviceHeight(context) * 0.11.responsiveHeightRatio,
              width:  AppReference.deviceWidth(context) * 0.24,
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (withCamera)
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: AppReference.deviceIsTablet?10.responsiveSize:3.0.responsiveSize,
              end: AppReference.deviceIsTablet?10.responsiveSize:3.0.responsiveSize,
            ),
            child:  Icon(
              Icons.camera_alt_rounded,
              color: AppColors.primaryColor,
              size: 16.responsiveSize,
            ),
          ),
      ],
    );
  }
}
