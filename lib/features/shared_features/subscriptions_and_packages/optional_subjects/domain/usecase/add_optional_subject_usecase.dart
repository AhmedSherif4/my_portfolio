import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../repository/repository.dart';

@LazySingleton()
class AddOptionalSubjectUsecase
    extends BaseUseCase<String, AddOptionalSubjectParameters> {
  final AddOptionalSubjectRepository repository;

  AddOptionalSubjectUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(parameter) async {
    return await repository.addOptionalSubject(addOptionalSubjectParameters: parameter);
  }
}
