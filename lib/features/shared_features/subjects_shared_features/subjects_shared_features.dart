library subjects_shared_features;

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../config/base_local_data_source/base_local_data_source.dart';
import '../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../config/base_repository/base_repository.dart';
import '../../../config/storages/keys.dart';
import '../../../core/api/end_points.dart';
import '../../../core/enum/enum_generation.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../../my_app/app_reference.dart';
import '../../child_flow/home/data/home_models/subject_model.dart';
import '../../child_flow/home/domain/home_entities/subjects_entity.dart';
import '../../child_flow/questions/shared/data/go_to_question_parameter.dart';




part 'presentation/view_model/shared_subjects_bloc.dart';
part 'presentation/view_model/shared_subjects_event.dart';
part 'presentation/view_model/shared_subjects_state.dart';
part 'domain/base_repository/subjects_shared_features_base_repository.dart';
part 'domain/use_case/subjects_shared_features_use_case.dart';
part 'data/data_source/local/subjects_shared_features_local_data_source.dart';
part 'data/data_source/remote/subjects_shared_features_remote_data_source.dart';
part 'data/repository/subjects_shared_features_repository.dart';