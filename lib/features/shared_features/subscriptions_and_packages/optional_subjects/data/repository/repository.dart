import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';

import '../../../../../../config/base_repository/base_repository.dart';
import '../../domain/repository/repository.dart';
import '../data_source/add_optional_subject_datasource.dart';

@LazySingleton(as: AddOptionalSubjectRepository)
class AddOptionalSubjectRepositoryImpl implements AddOptionalSubjectRepository {
  final BaseRepository baseRepository;
  final AddOptionalSubjectDataSource addOptionalSubjectDataSource;

  AddOptionalSubjectRepositoryImpl(
      this.baseRepository,
      this.addOptionalSubjectDataSource,
      );


  @override
  Future<Either<Failure, String>> addOptionalSubject({required AddOptionalSubjectParameters addOptionalSubjectParameters}) async {
    return await baseRepository.checkExceptionForRemoteData(
      addOptionalSubjectDataSource.addOptionalSubject(addOptionalSubjectParameters: addOptionalSubjectParameters)
    );
  }
}