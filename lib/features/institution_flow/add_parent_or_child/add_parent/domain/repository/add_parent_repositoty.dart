import 'package:dartz/dartz.dart';

import '../../../../../../core/failure/failure.dart';
import '../use_case/add_parent_use_case.dart';

abstract class AddParentRepository {
  Future<Either<Failure, String>> addNewParent({
    required AddParentParameter addParentParameter,
  });
}
