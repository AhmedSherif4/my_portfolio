part of '../../parent_preview_for_child.dart';

abstract class ParentPreviewForChildBaseRepository {
  Future<Either<Failure, List<ParentPreviewForChildEntity>>> getAllParents();
}
