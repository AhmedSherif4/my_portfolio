library on_boarding;

import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_local_data_source/base_local_data_source.dart';
import '../../../../config/storages/keys.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../config/resources/app_colors.dart';
import '../../../config/resources/app_values.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import '../../../config/resources/app_assets.dart';
import '../../../core/shared_widget/button_widget.dart';
import '../../../core/shared_widget/text_button_widget.dart';


part 'local/on_boarding_local_data.dart';
part 'onboarding_screens.dart';
part 'count_item_widget.dart';
part 'screens_data.dart';
part 'widgets/image_view.dart';
part 'widgets/onboarding_data_title_describe_view.dart';
part 'widgets/onboarding_header.dart';
part 'portrait_view/view/portrait_view.dart';
part 'portrait_view/view/landscape_view.dart';