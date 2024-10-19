part of '../../parent_preview_for_child.dart';

@LazySingleton()
class GetParentPreviewForChildUseCase
    extends BaseUseCase<List<ParentPreviewForChildEntity>, NoParameter> {
  final ParentPreviewForChildBaseRepository repository;

  GetParentPreviewForChildUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ParentPreviewForChildEntity>>> call(
      parameter) async {
    return await repository.getAllParents();
  }
}
