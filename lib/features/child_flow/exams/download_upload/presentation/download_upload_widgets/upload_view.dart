part of '../../download_upload.dart';

class UploadView extends StatefulWidget {
  final String fileUrl;
  final String fileName;
  final List<String> description;
  final bool isPrimary;

  const UploadView({
    required this.fileUrl,
    required this.fileName,
    super.key,
    required this.isPrimary,
    required this.description,
  });

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  bool ignoreClick = false;
  final BackgroundDownloader backgroundDownloader = BackgroundDownloader();

  _pickPdfHandler(context) async {
    if (await AppPermissions.storagePermissionStatus()) {
      _pickPdfEvent(context);
    } else if (await AppPermissions.storagePermission.isLimited) {
      _pickPdfEvent(context);
    } else if (await AppPermissions.storagePermission.isDenied) {
      if (context.mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: AppStrings.permissionMessage,
          buttonText1: AppStrings.alright,
          buttonOnPressed1: () async {
            await AppPermissions.storagePermissionRequest();
            if (context.mounted) Navigator.pop(context);
            if (await AppPermissions.storagePermission.isGranted) {
              if (context.mounted) {
                _pickPdfEvent(context);
              }
            }
          },
          buttonText2: AppStrings.notNow,
          buttonOnPressed2: () => Navigator.pop(context),
        );
      }
    } else if (await AppPermissions.storagePermission.isPermanentlyDenied) {
      if (context.mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: AppStrings.storagePermissionMessage,
          buttonText1: AppStrings.alright,
          buttonOnPressed1: () async {
            if (await openAppSettings()) {
              await AppSettings.openAppSettings()
                  .then((value) => Navigator.pop(context));
            } else {
              if (context.mounted) {
                Navigator.pop(context);
                showSnackBar(
                  description: AppStrings.deviceNotSupported,
                  state: ToastStates.info,
                  context: context,
                );
              }
            }
          },
          buttonText2: AppStrings.notNow,
          buttonOnPressed2: () => Navigator.pop(context),
        );
      }
    }
  }

  _pickPdfEvent(context) async {
    BlocProvider.of<DownloadUploadBloc>(context).add(const PickPDFEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidgetForTablet(
      mobile: Column(
        children: [
          IgnorePointer(
            ignoring: backgroundDownloader.isDownloading,
            child: _DownloadUploadWidget(
              title: AppStrings.downloadTheAssignment,
              description: AppStrings.downloadPDF,
              icon: AppImagesAssets.sDownloadArrow,
              onTap: () async {
                if (!AppReference.userIsGuest()) {
                  if (AppReference.deviceIsAndroid) {
                    await backgroundDownloader.downloadFile(
                        url: "${EndPoints.baseUrl}${widget.fileUrl}",
                        fileName: widget.fileName);
                  } else {
                    BlocProvider.of<DownloadBloc>(context).add(
                      DownloadFileEvent(
                          fileUrl: "${EndPoints.baseUrl}${widget.fileUrl}",
                          fileName: widget.fileName),
                    );
                  }
                } else {
                  AppReference.guestDialogMustLogin(context);
                }
              },
            ),
          ),
          StreamBuilder<double>(
              stream: backgroundDownloader.streamController.asBroadcastStream(),
              initialData: 0,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasData) {
                  return (snapshot.data == 1 || snapshot.data == 0.00)
                      ? const SizedBox.shrink()
                      : CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 10.0,
                          // animation: true,
                          percent: snapshot.data! * 100 / 100,
                          center: Text(
                            snapshot.data == 1
                                ? "Done"
                                : "${(snapshot.data! * 100).toStringAsFixed(2)}%",
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          backgroundColor: AppColors.textColor6,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: AppColors.successColor,
                        );
                } else {
                  return const Text('No data');
                }
              }),

          _DownloadUploadWidget(
            title: AppStrings.uploadTheAssignment,
            description: AppStrings.uploadPDF,
            icon: AppImagesAssets.sUploadArrow,
            onTap: () async {
              if (AppReference.userIsGuest()) {
                AppReference.guestDialogMustLogin(context);
              } else {
                if (await AppReference.isAndroid13AndNewer()) {
                  if (context.mounted) {
                    _pickPdfEvent(context);
                  }
                } else {
                  if (context.mounted) {
                    _pickPdfHandler(context);
                  }
                }
              }
            },
          ),
          // if (widget.description.isNotEmpty)
          //   _DescriptionWidget(
          //     description: widget.description,
          //     isPrimary: widget.isPrimary,
          //   ),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _DownloadUploadWidget(
            title: AppStrings.downloadTheAssignment,
            description: AppStrings.downloadPDF,
            icon: AppImagesAssets.sDownloadArrow,
            onTap: () async {
              if (!AppReference.userIsGuest()) {
                backgroundDownloader.downloadFile(
                    url: "${EndPoints.baseUrl}${widget.fileUrl}",
                    fileName: widget.fileName);
              } else {
                AppReference.guestDialogMustLogin(context);
              }
            },
          ),
          StreamBuilder<double>(
              stream: backgroundDownloader.streamController.asBroadcastStream(),
              initialData: 0,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return snapshot.data == 1
                      ? const SizedBox.shrink()
                      : CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 10.0,
                          // animation: true,
                          percent: snapshot.data! * 100 / 100,
                          center: Text(
                            snapshot.data == 1
                                ? "Done"
                                : "${(snapshot.data! * 100).toStringAsFixed(2)}%",
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          backgroundColor: AppColors.textColor6,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: AppColors.successColor,
                        );
                } else {
                  return const Text('No data');
                }
              }),

          _DownloadUploadWidget(
            title: AppStrings.uploadTheAssignment,
            description: AppStrings.uploadPDF,
            icon: AppImagesAssets.sUploadArrow,
            onTap: () async {
              if (AppReference.userIsGuest()) {
                AppReference.guestDialogMustLogin(context);
              } else {
                if (await AppReference.isAndroid13AndNewer()) {
                  if (context.mounted) {
                    _pickPdfEvent(context);
                  }
                } else {
                  if (context.mounted) {
                    _pickPdfHandler(context);
                  }
                }
              }
            },
          ),
          // if (widget.description.isNotEmpty)
          //   _DescriptionWidget(
          //     description: widget.description,
          //     isPrimary: widget.isPrimary,
          //   ),
        ],
      ),
    );
  }
}

class _DownloadUploadWidget extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final VoidCallback onTap;

  const _DownloadUploadWidget({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          // vertical: AppPadding.p20.responsiveSize,
          horizontal: AppPadding.p30.responsiveSize,
        ),
        margin: EdgeInsets.symmetric(
          vertical: AppPadding.p16.responsiveSize,
        ),
        width: AppReference.deviceIsTablet
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context) * 0.8,
        height: AppReference.deviceIsTablet
            ? AppReference.deviceHeight(context) * 0.1.responsiveHeightRatio
            : AppReference.deviceHeight(context) * 0.10.responsiveHeightRatio,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary2),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: constraints.maxWidth * 0.2,
                height: constraints.maxHeight * 0.8,
                child: SvgPicture.asset(
                  icon,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.7,
                height: constraints.maxHeight * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppReference.themeData.textTheme.bodyLarge!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        description,
                        style: AppReference.themeData.textTheme.bodySmall!
                            .copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    ).animateShimmer();
  }
}
