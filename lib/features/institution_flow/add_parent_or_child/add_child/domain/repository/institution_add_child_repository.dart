part of '../../add_child.dart';


abstract class InstitutionAddChildRepository {
  Future<Either<Failure, String>> institutionAddChild({
    required InstitutionAddChildParameter addChildParameter,
  });
}
