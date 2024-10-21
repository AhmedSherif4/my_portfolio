import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../config/resources/app_text_style.dart';
import '../../../my_app/app_settings/app_settings_cubit.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.1,
      color: AppColors.primaryColor2(context),
      child: Row(
        children: [
          BlocBuilder<AppSettingsCubit, AppSettingsState>(
              builder: (context, state) {
            final AppSettingsCubit cubit =
                BlocProvider.of<AppSettingsCubit>(context);
            return Wrap(
              children: [
                IconButton(
                    onPressed: () {
                      cubit.changeLocaleEvent();
                      Phoenix.rebirth(context);
                    },
                    icon: const Icon(Icons.translate_rounded)),
                Switch(
                  value: cubit.getThemeMode(),
                  onChanged: (isDark) {
                    cubit.setThemeMode(isDark);
                  },
                ),
                Text(
                  AppStrings.downloadedSuccessfully.tr(),
                  style: const AppTextStyle().bodyMedium20w4,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
