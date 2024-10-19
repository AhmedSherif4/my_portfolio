
part of '../../terms_and_conditions.dart';

abstract class TermsAndConditionsBaseRepository {
  Future<Either<Failure, TermsAndConditionsEntity>> getTermAndCondition();
}
