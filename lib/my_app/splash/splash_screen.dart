library splash_screen;

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import 'package:my_portfolio/my_app/splash/presentation/components/exit_dialog.dart';

import '../../../../../config/internet_connection/internet_connection_setup.dart';
import '../../../../../config/resources/app_assets.dart';
import '../../../../../config/resources/app_colors.dart';
import '../../../../../config/resources/app_constants.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';

part 'presentation/components/debugging_dialog.dart';
part 'presentation/components/developer_mode_dialog.dart';
part 'presentation/components/physical_debugging_dialog.dart';
part 'presentation/components/repair_dialog.dart';
part 'presentation/components/update_dialog.dart';
part 'presentation/splash_view_model/splash_bloc.dart';
part 'presentation/splash_view_model/splash_event.dart';
part 'presentation/splash_view_model/splash_state.dart';
part 'presentation/view/splash_functions.dart';
part 'presentation/view/splash_view.dart';
