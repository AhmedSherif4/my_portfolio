import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import '../../my_app/app_reference.dart';
import '../services/services_locator.dart';
import '../shared_models/user/data/user_local_data_source/user_local_data_source.dart';

class SelectGender extends StatefulWidget {
  final Function(GenderType genderType) onGenderSelected;

  const SelectGender({
    super.key,
    required this.onGenderSelected,
  });

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  GenderType genderType = GenderType.male;

  @override
  void initState() {
    super.initState();
    if(getIt<UserLocalDataSource>().getUserData() != null){
    if (getIt<UserLocalDataSource>().getUserData()!.gender == 'male') {
      genderType = GenderType.male;
    } else if (getIt<UserLocalDataSource>().getUserData()!.gender == 'female') {
      genderType = GenderType.female;
    } else {
      genderType = GenderType.other;
    }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          AppStrings.gender,
          style: AppReference.themeData.textTheme.bodyMedium,
        ),
        Row(
          children: [
            Text(
              AppStrings.male,
              style: AppReference.themeData.textTheme.bodyMedium,
            ),
            Radio(
              value: GenderType.male,
              groupValue: genderType,
              onChanged: (value) {
                setState(() {
                  genderType = value as GenderType;
                  widget.onGenderSelected(GenderType.male);
                });
              },
              activeColor: AppColors.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              fillColor:
                  WidgetStateProperty.all<Color>(AppColors.primaryColor),
              overlayColor:
                  WidgetStateProperty.all<Color>(AppColors.primary2),
              visualDensity: VisualDensity.comfortable,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              AppStrings.female,
              style: AppReference.themeData.textTheme.bodyMedium,
            ),
            Radio(
              value: GenderType.female,
              groupValue: genderType,
              onChanged: (value) {
                setState(() {
                  genderType = value as GenderType;
                  widget.onGenderSelected(GenderType.female);
                });
              },
              activeColor: AppColors.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              fillColor:
                  WidgetStateProperty.all<Color>(AppColors.primaryColor),
              overlayColor:
                  WidgetStateProperty.all<Color>(AppColors.primary2),
              visualDensity: VisualDensity.comfortable,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              AppStrings.otherGendar,
              style: AppReference.themeData.textTheme.bodyMedium,
            ),
            Radio(
              value: GenderType.other,
              groupValue: genderType,
              onChanged: (value) {
                setState(() {
                  genderType = value as GenderType;
                  widget.onGenderSelected(GenderType.other);
                });
              },
              activeColor: AppColors.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              fillColor:
                  WidgetStateProperty.all<Color>(AppColors.primaryColor),
              overlayColor:
                  WidgetStateProperty.all<Color>(AppColors.primary2),
              visualDensity: VisualDensity.comfortable,
            ),
          ],
        ),
      ],
    );
  }
}
