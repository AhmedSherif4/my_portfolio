import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../profile/edit_profile/edit_profile.dart';


part 'banner_update_user_data_widget.dart';
part 'change_password_update_user_data_widget.dart';
part 'delete_user_widget.dart';
part 'image_account_more_widget.dart';
part 'list_tile_more_widget.dart';
part 'list_tile_update_user_data_widget.dart';
