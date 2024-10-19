import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/optional_subject_bloc/optional_subject_bloc_event.dart';

import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../../../core/api/end_points.dart';
import '../../../../../../my_app/app_reference.dart';
import '../../domain/repository/repository.dart';

abstract class AddOptionalSubjectDataSource {
  Future<String> addOptionalSubject(
      {required AddOptionalSubjectParameters addOptionalSubjectParameters});
}

@LazySingleton(as: AddOptionalSubjectDataSource)
class AddOptionalSubjectDataSourceImpl implements AddOptionalSubjectDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  AddOptionalSubjectDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<String> addOptionalSubject(
      {required AddOptionalSubjectParameters
          addOptionalSubjectParameters}) async {
    final response = addOptionalSubjectParameters.addTo ==
            OptionalSubjectType.toClassroom
        ? AppReference.userIsChild()
            ? await baseRemoteDataSource
                .postData(url: EndPoints.addSubjectOptionalClassroom, body: {
                'terms': addOptionalSubjectParameters.termIds,
                'subjects': addOptionalSubjectParameters.subjectsIds,
              })
            : await baseRemoteDataSource.postData(
                url: '/api/parent/add/subject/optional/classroom',
                body: {
                    'terms': addOptionalSubjectParameters.termIds,
                    'subjects': addOptionalSubjectParameters.subjectsIds,
                    'child_id': addOptionalSubjectParameters.childId,
                  })
        : AppReference.userIsChild()
            ? await baseRemoteDataSource
                .postData(url: EndPoints.addSubjectOptionalTerm, body: {
                'term_id': addOptionalSubjectParameters.termIds.first,
                'subject_id': addOptionalSubjectParameters.subjectsIds.first,
              })
            : await baseRemoteDataSource
                .postData(url: '/api/parent/add/subject/optional/term', body: {
                'term_id': addOptionalSubjectParameters.termIds.first,
                'subject_id': addOptionalSubjectParameters.subjectsIds.first,
                'child_id': addOptionalSubjectParameters.childId,
              });

    return response['message'];
  }
}
