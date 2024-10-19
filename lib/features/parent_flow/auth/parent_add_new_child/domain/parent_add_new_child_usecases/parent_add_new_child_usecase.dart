import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../parent_add_new_child_base_repository/parent_add_new_child_base_repository.dart';

@LazySingleton()
class ParentAddNewChildUseCase extends BaseUseCase<String, String> {
  final ParentAddNewChildBaseRepository repository;

  ParentAddNewChildUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(parameter) async {
    return await repository.parentAddNewChild(mailOrPhone: parameter);
  }
}
