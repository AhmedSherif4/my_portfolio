import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../../../../config/resources/app_values.dart';
import '../../../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../../../core/shared_widget/image_pick/pick_image_inkwell/pick_image_ink_well.dart';
import '../../../../../more/more_widgets/more_widgets.dart';
import '../../../../../more/presentation/more_widgets/header_for_more.dart';
import '../../../edit_profile.dart';



class ChildAccountDetailsScreen extends StatefulWidget {
  const ChildAccountDetailsScreen({super.key});

  @override
  State<ChildAccountDetailsScreen> createState() =>
      _ChildAccountDetailsScreenState();
}

class _ChildAccountDetailsScreenState extends State<ChildAccountDetailsScreen> {
  late UserEntity userData;
  File imageFile = File("");
  @override
  void didChangeDependencies() {
    setState(() {
      userData = getIt<UserLocalDataSource>().getUserData()!;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      if (userData.type != UsersType.institution.name)
        {
        'title': AppStrings.gender,
        'subtitle': userData.gender,
        'withEdit': true,
        'routeTo': AppRoutesNames.rEditProfileScreen,
      },
      {
        'title': AppStrings.name,
        'subtitle': userData.name,
        'withEdit': true,
        'routeTo': AppRoutesNames.rEditProfileScreen,
      },
      {
        'title': AppStrings.userName,
        'subtitle': userData.username,
        'withEdit': false,
        'routeTo': null,
      },
      {
        'title': AppStrings.email,
        'subtitle': userData.email ?? '',
        'withEdit': true,
        'routeTo': AppRoutesNames.rEditProfileScreen,
      },
      {
        'title': AppStrings.phone,
        'subtitle': userData.phone ?? '',
        'withEdit': true,
        'routeTo': AppRoutesNames.rEditProfileScreen,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderForMore(
                title: AppStrings.accountDetails,
              ),
              PickImageInkWell(
                  pickImageWidget:  ImageAccountMoreWidget(
                    withCamera: true,
                    imageFile: imageFile,
                  ),
                  loadingPickImageWidget: ImageAccountMoreWidget(
                    withCamera: true,
                    imageFile: imageFile,
                  ),
                  loadedPickImageWidget: StatefulBuilder(
                      builder: (context, updateState) {
                        return ImageAccountMoreWidget(
                          withCamera: true,
                          imageFile: imageFile,
                        );
                      }
                  ),
                  errorPickImageWidget:  ImageAccountMoreWidget(
                    withCamera: true,
                    imageFile: imageFile,
                  ),
                  pickImageShape: PickImageShape.bottomSheet,
                  permissionDialogMessage: AppStrings.permissionPhotoMessage,
                  onErrorMessage:(value){} ,
                  onPickFile:(value){
                    imageFile = value;
                    getIt<EditProfileBloc>().add(EditProfile(
                      image: imageFile.path,
                      withImage: true,));
                  } ),
              AppSize.s12.sizedBoxHeight,
              if((AppReference.deviceIsTablet && !AppReference.isPortrait(context)))
                Container(
                  padding: EdgeInsets.all(20.responsiveSize),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
                  ),
                  child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8/.8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 30,),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...data.map((e) => ListTileUpdateUserDataWidget(
                        title: e['title'],
                        subtitle: e['subtitle'],
                        withEdit: e['withEdit'],
                        routeTo: e['routeTo'] as String?,
                      ),),
                      (userData.socialId?.isEmpty ?? true)
                          ? const ChangePasswordUpdateUserDataWidget(
                        title: AppStrings.changePassword,
                        icon: AppIconsAssets.sPasswordChange,
                        routeTo: AppRoutesNames.rChangePasswordScreen,
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              if(!AppReference.deviceIsTablet||(AppReference.deviceIsTablet && AppReference.isPortrait(context))
              )...[
                ListView.separated(
                  itemBuilder: (context, index) => ListTileUpdateUserDataWidget(
                    withAdd:data[index]['subtitle'] == "",
                    withCopy:data[index]['title'] == AppStrings.userName,

                    title: data[index]['title'],
                    subtitle: data[index]['subtitle'],
                    withEdit: data[index]['withEdit'],
                    routeTo: data[index]['routeTo'] as String?,
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.textColor6,
                    endIndent: 20.responsiveWidth,
                    height: 30.responsiveWidth,
                    indent: 50.responsiveWidth,
                  ),
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                50.sizedBoxHeight,
                (userData.socialId?.isEmpty ?? true)
                    ? const ChangePasswordUpdateUserDataWidget(
                  title: AppStrings.changePassword,
                  icon: AppIconsAssets.sPasswordChange,
                  routeTo: AppRoutesNames.rChangePasswordScreen,
                )
                    : const SizedBox.shrink(),]
            ],
          ),
        ),
      ).paddingBody(),
    );
  }
}
