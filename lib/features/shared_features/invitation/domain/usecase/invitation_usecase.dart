import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../repository/invitation_repository.dart';


@LazySingleton()
class GetInvitationUseCase extends BaseUseCase<String, String>{
  final InvitationRepository _repository;
  GetInvitationUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(String parameter) async {
    return await _repository.getInvitation(parameter);
  }
}

