import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/add_parent_or_child_button.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_local_data_source/base_local_data_source.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../config/extensions/color_extension.dart';
import '../../../../config/resources/app_assets.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../config/resources/app_values.dart';
import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../config/storages/keys.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../my_app/app_reference.dart';
import '../../un_link/un_link.dart';
import '../presentation/more_widgets/header_for_more.dart';
import 'data/parent_preview_for_child_models/parent_preview_for_child_model.dart';
import 'domain/parent_preview_for_child_entities/parent_preview_for_child_entity.dart';

part 'data/parent_preview_for_child_data_source/parent_preview_for_child_local_data_source.dart';

part 'data/parent_preview_for_child_data_source/parent_preview_for_child_remote_data_source.dart';

part 'data/parent_preview_for_child_repository/parent_preview_for_child_repository.dart';

part 'domain/parent_preview_for_child_base_repository/parent_preview_for_child_base_repository.dart';

part 'domain/parent_preview_for_child_usecases/parent_preview_for_child_usecase.dart';

part 'presentation/parent_preview_for_child_screen/parent_preview_for_child_screen.dart';

part 'presentation/parent_preview_for_child_view_model/parent_preview_for_child_bloc.dart';

part 'presentation/parent_preview_for_child_view_model/parent_preview_for_child_event.dart';

part 'presentation/parent_preview_for_child_view_model/parent_preview_for_child_state.dart';

part 'presentation/parent_preview_for_child_widgets/parent_preview_for_child_widgets.dart';
