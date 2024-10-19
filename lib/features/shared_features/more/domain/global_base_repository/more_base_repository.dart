import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/failure/failure.dart';

abstract class MoreBaseRepository {
  Future<Either<Failure, bool>> logout();
}
