import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_widget/custom_inkwell.dart';
import '../../../../../core/shared_widget/dialogs/permissions_dialog.dart';
import '../../../../../my_app/app_permission.dart';
import '../../../../../my_app/app_reference.dart';
import '../image_pick_view_model/image_pick_bloc.dart';
import '../image_pick_view_model/image_pick_event.dart';
import '../image_pick_view_model/image_pick_state.dart';

class PickImageInkWell extends StatelessWidget {

  const PickImageInkWell({super.key,
    required this.pickImageWidget,
    required this.loadingPickImageWidget,
    required this.loadedPickImageWidget,
    required this.errorPickImageWidget,
    required this.permissionDialogMessage,
    required this.pickImageShape,
    required this.onErrorMessage,
     this.imageSourceType,
    required this.onPickFile,});
  
final Widget pickImageWidget;
final Widget loadingPickImageWidget;
final Widget loadedPickImageWidget;
final Widget errorPickImageWidget;
final String permissionDialogMessage;
final PickImageShape pickImageShape;
  final Function(File) onPickFile;
  final Function(String) onErrorMessage;
final ImageSourceType? imageSourceType;

  _pickImageHandler(context) async {
    if (await AppPermissions.photosPermissionStatus()) {
      _pickImageEvent(context);
    } else if (await AppPermissions.photosPermission.isLimited) {
      _pickImageEvent(context);
    } else if (await AppPermissions.photosPermission.isDenied) {
      if (context.mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: permissionDialogMessage,
          buttonText1: AppStrings.alright,
          buttonOnPressed1: () async {
            await AppPermissions.photosPermissionRequest();
            if (context.mounted) Navigator.pop(context);
            if (await AppPermissions.photosPermission.isGranted) {
              if (context.mounted) {
                _pickImageEvent(context);
              }
            }
          },
          buttonText2: AppStrings.notNow,
          buttonOnPressed2: () => Navigator.pop(context),
        );
      }
    } else if (await AppPermissions.photosPermission.isPermanentlyDenied) {
      if (context.mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: permissionDialogMessage,
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

  _pickImageEvent(context) {
    BlocProvider.of<ImagePickBloc>(context).add(const ImagePickerEvent(ImageSource.gallery));
  }

  _cameraHandler(context) async {
    if (await AppPermissions.cameraPermissionStatus()) {
      _cameraEvent(context);
    } else if (await AppPermissions.cameraPermission.isLimited) {
      _cameraEvent(context);
    } else if (await AppPermissions.cameraPermission.isDenied) {
      if (context.mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: AppStrings.cameraPermissionMessage,
          buttonText1: AppStrings.alright,
          buttonOnPressed1: () async {
            await AppPermissions.cameraPermissionRequest();
            if (context.mounted) Navigator.pop(context);
            if (await AppPermissions.cameraPermission.isGranted) {
              if (context.mounted) {
                _cameraEvent(context);
              }
            }
          },
          buttonText2: AppStrings.notNow,
          buttonOnPressed2: () => Navigator.pop(context),
        );
      }
    } else if (await AppPermissions.cameraPermission.isPermanentlyDenied) {
      if (context.mounted) {
        showPermissionsDialog(
          context: context,
          title: AppStrings.permission,
          message: permissionDialogMessage,
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

  _cameraEvent(context) {
    BlocProvider.of<ImagePickBloc>(context).add(const ImagePickerEvent(ImageSource.camera));
  }


  @override
  Widget build(BuildContext context) {
    File fileFile=File("path");
    String errorMessage = "";
    return BlocProvider(
  create: (_) => getIt<ImagePickBloc>(),
  child: Builder(
      builder: (buildCtx) {
        return Center(
            child: CustomInkWell(
              onTap: () async {
                switch(pickImageShape){
                  case PickImageShape.bottomSheet:
                      showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ImagePickerSheet(
                          onPickType: (sourceType) async {
                            if(sourceType == ImageSourceType.gallery){
                              if (await AppReference.isAndroid13AndNewer() || AppReference.deviceIsIos) {
                                if (buildCtx.mounted) {
                                  _pickImageHandler(buildCtx);
                                }
                              } else {
                                if (buildCtx.mounted) {
                                  _pickImageEvent(buildCtx);
                                }
                              }
                            }else{
                              if (buildCtx.mounted) {
                                _cameraHandler(buildCtx);
                              }
                            }
                          } ,
                        );
                      },
                    );
                  case PickImageShape.item:
                    if(imageSourceType == ImageSourceType.gallery){
                      if (await AppReference.isAndroid13AndNewer() || AppReference.deviceIsIos) {
                        if (buildCtx.mounted) {
                          _pickImageHandler(buildCtx);
                        }
                      } else {
                        if (buildCtx.mounted) {
                          _pickImageEvent(buildCtx);
                        }
                      }
                    }else{
                      if (buildCtx.mounted) {
                        _cameraHandler(buildCtx);
                      }
                    }
                  case PickImageShape.dialog:
                    showDialog(context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content:
                            ImagePickerSheet(
                              onPickType: (sourceType) async {
                                if(sourceType == ImageSourceType.gallery){
                                  if (await AppReference.isAndroid13AndNewer() || AppReference.deviceIsIos) {
                                    if (buildCtx.mounted) {
                                      _pickImageHandler(buildCtx);
                                    }
                                  } else {
                                    if (buildCtx.mounted) {
                                      _pickImageEvent(buildCtx);
                                    }
                                  }
                                }else{
                                  if (buildCtx.mounted) {
                                    _cameraHandler(buildCtx);
                                  }
                                }
                              } ,
                            ),
                        );
                      },);
                }

              },
              child: BlocBuilder<ImagePickBloc, ImagePickState>(
                builder: (context, state) {
                switch (state.pickImageState) {
                  case PickImageState.init:
                    return pickImageWidget;
                  case PickImageState.startLoadingImage:
                  return loadingPickImageWidget;
                case PickImageState.imagePickedSuccessfully:
                  fileFile=context.read<ImagePickBloc>().imageFile!;
                  onPickFile(fileFile);
                  return loadedPickImageWidget;
                case PickImageState.imagePickedError:
                  errorMessage = state.pickImageErrorMessage;
                  onErrorMessage(errorMessage);
                  return errorPickImageWidget;
                default:
                  return pickImageWidget;
                }
                }
              ),
            ),
          );
      }
    ),
);
  }
}

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({
    super.key,
   required this.onPickType
  });

  final Function(ImageSourceType) onPickType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomInkWell(
          onTap: (){
            Navigator.pop(context);
            onPickType(ImageSourceType.gallery);
          },
          child: Row(
            children: [
              const Icon(Icons.photo_library),
              AppSize.s10.sizedBoxWidth,
              const Text(AppStrings.gallery),
            ],
          ),
        ).paddingBody(),
        CustomInkWell(
          onTap: (){
            Navigator.pop(context);
            onPickType(ImageSourceType.camera);
          },
           child: Row(
              children: [
                const Icon(Icons.camera),
                AppSize.s10.sizedBoxWidth,
                const Text(AppStrings.camera),
              ],
                   )
         ).paddingBody(),
      ],
    );
  }
}
