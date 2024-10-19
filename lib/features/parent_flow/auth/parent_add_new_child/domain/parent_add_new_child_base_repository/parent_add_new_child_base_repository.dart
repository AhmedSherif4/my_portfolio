import 'package:dartz/dartz.dart';

import '../../../../../../core/failure/failure.dart';

abstract class ParentAddNewChildBaseRepository {
  Future<Either<Failure, String>> parentAddNewChild({
    required String mailOrPhone,
  });
}
