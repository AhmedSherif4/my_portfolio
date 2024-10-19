import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_constants.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/base_widgets/loading_shimmer_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/empty_list_widget.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/header_for_terms_levels_collections.dart';
import 'package:my_portfolio/core/shared_widget/loading_shimmer_list.dart';
import 'package:my_portfolio/core/shared_widget/nullable_network_image.dart';
import 'package:my_portfolio/features/child_flow/exams/download_upload/data_to_go_upload_exam.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/data_to_go_exams.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/domain/exams_entities/exam_entity.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/domain/exams_entities/result_exam_entity.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/shared_widget/custom_inkwell.dart';
import '../../../shared_features/subjects_shared_features/subjects_shared_features.dart';
import '../../home/home.dart';
import '../random_exams/random_exams.dart';

part 'data/exams_data_source/exams_remote_data_source.dart';
part 'data/exams_models/exam_model.dart';
part 'data/exams_models/result_exam_model.dart';
part 'data/exams_repository/exams_repository.dart';
part 'domain/exams_base_repository/exams_base_repository.dart';
part 'domain/exams_usecases/exams_usecase.dart';
part 'presentation/exams_screen/child_exams_screen.dart';
part 'presentation/exams_view_model/exams_bloc.dart';
part 'presentation/exams_view_model/exams_event.dart';
part 'presentation/exams_view_model/exams_state.dart';
part 'presentation/exams_widgets/exam_widget.dart';
part 'presentation/exams_widgets/subject_widget.dart';
part 'presentation/exams_widgets/title_widget.dart';
