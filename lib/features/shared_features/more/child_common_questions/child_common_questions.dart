import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_local_data_source/base_local_data_source.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../config/storages/keys.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../core/failure/failure.dart';
import '../presentation/more_widgets/header_for_more.dart';
import 'data/child_common_questions_models/child_common_questions_model.dart';
import 'domain/child_common_questions_entities/child_common_questions_entity.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

part 'data/child_common_questions_data_source/child_common_questions_local_data_source.dart';

part 'data/child_common_questions_data_source/child_common_questions_remote_data_source.dart';

part 'data/child_common_questions_repository/child_common_questions_repository.dart';

part 'domain/child_common_questions_base_repository/child_common_questions_base_repository.dart';

part 'domain/child_common_questions_usecases/child_common_questions_usecase.dart';

part 'presentation/child_common_questions_screen/child_common_questions_screen.dart';

part 'presentation/child_common_questions_view_model/child_common_questions_bloc.dart';

part 'presentation/child_common_questions_view_model/child_common_questions_event.dart';

part 'presentation/child_common_questions_view_model/child_common_questions_state.dart';

part 'presentation/child_common_questions_widgets/child_common_questions_widgets.dart';
