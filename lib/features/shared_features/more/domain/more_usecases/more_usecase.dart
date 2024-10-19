import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import '../global_base_repository/more_base_repository.dart';


@LazySingleton()
class LogoutUseCase extends BaseUseCase<bool, NoParameter> {
  final MoreBaseRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParameter parameter) async {
    return await repository.logout();
  }
}

