import 'package:flutter/cupertino.dart';

import '../../../../config/resources/app_strings.dart';
import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../core/shared_widget/button_widget.dart';

class ToCartButton extends StatelessWidget {
  final int childID;
  const ToCartButton({super.key, required this.childID});

  @override
  Widget build(BuildContext context) {
    return DefaultButtonWidget(
      label: AppStrings.toCart,
      onPressed: () =>
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rCartScreen,
            arguments: childID,
          ),
    );
  }
}
