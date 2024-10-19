import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

import '../../config/resources/app_assets.dart';
import '../../config/resources/app_strings.dart';
import '../../my_app/app_reference.dart';
import 'type_user_selection_button.dart';

// class SelectTypeOfUser extends StatefulWidget {
//   final Function(UsersType) onChanged;
//
//   const SelectTypeOfUser({
//     super.key,
//     required this.onChanged,
//   });
//
//   @override
//   State<SelectTypeOfUser> createState() => _SelectTypeOfUserState();
// }
//
// class _SelectTypeOfUserState extends State<SelectTypeOfUser> {
//   UsersType userType = UsersType.child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TypeUserSelectionButton(
//           iconImagePath: AppIconsAssets.sParent,
//           label: AppStrings.parent,
//           onTap: () {
//             setState(() {
//               userType = UsersType.parent;
//               widget.onChanged(UsersType.parent);
//             });
//           },
//           selectedType: userType,
//           typeUser: UsersType.parent,
//         ),
//         AppSize.s10.sizedBoxWidth,
//         TypeUserSelectionButton(
//           iconImagePath: AppIconsAssets.sChild,
//           label: AppStrings.child,
//           onTap: () {
//             setState(() {
//               userType = UsersType.child;
//               widget.onChanged(UsersType.child);
//             });
//           },
//           selectedType: userType,
//           typeUser: UsersType.child,
//         ),
//         AppSize.s10.sizedBoxWidth,
//         TypeUserSelectionButton(
//           iconImagePath: AppImagesAssets.sCompanyNew,
//           label: AppStrings.institution,
//           onTap: () {
//             setState(() {
//               userType = UsersType.institution;
//               widget.onChanged(UsersType.institution);
//             });
//           },
//           selectedType: userType,
//           typeUser: UsersType.institution,
//         ),
//       ],
//     );
//   }
// }


class CustomDropdown extends StatefulWidget {
  final Function(UsersType) onChanged;

  const CustomDropdown({super.key, required this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  UsersType userType = UsersType.child;

  String selectedValue(UsersType type) {
    switch (type) {
      case UsersType.child:
        return AppStrings.child;
      case UsersType.parent:
        return AppStrings.parent;
      case UsersType.institution:
        return AppStrings.institution;
      default:
        return AppStrings.child;
    }
  }

  // List of items to show in the dropdown
  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(
        value: AppStrings.child,
        child: Row(
          children: [
            SvgPicture.asset(
              AppIconsAssets.sChild,
              fit: BoxFit.contain,
            ),
            AppSize.s8.sizedBoxWidth, // Spacing between text and icon
            Text(AppStrings.child,style: const AppTextStyle().blue.w700.bodyMedium14,),
          ],
        ),
        onTap: () {
          setState(() {
            userType = UsersType.child;
            widget.onChanged(UsersType.child);
          });
        },
      ),
      DropdownMenuItem(
        value: AppStrings.parent,
        child: Row(
          children: [
          SvgPicture.asset(
         AppIconsAssets.sParent,
          fit: BoxFit.contain,
        ),
          AppSize.s8.sizedBoxWidth,
            Text(AppStrings.parent,style: const AppTextStyle().blue.w700.bodyMedium14,),
          ],
        ),
        onTap: () {
          setState(() {
            userType = UsersType.parent;
            widget.onChanged(UsersType.parent);
          });
        },
      ),
      DropdownMenuItem(
        value: AppStrings.institution,
        child: Row(
          children: [
            SvgPicture.asset(
              AppImagesAssets.sCompanyNew,
              fit: BoxFit.scaleDown,
            ),
            AppSize.s8.sizedBoxWidth,
            Text(AppStrings.institution,style: const AppTextStyle().blue.w700.bodyMedium14,),
          ],
        ),
        onTap: () {
          setState(() {
            userType = UsersType.institution;
            widget.onChanged(UsersType.institution);
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppPadding.p16.responsiveSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the right (Arabic)
        children: [
           Text(
            'ما هو صفتك ؟', // Question in Arabic
            style: AppTextStyle().w500.bodyMedium14,
          ),
          const SizedBox(height: 10), // Spacing between the label and dropdown
          DropdownButtonFormField(
            value: selectedValue(userType),
            items: dropdownItems,
            onChanged: (value) {
              setState(() {
                selectedValue(userType);
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dropdownColor: Colors.grey[200], // Dropdown menu background color
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor), // Custom icon
          ),
        ],
      ),
    );
  }
}